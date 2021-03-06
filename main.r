library(RJSONIO)
library(XML)
library(knitr)
library(ggplot2)
library(scales)
library(sets)

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

pretty.levels <- function(x, y) { UseMethod('pretty.levels')}
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

preview.companies.candidates.html <- as.character((subset(candidates.html, preview.company)$name))
preview.companies.preview.html <- sapply(preview.html,
  function(x){xmlValue(xpathApply(x, 'descendant::div[@class="m-preview-list-name"]/strong/text()')[[1]])})
preview.companies.csv <- unique(preview.csv$CompanyName)
preview.companies.json <- sapply(preview.json, function(x){x$companyName})

d <- cset(preview.companies.candidates.html, preview.companies.csv)

p <- (function(){
  candidates.html$preview.company <-
    factor(candidates.html$preview.company, levels = c(TRUE,FALSE))
  levels(candidates.html$preview.company) <- c('Yes','No')

  candidates.html$survey.company <-
    factor(candidates.html$survey.company, levels = c(TRUE,FALSE))
  levels(candidates.html$survey.company) <- c('Yes','No')

  ggplot(candidates.html) + aes(x = survey.company, fill = preview.company) +
    scale_fill_discrete('Is the company listed as a preview company\nin the preview HTML file') +
    scale_x_discrete('Did the company complete the questionnaire?') +
    scale_y_continuous('Number of companies') +
    theme(legend.position = 'bottom') +
    geom_bar() +
    ggtitle('Are the preview companies simply the companies who have responded to the questionnaire?')
})()

exports <- list(
  datasets.json = datasets.json,
  preview.csv = preview.csv,
  preview.html = preview.html,
  preview.json = preview.json,
  candidates.csv = candidates.csv,
  candidates.html = candidates.html
)

# knit('dictionary.Rmd')


# library(devtools)
# install_github("RODProt", "QBRC")

# library(RODProt)
# read_data_package('./datapackage.json')
# open.data.500 <- read_data_package('./datapackage.json')
# companies <- get_resource(open.data.500, 'companies', overlook.types = TRUE)
# datasets <- get_resource(open.data.500, 'datasets', overlook.types = TRUE)

# companies <- read.csv('companies.csv', stringsAsFactors = FALSE)
# datasets <- read.csv('datasets.csv', stringsAsFactors = FALSE)
companies$n.datasets <- nchar(gsub('[^\n]','', companies$datasets)) - 1

datasets$dataset.hostname <- sub('^(?:http://|ftp://|https://)?([^/]*)/?.*$', '\\1', datasets$dataset.url)
url.is.na <- !grepl('\\.', datasets$dataset.url)
datasets$dataset.hostname[url.is.na] <- NA
datasets$dataset.url[url.is.na] <- NA

datasets$company.hostname <- sub('^(?:http://|ftp://|https://)?([^/]*)/?.*$', '\\1', datasets$company.url)

library(plyr)
companies.with.hostnames <- ddply(datasets, 'company.href', function(datasets){
  companies <- datasets[1,]
  companies$unique.dataset.hostnames = length(unique(datasets$dataset.hostname))
  companies$datasets = length((datasets$dataset.hostname))
  companies
})
p.hostnames <- ggplot(companies.with.hostnames) +
  aes(x = unique.dataset.hostnames) +
  geom_histogram() +
  xlab('Number of different website hostnames') +
  ylab('Number of companies')

df <- ddply(companies.with.hostnames, c('datasets','unique.dataset.hostnames'), function(df) { c(companies = nrow(df)) })
p.hostnames.datasets <- ggplot(df) +
  aes(x = datasets, y = unique.dataset.hostnames, size = companies) +
  geom_point(size = 10)

p.fte.datasets <- ggplot(companies) +
  aes(y = n.datasets, x = fte, label = company.name) +
  scale_x_continuous('Number of full-time employees', labels = comma) +
  scale_y_continuous('Number datasets reported', labels = comma) +
# geom_point(size = 10)
  ggtitle('Larger companies don\'t report more datasets.') +
  geom_text()

p.priorities <- ggplot(companies) +
  aes(x = nchar(social.impact), y = nchar(financial.info)) +
  geom_point() + coord_fixed() + geom_abline(slope = 1) +
  ggtitle('How much they write about social and financial things')

library(sqldf)
non.gov <- sqldf('SELECT company_name, count(*) FROM datasets WHERE dataset_url NOT LIKE \'%.gov%\' group by company_href order by 2')
own.data <- subset(datasets, company.hostname == dataset.hostname)[c('company.name','dataset.name')]

# subset(companies, data.collection == 'questionnaire')$location
