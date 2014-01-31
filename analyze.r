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
  ids <- data.frame(
    companyName = sapply(x, function(y){y$companyName}),
    companyID = sapply(x, function(y){y$companyID})
  )
  # This doesn't work because the unique identifier column is not unique.
  merge(ids, od500.csv('500_Companies.csv'), by.x = 'CompanyName', by.y = 'CompanyName')
}

pretty.levels <- function(x) { UseMethod('pretty.levels')}
pretty.levels.character <- function(vec) {
  paste(sort(unique(vec)), collapse = ', ')
}
pretty.levels.list <- function(thelist, thefield) {
  paste(sort(unique(c(sapply(thelist, function(x){x[[thefield]]})))), collapse = ', ')
}

datasets.json <- read.datasets()
preview.csv <- od500.csv('Preview50_Companies.csv')
preview.json <- od500.json('OD500_Companies.json')
candidates.csv <- od500.csv('500_Companies.csv')

# candidates <- read.candidates()

# Identifiers are unique:
# unique(Reduce(function(a,b){c(a,b$datasets)}, preview.json, c()))

# knit(
