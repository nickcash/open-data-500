library(RJSONIO)

od500.csv <- function(filename){
  read.csv(
    file.path('download', filename),
    stringsAsFactors = FALSE)
}

od500.json <- function(filename){
  fromJSON(file.path('download', filename))
}

read.datasets <- function() {
  datasets <- od500.json('OD500_Datasets.json')
  datasets[154][[1]]$usedByCompany <- NA
  datasets[155][[1]]$usedByCompany <- NA
  datasets.mat <- sapply(datasets, function(d) {data.frame(d, stringsAsFactors = FALSE)})
  datasets.df.1 <- data.frame(t(datasets.mat), stringsAsFactors = FALSE)
  datasets.df.2 <- data.frame(lapply(datasets.df.1, unlist), stringsAsFactors = FALSE)
  datasets.df.2
}

read.candidates <- function() {
  x <- od500.json('OD500_Companies.json')
  candidates.mat <- sapply(candidates, function(x) {
    x$sector <- NULL
    data.frame(x, stringsAsFactors = FALSE)}
  )
  candidates.df.1 <- data.frame(candidates.mat, stringsAsFactors = FALSE)
  candidates.df.2 <- data.frame(lapply(candidates.df.1, unlist), stringsAsFactors = FALSE)
  rownames(candidates.df.2) <- candidates.df.2$CompanyName
  candidates.df.2
}

# candidates.csv <- od500.csv('500_Companies.csv')
# datasets <- read.datasets()
# preview <- od500.csv('Preview50_Companies.csv')
candidates <- read.candidates()
