# trevoR

![hexLogo](/man/figures/hexLogo.png)

trevoR is currently only dependent on the purrr package.

## :writing_hand: Author

Trevor French <https://trevorfrench.com>

## :arrow_double_down: Installation

Install the trevoR package via CRAN:


```r
#NOT YET AVAILABLE VIA CRAN
```

You can also install the package via the Github repository.


```r
install.packages("remotes")
remotes::install_github("TrevorFrench/trevoR")
```

## Functions: 

breakFile, breakRow, breakFraction

### breakFile(input, output, n, filename, method)
- input: the file path/name of the csv you wish to break.
- output: the folder where your broken files will be written to.
- n: the number of rows you want your file to contain if your method is "row" or the number of files you want your original file broken into if your method is "fraction".
- filename: the name of your output files (iterative numbers will be appended to this filename)
- method: can either be "row" or "fraction".
- The following example demonstrates a file named "Budget.csv" being broken into smaller files, each containing a thousand rows:
```r
#SET WORKING DIRECTORY
wd <- "C:/YOURFILEPATH/"

#SET INPUT FILE
dataSource <- paste(wd, "Input/Budget.csv", sep='')

#SET OUTPUT FOLDER
outwd <- paste(wd, "Output/Budget/", sep='')

breakFile(dataSource, outwd, 1000, "Budget", "row")
```

### breakRow(input, output, n, filename)
- input: the file path/name of the csv you wish to break.
- output: the folder where your broken files will be written to.
- n: the number of rows you want your broken files to contain.
- filename: the name of your output files (iterative numbers will be appended to this filename)
- The following example demonstrates a file named "Budget.csv" being broken into smaller files, each containing a thousand rows:
```r
#SET WORKING DIRECTORY
wd <- "C:/YOURFILEPATH/"

#SET INPUT FILE
dataSource <- paste(wd, "Input/Budget.csv", sep='')

#SET OUTPUT FOLDER
outwd <- paste(wd, "Output/Budget/", sep='')

breakRow(dataSource, outwd, 1000, "Budget")
```

### breakFraction(input, output, n, filename)
- input: the file path/name of the csv you wish to break.
- output: the folder where your broken files will be written to.
- n: the number of files you want your original file broken into.
- filename: the name of your output files (iterative numbers will be appended to this filename)
- The following example demonstrates a file named "Budget.csv" being broken into three smaller files:
```r
#SET WORKING DIRECTORY
wd <- "C:/YOURFILEPATH/"

#SET INPUT FILE
dataSource <- paste(wd, "Input/Budget.csv", sep='')

#SET OUTPUT FOLDER
outwd <- paste(wd, "Output/Budget/", sep='')

breakFraction(dataSource, outwd, 3, "Budget")
```

### combineFiles(input)
- input: the file path which contains the directory where your files are stored.
- The following example demonstrates all csv files in a specified directory into one dataframe:
```r
wd <- "C:/YOURWORKINGDIRECTORY"
combineFiles(wd)
```


## ACTION LIST
- Add "filetype" support (excel files, test files, etc.)
- Add "arrange" support (arrange the file by column desc/asc before breaking)
- Add filetype support for combineFiles

## Logo

Logo was created with [hexSticker](https://github.com/GuangchuangYu/hexSticker).
