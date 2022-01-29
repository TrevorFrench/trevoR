#-------------------------------------------------------------------------------
#-----------------------------------ACTION LIST---------------------------------
#-------------------------------------------------------------------------------
#-Add "filetype" support (excel files, test files, etc.)
#-Add "arrange" support (arrange the file by column desc/asc before breaking)
#-Add Combine File functions
#-------------------------------------------------------------------------------
#---------------------BREAK FILE BY NUMBER OF ROWS PER FILE---------------------
#-------------------------------------------------------------------------------
#filetype,
#, arrange

breakFile <- function(input, output, n, filename, method) {
  if(method == "row") {
    breakRow(input, output, n, filename)
  }

  if(method == "fraction") {
    breakFraction(input, output, n, filename)
  }

  if(method != "row" && method != "fraction") {
    print("Method is either not specified or not recognized. Please choose either 'row' or 'fraction'.")
  }

}

breakRow <- function(input, output, n, filename) {
  rawData <- read.csv(input)
  numRows <- nrow(rawData)
  splitRows <- if_else((numRows / n) > 1, ceiling((numRows / n)), 1)

  begNum <- 1

  for (i in 1:splitRows) {
    endNum <- i * n

    if(i == splitRows){
      endNum <- as.double(numRows)
    }

    df <- rawData[c(begNum:endNum),]

    #Set output file here
    outputFile <- paste(output, filename, i,".csv", sep='')

    #Writes output file
    write.csv(df, outputFile, row.names = FALSE)

    df <- NULL

    begNum <- begNum + n

  }

}

breakFraction <- function(input, output, n, filename) {
  rawData <- read.csv(input)
  numRows <- nrow(rawData)
  splitRows <- round(numRows / n, digits = 0)

  begNum <- 1

  for (i in 1:(n-1)) {
     endNum <- splitRows * i
     df <- rawData[c(begNum:endNum),]

     #Set output file here
     outputFile <- paste(output, filename, i,".csv", sep='')

     #Writes output file
     write.csv(df, outputFile, row.names = FALSE)

     df <- NULL
     begNum <- begNum + splitRows

   }

   begNum = (splitRows * (n-1)) + 1
   df <- rawData[c(begNum:numRows),]
   outputFile <- paste(output, filename, n,".csv", sep='')
   #Writes output file
   write.csv(df, outputFile, row.names = F)

}

#breakbyfraction
#breakbyrow

#Reads in raw data file
wd <- "C:/Users/Trevor French/OneDrive - TaxBit/Desktop/R Scripts/Files/"

#READ CSV
dataSource <- paste(wd, "Input/Gemini.csv", sep='')
outwd <- paste(wd, "Input/testpackage/", sep='')
