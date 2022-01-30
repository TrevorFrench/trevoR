#-------------------------------------------------------------------------------
#-----------------------------------ACTION LIST---------------------------------
#-------------------------------------------------------------------------------
#-Add "filetype" support (excel files, test files, etc.)
#-Add "arrange" support (arrange the file by column desc/asc before breaking)
#-Add Combine File functions
#-------------------------------------------------------------------------------
#------------------------BREAK FILE BY ROWS OR BY FRACTION----------------------
#-------------------------------------------------------------------------------

#' breakFile
#'
#' @param input the file path/name of the csv you wish to break.
#' @param output the folder where your broken files will be written to.
#' @param n the number of rows you want your file to contain if your method is "row" or the number of files you want your original file broken into if your method is "fraction".
#' @param filename the name of your output files. Iterative numbers will be appended to this filename.
#' @param method can either be "row" or "fraction".
#'
#' @return returns files written to specified directory.
#' @export
#'
#' @examples
#' \dontrun{
#' # SET WORKING DIRECTORY
#' wd <- "C:/YOURFILEPATH/"
#'
#' # SET INPUT FILE
#' dataSource <- paste(wd, "Input/Budget.csv", sep='')
#'
#' # SET OUTPUT FOLDER
#' outwd <- paste(wd, "Output/Budget/", sep='')
#'
#' breakFile(dataSource, outwd, 1000, "Budget", "row")}

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

#-------------------------------------------------------------------------------
#----------------------BREAK FILE BY NUMBER OF ROWS PER FILE--------------------
#-------------------------------------------------------------------------------

#' breakRow
#'
#' @param input the file path/name of the csv you wish to break.
#' @param output the folder where your broken files will be written to.
#' @param n the number of rows you want your broken files to contain.
#' @param filename the name of your output files. Iterative numbers will be appended to this filename.
#'
#' @return returns files written to specified directory.
#' @export
#'
#' @examples
#' \dontrun{
#' #SET WORKING DIRECTORY
#' wd <- "C:/YOURFILEPATH/"
#'
#' #SET INPUT FILE
#' dataSource <- paste(wd, "Input/Budget.csv", sep='')
#'
#' #SET OUTPUT FOLDER
#' outwd <- paste(wd, "Output/Budget/", sep='')
#'
#' breakRow(dataSource, outwd, 1000, "Budget")}
breakRow <- function(input, output, n, filename) {
  rawData <- read.csv(input)
  numRows <- nrow(rawData)

  splitRows <- 1

  if((numRows / n) > 1){
    splitRows <- ceiling((numRows / n))
  }

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

#-------------------------------------------------------------------------------
#----------------------BREAK FILE BY NUMBER OF FILES DESIRED--------------------
#-------------------------------------------------------------------------------

#' breakFraction
#'
#' @param input the file path/name of the csv you wish to break.
#' @param output the folder where your broken files will be written to.
#' @param n the number of files you want your original file broken into.
#' @param filename the name of your output files. Iterative numbers will be appended to this filename.
#'
#' @return returns files written to specified directory.
#' @export
#'
#' @examples
#' \dontrun{
#' #SET WORKING DIRECTORY
#' wd <- "C:/YOURFILEPATH/"
#'
#' #SET INPUT FILE
#' dataSource <- paste(wd, "Input/Budget.csv", sep='')
#'
#' #SET OUTPUT FOLDER
#' outwd <- paste(wd, "Output/Budget/", sep='')
#'
#' breakFraction(dataSource, outwd, 3, "Budget")}
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

#-------------------------------------------------------------------------------
#-------------------------COMBINE ALL FILES IN A DIRECTORY----------------------
#-------------------------------------------------------------------------------
#' combineFiles
#'
#' @param input the working directory where your files are located.
#'
#' @return returns a dataframe named 'df' containing all of your combined files.
#' @export
#'
#' @examples
#' \dontrun{
#' wd <- "C:/YOURWORKINGDIRECTORY"
#' combineFiles(wd)}
combineFiles <- function(input) {

  setwd(input)

  files <- list.files(pattern="*.csv")

  df <- files %>% map_dfr(read.csv)

  return(df)

}
