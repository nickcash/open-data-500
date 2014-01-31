library(RJSONIO)
library(XML)

od500.csv <- function(filename){
  read.csv(
    file.path('download', filename),
    stringsAsFactors = FALSE)
}

od500.json <- function(filename){
  fromJSON(file.path('download', filename))
}

od500.html <- function(filename) {
  htmlParse(file.path('www.opendata500.com',filename,'index.html'))
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
preview.xpath <- '//ul[@class="m-preview-list"]/li[@class="m-list-company"]'
preview.html <- xpathApply(od500.html('preview'), preview.xpath)

candidates.xpath <- '//div[@class="m-candidates isotopes-container"]/div'
candidates.html.nodes <- xpathApply(od500.html('candidates'), candidates.xpath)
candidates.html.field <- function(xpath, func = identity){
  x <- lapply(candidates.html.nodes, function(e){xpathApply(e, xpath)[[1]]})
  sapply(x, func)
}

candidates.parent.xpath <- '//div[@class="m-candidates isotopes-container"]'
candidates.parent.html <- xpathApply(od500.html('candidates'), candidates.parent.xpath)[[1]]

preview.company.xpath <- 'contains(@class, "preview-company")'
survey.company.xpath <- 'contains(@class, "survey-company")'

candidates.html <- data.frame(
  name = candidates.html.field('a/h3/strong/text()', xmlValue),
  city = candidates.html.field('p[@class="m-homepage-list-location"]/text()', xmlValue),
  func = candidates.html.field('em/text()', xmlValue),
  desc = candidates.html.field('p[@class="m-homepage-list-desc"]/text()', xmlValue),
  preview.company = candidates.html.field(preview.company.xpath),
  survey.company = candidates.html.field(survey.company.xpath),
  href = candidates.html.field('a/@href')
)
# xpathApply(candidates.parent.html, 'div[contains(@class, "preview-company")]')
  

# candidates <- read.candidates()

# Identifiers are unique:
# unique(Reduce(function(a,b){c(a,b$datasets)}, preview.json, c()))

# knit(


preview.companies.candidates.html <- as.character((subset(candidates.html, preview.company)$name))
preview.companies.preview.html <- sapply(preview.html,
  function(x){xmlValue(xpathApply(x, 'descendant::div[@class="m-preview-list-name"]/strong/text()')[[1]])})
preview.companies.csv <- preview.csv$CompanyName
preview.companies.json <- sapply(preview.json, function(x){x$companyName})

exports <- list(
  datasets.json = datasets.json,
  preview.csv = preview.csv,
  preview.html = preview.html,
  preview.json = preview.json,
  candidates.csv = candidates.csv,
  candidates.html = candidates.html
)
