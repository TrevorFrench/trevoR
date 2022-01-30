\name{trevoR}
\alias{trevoR}
\title{trevoR}
\usage{
breakFiles(),
breakRow(),
breakFraction()
}
\description{
Provides support for breaking CSV files by either row count or fractions.
More functions are forthcoming.
}
\examples{
breakFile(dataSource, outwd, 3, filename = "Budget", "fraction"),
breakFile(dataSource, outwd, 100, filename = "Budget", "row"),
breakRow(dataSource, outwd, 100, filename = "Budget"),
breakFraction(dataSource, outwd, 3, filename = "Budget")
}
