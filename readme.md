---
title: A data dictionary of the Open Data 500 data
---
The [Open Data 500](http://www.opendata500.com/download/) is
"the first comprehensive study of U.S. companies using open government data to develop new products and services."
You may have read about it in.
[Forbes](http://www.forbes.com/sites/bethsimonenoveck/2014/01/08/from-faith-based-to-evidence-based-the-open-data-500-and-understanding-how-open-data-helps-the-american-economy/),
[Information Week](http://www.informationweek.com/government/open-government/open-government-data-companies-cash-in/d/d-id/1113143), or
[Fedscoop](http://fedscoop.com/open-data-500-intersection-open-data-economy/)
This is [data about open data](/open-data), so I naturally wanted it.
In the present article, I explain a bit about how the study is being conducted
and how the data are presented for download.

## Data collection methods
The Open Data 500 looks a bit scary and complicated when you read its website
and the articles about it, but the Open Data 500 is pretty much just a
straightforward questionnaire survey.

### The population of interest
The Open Data 500 Team is interested in companies that meet their
[eligibility criteria](http://www.opendata500.com/about/#about-eligibility),
which they describe as follows.

1. Be U.S.-based – which can include international companies with a major presence in the U.S.
2. Earn revenue from its products and services. In addition to for-profit companies, nonprofits may qualify if they support themselves primarily through sales of products and services rather than philanthropy.
3. Use open government data as a critical resource for its business. (While most Open Data 500 companies will work with federal data, the study will also include some that use city or state data if their work can scale regionally or nationally)

The Open Data 500 site does not explain how they operationalize these criteria,
but I presume that it works as follows.

1. The questionnaire must indicate that a company has a major presence in the U.S.
2. The answer to "Which of the following are significant sources of revenue for your company?"
  must include something other than "Philanthropy".
3. The answer to "Which of the following are critical sources of data for your company?"
  must include "Federal Open Data", the questionnaire must indicate elsewhere that
  the company is using state or city data from a range of states or cities.

They are "[vetting](http://www.opendata500.com/about/#about-vetted)" companies,
but this sounds like just a conversation with the submitters to check that they
understood the questionnaire properly.

### Sampling strategy
The Open Data 500 uses a sampling strategy that they term "comprehensive call".
That sounds really complicated, but it's actually quite simple.

The questionnaire results can be considered a convenience sample
[convenience sample](http://en.wikipedia.org/wiki/Accidental_sampling)
of companies that meet the Open Data 500 eligibility criteria.

The Open Data 500 Team distributed links to the questionnaire in
[these places](http://www.opendata500.com/about/#about-identify).

* Recommendations from government and non-governmental organizations studying this field.
* List of companies using datasets from Data.gov, the federal hub for government data
* Online Open Data Userbase created by Socrata
* Directory of open data companies developed by Deloitte
* Mass email to 3100 people in the GovLab network
* Mass email to 2200 people on contact list for OpenDataNow.com, website of Open Data 500 project director Joel Gurin
* Companies identified in research for upcoming book, Open Data Now
* Response to coverage of the Open Data 500 in Information Week and FedScoop
* Outreach through Twitter
* Outreach at "Data Transparency 2013" conference (September 2013, Washington, DC)
* Blog posts on TheGovLab.org and OpenDataNow.com

And that's it!

I think their use of comprehensive call is why the Open Data 500 Team considers
the Open Data 500 to be a comprehensive study.

### Case study
The Open Data 500 has released data in the
"[download]()",
"[preview](http://www.opendata500.com/preview/)",
"[full list](http://www.opendata500.com/candidates/)" sections.
These data are the straightforward questionnaire results (with one [quirk](#questionnaire-and-non-questionnaire-responses))
for the companies that met their eligibility criteria.
Thus, the Open Data 500 is a [case study](http://en.wikipedia.org/wiki/Case_study)
of companies that meet the Open Data 500 eligibility criteria.

### Questionnaire and non-questionnaire responses
Open Data 500 Team solicited responses to
[this questionnaire](http://www.opendata500.com/submitCompany/) through
[comprehensive call](#sampling strategy), but they also looked for companies
that did not respond to the questionnaire; the Team effectively filled out
parts of this questionnaire for companies who did not respond.

## Just a questionnaire
This is the main thing that confused me about the study, so I'm going to
explain this part in a bit more depth in case anyone else was also confused.

The data collection for the Open Data 500 is just the questionnaire. Really.
For example, the Team isn't looking at companies products to see which open data
are used, and it isn't looking at annual reports to determine whether the
company does a lot of business in the United States. This is confusing because
the data releases do not look like the questionnaire, but I'm pretty sure that
the data come rather directly from the questionnaire.

### Pre-launch
According to the "[About](http://www.opendata500.com/about)" page on the
Open Data 500 site, the Open Data 500 "will identify, describe, and analyze
companies that use open government data in their businesses."

As I understand it, the analysis component of this has yet to occur.
At the moment, the Open Data 500 is in "pre-launch". This means that they have
begun to collect data but that they haven't done any sort of analysis on it.
(This part isn't explained on the website, but a member of the Open Data 500
Team explained this to me in person.)

## Data files
The Open Data 500 Team has released six main data files.

* [`Preview50_Companies.csv`](http://www.opendata500.com/download/Preview50_Companies.csv)
* [`500_Companies.csv`](http://www.opendata500.com/download/500_Companies.csv)
* [`OD500_Companies.json`](http://www.opendata500.com/download/OD500_Companies.json)
* [`OD500_Datasets.json`](http://www.opendata500.com/download/OD500_Datasets.json)
* [`preview`](http://www.opendata500.com/preview/) (HTML)
* [`candidates`](http://www.opendata500.com/candidates/) (HTML)

There are also individual pages about each company, but I'm pretty sure that
the only extra information on those is comments submitted through the comment
forms.

### Preview50_Companies.csv
[`Preview50_Companies.csv`](http://www.opendata500.com/download/Preview50_Companies.csv)
is a denormalized CSV file with
`r ncol(preview.csv) columns and `r nrow(preview.csv)` rows.
Each row corresponds to a dataset within a company, and
each column corresponds to a question from the
[questionnaire](http://www.opendata500.com/submitCompany/).
`r length(unique(preview.csv$CompanyName))` different companies are
represented in this dataset.

The column names in this file correspond quite closely to the name
attributes in the HTML form source code for the questionnaire.

These columns describe the companies, and they are identical across different
rows about the same company. 

Code in the file        | Question from the questionnaire
----------------------- | -------------------------------
`CompanyName`           | Name of your company
`URL`                   | Company URL
`city`                  | In which city is this company located?
`STATE`                 | State [1]
`abbrev`                | State [1]
`zipCode`               | Zip Code
`ceoFirstName`          | First Name of CEO
`ceoLastName`           | Last Name of CEO
`companyPreviousName`   | ???
`yearFounded`           | Founding Year
`FTE`                   | Number of FTE's [2]
`companyType`           | Type of Company (`r pretty.levels(preview.csv$companyType)`) [3]
`companyCategory`       | What category best describes your company? (`r pretty.levels(preview.csv$companyCategory)`) [1]
`companyFunction`       | Which best describes the function of your company? (`r pretty.levels(preview.csv$companyFunction)`) [3]
`sectors`               | What category best describes your company? (`r pretty.levels(preview.csv$sectors)`) [1,3]
`revenueSource`         | Which of the following are significant sources of revenue for your company? [4]
`descriptionLong`       | Please give us a short public statement describing your company’s mission and work. You can take this material from your website or other publications if you choose to.
`descriptionShort`      | As a summary, please provide a one sentence description of your company.
`socialImpact`          | Besides revenue generation, how do you measure the impact your company has for society and the public good? 
`financialInfo`         | Please include any financial or operational information that will help us understand your company. We are interested in specific information like past and projected annual revenues, total outside investment dollars to date, and significant investors or partners. 
`criticalDataTypes`     | Which of the following are critical sources of data for your company? By “critical,” we mean that your company would have to shut down a line of business, shut down completely, or replace the data in some way if the data were no longer available.

It does not include the following questions from that first page of the questionnaire.

Code from the web form  | Question from the questionnaire
----------------------- | -------------------------------
`firstName`             | First Name [5]
`lastName`              | Last Name
`title`                 | Title
`email`                 | Email
`phone`                 | Phone
`contacted`             | Please check here if you would be willing to be contacted for further information about your company.
`datasetWishList`       | What datasets (if any) are not currently available that would be useful for your company to have as government open data? 
`companyRec`            | What other companies, either in your sector or other sectors, would you recommend we contact regarding their use of government open data? 
`conferenceRec`         | What conferences or events do you think would be helpful to us in surveying the field of open data companies? 

The following columns come from the
["New Dataset"](http://www.opendata500.com/addData/52eb5431def7fa00029abc8f/)
page of the questionnaire.

Code in the file        | Question from the questionnaire
----------------------- | -------------------------------
`datasetName`           | Name of Dataset
`datasetURL`            | URL of Dataset
`agencyOrDatasetSource` | Agency or Source

The file does not include the following columns from the "New Dataset" page.

Code from the web form  | Question from the questionnaire
----------------------- | -------------------------------
`typeOfDataset`         | Type of Dataset (Federal Open Data, State Open Data, City/Local Open Data, Other)
`rating`                | On a scale of 1 to 4, how would you rate the usefulness of this dataset? (1- poor, 4- excellent) Your answer can reflect your experience with data quality, format of the data, or other factors.
`reason`                | Why did you give it this rating?

Finally, there is also a `DATASETS` column, which is the number of datasets
submitted for the particular the company.

You can think of this file as a CSV version of `OD500_Companies.json`.

<!-- all(unique(sort(preview.csv$CompanyName)) == sort(sapply(candidates.json, function(x){x$companyName}))) -->

Notes:

1. In some cases, answers to one question are presented redundantly across
    multiple columns.
2. "FTE" probably stands for "full-time equivalent employees".
3. The questionnaire has different categories from the levels reported in
    this file.
4. This cell contains a comma-and-space (`, `) delimited list of items,
    and I haven't picked apart the lists to find all of the possible values
    in the list.
5. This is from the "Personal Information" section, which presumably
    describes the person who is filling out the questionnaire.

### 500_Companies.csv
[`500_Companies.csv`](http://www.opendata500.com/download/500_Companies.csv)
is a CSV file with
`r ncol(candidates.csv) columns and `r nrow(candidates.csv)` rows.
Each row corresponds to a unique company, and
each column corresponds to a question from the
[questionnaire](http://www.opendata500.com/submitCompany/).

Code in the file        | Question from the questionnaire
----------------------- | -------------------------------
`CompanyName`           | Name of your company
`URL`                   | Company URL
`city`                  | In which city is this company located?
`STATE`                 | State
`abbrev`                | State
`zipCode`               | Zip Code
`companyCategory`       | What category best describes your company? (`r pretty.levels(preview.csv$companyCategory)`)
`descriptionShort`      | As a summary, please provide a one sentence description of your company.

This file provides no data about datasets used by the companies.

### OD500_Companies.json
[`OD500_Companies.json`](http://www.opendata500.com/download/OD500_Companies.json)
is a JSON file with an array of associative arrays (that is, a list of mappings).
It has `r length(preview.json)` rows (associative ararys) and 
`r unique(sapply(preview.json, length))` columns (items per associative array).
Each row corresponds to a unique company,
and each column corresponds to a questionnaire question.

Code in the file        | Question from the questionnaire
----------------------- | -------------------------------
`companyName`           | Name of your company
`url`                   | Company URL
`city`                  | In which city is this company located?
`state`                 | State [1]
`zipCode`               | Zip Code
`ceoFirstName`          | First Name of CEO
`ceoLastName`           | Last Name of CEO
`previousName`          | ???
`yearFounded`           | Founding Year
`fte`                   | Number of FTE's [2]
`companyType`           | Type of Company (`r pretty.levels(preview.json, 'companyType')`) [3]
`companyCategory`       | What category best describes your company? (`r pretty.levels(preview.json, 'companyCategory')`) [1]
`companyFunction`       | Which best describes the function of your company? (`r pretty.levels(preview.json, 'companyFunction')`) [3]
`sector`                | What category best describes your company? (`r pretty.levels(preview.json, 'sectors')`) [1,3]
`revenueSource`         | Which of the following are significant sources of revenue for your company? 
`descriptionLong`       | Please give us a short public statement describing your company’s mission and work. You can take this material from your website or other publications if you choose to.
`descriptionShort`      | As a summary, please provide a one sentence description of your company.
`socialImpact`          | Besides revenue generation, how do you measure the impact your company has for society and the public good? 
`soccialInfo`           | Please include any financial or operational information that will help us understand your company. We are interested in specific information like past and projected annual revenues, total outside investment dollars to date, and significant investors or partners. 
`criticalDataTypes`     | Which of the following are critical sources of data for your company? By “critical,” we mean that your company would have to shut down a line of business, shut down completely, or replace the data in some way if the data were no longer available.

<!-- subset(preview.csv, CompanyName == 'BillGuard')[1,'financialInfo'] == preview.json[[3]]$socialInfo -->

It does not include the following questions from that first page of the questionnaire.

Code from the web form  | Question from the questionnaire
----------------------- | -------------------------------
`firstName`             | First Name [4]
`lastName`              | Last Name
`title`                 | Title
`email`                 | Email
`phone`                 | Phone
`contacted`             | Please check here if you would be willing to be contacted for further information about your company.
`datasetWishList`       | What datasets (if any) are not currently available that would be useful for your company to have as government open data? 
`companyRec`            | What other companies, either in your sector or other sectors, would you recommend we contact regarding their use of government open data? 
`conferenceRec`         | What conferences or events do you think would be helpful to us in surveying the field of open data companies? 

In addition to the 20 columns I describe above, there are two columns for
identificatiers. One is the `companyId` column, which is the unique
identifier for the particular company. Within the questionnaire, this shows up
inside the URL for the
["New Dataset"](http://www.opendata500.com/addData/52eb5431def7fa00029abc8f/)
page.

    http://www.opendata500.com/addData/$companyId/

The other is the `datasets` column, which lists identification codes
for datasets (like  `r preview.json[[1]]$datasets[1]`) and references the
`datasetID` column in `OD500_Datasets.json`.

You can think of this file as a JSON version of`Preview50_Companies.csv`.

<!-- all(unique(sort(preview.csv$CompanyName)) == sort(sapply(candidates.json, function(x){x$companyName}))) -->

Notes:

1. In some cases, answers to one question are presented redundantly across
    multiple columns.
2. "FTE" probably stands for "full-time equivalent employees".
3. The questionnaire has different categories from the levels reported in
    this file.
4. This is from the "Personal Information" section, which presumably
    describes the person who is filling out the questionnaire.

### OD500_Datasets.json
[`OD500_Datasets.json`](http://www.opendata500.com/download/OD500_Datasets.json)
is a JSON file with an array of associative arrays (that is, a list of mappings).
It has `r length(preview.json)` rows (associative ararys) and 
`r unique(sapply(preview.json, length))` columns (items per associative array).
Each row corresponds to a dataset. Three of the columns correspond directly to
questionnaire questions.

The following columns come from the
["New Dataset"](http://www.opendata500.com/addData/52eb5431def7fa00029abc8f/)
page of the questionnaire.

Code in the file        | Question from the questionnaire
----------------------- | -------------------------------
`datasetName`           | Name of Dataset
`datasetURL`            | URL of Dataset
`source`                | Agency or Source

The file does not include the following columns from the "New Dataset" page.

Code from the web form  | Question from the questionnaire
----------------------- | -------------------------------
`typeOfDataset`         | Type of Dataset (Federal Open Data, State Open Data, City/Local Open Data, Other)
`rating`                | On a scale of 1 to 4, how would you rate the usefulness of this dataset? (1- poor, 4- excellent) Your answer can reflect your experience with data quality, format of the data, or other factors.
`reason`                | Why did you give it this rating?

The file also contains two identifier columns. identificatiers.
One is the `datasetID` column, which serves as a primary key for this table.
The other is the `usedByCompany` column, which references the `companyId`
in `OD500_Companies.json`,

### preview (HTML)
[`preview`](http://www.opendata500.com/preview/) is an HTML page
containing a non-standard representation of a data table about companies.

The companies are represented as a nodes with the following XPath.

```{r}
preview.xpath
```

The file contains `r length(preview.html)` companies and about 11 fields
(depending on your definition of a field). The fields are approximately
a subset of the fields for `Preview50_Companies.csv`.

I don't feel like writing out selectors for every field within each company
node, but you can figure it out by looking at the code for the first company.

```{r}
preview.html[[1]]
```

I do want to point out the dataset nodes in particular. Each company node lists
zero or more datasets, each with a URL and a title. Here is how you query them.

```{r}
df <- data.frame(
  urls = xpathApply(preview.html[[1]], 'div[@class="m-list-company-full"]/div[@class="m-full datasets"]/ul/li/a/@href')
  titles = xpathApply(preview.html[[1]], 'div[@class="m-list-company-full"]/div[@class="m-full datasets"]/ul/li/a/text()')  
)
kable(df)
```

### candidates (HTML)
[`candidates`](http://www.opendata500.com/candidates/) is another HTML page
containing a non-standard representation of a data table about companies.
You can select the companies with the following XPath.

```{r}
candidates.xpath
```

This file contains `r nrow(candidates.html)` companies. To give you a feel
for the schema, the first company is represented like this.

```{r}
xpathApply(candidates.parents.html, 'div')[[1]]
```

I'd say that this file contains seven fields. Four of them are direct
questionnaire questions.

XPath within the company node               | Questionnaire question or meaning
-----------------------------               | --------------------------------
a/h3/strong/text()                          | Name of your company
p[@class="m-homepage-list-location"]/text() | In which city is this company located?
em/text()                                   | Which best describes the function of your company?
p[@class="m-homepage-list-desc"]/text()     | As a summary, please provide a one sentence description of your company.

Three of them are not

XPath within the company node | Meaning
----------------------------- | --------------------------------
`r preview.company.xpath`     | Is the company part of the "Preview" companies?
`r survey.company.xpath`      | Did the company submit the questionnaire?
a/@href                       | Link to a page on the Open Data 500 site with more information from the questionnaire about the company

## Loading into R
You can load the data into R like so.

    system('npm install r-open-data-500')
    library(nprm)
    open.data.500 <- nprm.require('open-data-500')

If you haven't installed [nprm](https://github.com/tlevine/nprm),
install it like so.

    library(devtools)
    install_github('nprm','tlevine')

If you don't want to use nprm, you can manually download
[this script](https://raw.github.com/tlevine/open-data-500/master/main.r)

## Distintion between the "Preview" and the "Candidates"
The Open Data 500 Team released an
"[in-depth view](http://www.opendata500.com/preview/)" of "50 of the first
to complete [the] survey". They also released a
"[full list](http://www.opendata500.com/candidates/)" of
"500 candidate companies". What's the difference?

### Are they just the companies that have submitted questionnaires?
The preview companies are simply all of the companies that have
submitted the questionnaire; the non-preview companies are companies for
which the the Open Data 500 team effectively filled out the questionnaire.

I came to that conclusion by looking at the following plot. In this plot,
the height of the bars represents the number of companies in a particular
category. The left category is companies that have completed the questionnaire,
and the right category is companies that haven't. (The Open Data 500 Team
collect information about the companies but not through a questionnaire.)
The datasets are also color-coded based on whether the companies are included
in the Preview set.

```{r preview_v_candidates}
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
```

Note that the entire left bar is blue and the entire right bar is red;
this means that all of the survey companies are in the preview set and
that none of the non-survey companies are in the preview set.

Well maybe. Given what I'm about to say in the next section, I'm starting
to wonder whether there was a mistake in the HTML version.

### Which companies are in the preview?
I still haven't resolved which companies are considered to be the preview
companies.

#### `r length(preview.companies.csv)` companies?
Three of the files (`Preview50_Companies.csv`, `OD500_Companies.json`,
and `preview`) agree as to which companies are in the preview.

```r
all(
  setequal(preview.companies.csv, preview.companies.json),
  setequal(preview.companies.csv, preview.companies.html),
  setequal(preview.companies.csv, preview.companies.preview.html)
)
```

According to those three files, the following
`r length(preview.companies.csv)` companies are in the preview.

```r
preview.companies.csv
```

#### `r length(preview.companies.candidates.html)` companies?
The remaining file, `candidates`, agrees that the above companies are in
the preview,

```r
setequal(intersect(preview.companies.candidates.html, preview.companies.csv), preview.companies.csv)
```

but it includes 
`r length(preview.companies.candidates.html) - length(preview.companies.csv)` 
additional companies, for a total of
`r length(preview.companies.candidates.html)`.

#### 50 companies?
There is even a third conflicting concept of the preview!
Several articles indicate that there are 50 companies in the preview,
not `r length(preview.companies.csv)`
nor `r length(preview.companies.candidates.html)`.

The introduction to the [`preview`](http://www.opendata500.com/preview/) page says
"[t]hese companies are 50 of the first to complete our survey for the Open Data 500".
The [download](http://www.opendata500.com/download/) page calls the preview
files "List[s] of 50". The [home page](http://www.opendata500.com/) says that the
preview is the "list of the first 50 companies that have filled out our survey".

The various press coverage also counts the preview companies at 50.
The article in
[Forbes](http://www.forbes.com/sites/bethsimonenoveck/2014/01/08/from-faith-based-to-evidence-based-the-open-data-500-and-understanding-how-open-data-helps-the-american-economy/)
says "We've also posted in-depth profiles of 50 of them".
The [Information Week](http://www.informationweek.com/government/open-government/open-government-data-companies-cash-in/d/d-id/1113143) article
says that "[i]n addition to publishing a list of 500 open data companies,
GovLab also published profiles of 50 companies creating value from open government data."
And the [Fedscoop](http://fedscoop.com/open-data-500-intersection-open-data-economy/) article
talks about "50 companies profiled for early release".

## Which companies are the candidates?
There are also slight conflicts as to what the full list of companies is.

`500_Companies.csv` contains `r nrow(candidates.csv)` companies, and
`candidates` contains `r nrow(candidates.html)` companies.
Collectively, they list `r length(cset_union(csv,html))` different
companies; they agree about `r length(cset_intersection(csv,html))`
companies, and they disagree about the following companies.

```{r}
csv <- cset(sub(' *$', '', candidates.csv$CompanyName))
html<- cset(sub(' *$', '', as.character(candidates.html$name)))

print('In the CSV but not in the HTML')
print(cset_difference(csv, html))
cat('\n')
print('In the HTML but not in the CSV')
print(cset_difference(html, csv))
```



Much of the Open Data 500 website references a list of 500 companies.
The [download page](http://www.opendata500.com/download) refers to
[`500_Companies.csv`](http://www.opendata500.com/download/500_Companies.csv)
as the "List of 500 Candidates". And the three news articles linked from
the homepage also reference a list of 500 companies.

None of the downloads match this number, however.

length(intersect(as.character(candidates.html$name), candidates.csv$CompanyName))

## 500-ness
I'm still unsure as to what the "500" in the title means.

### Fortune 500?
Many people have suggested that the name is allusion to
[Fortune 500](http://en.wikipedia.org/wiki/Fortune_500),
but I don't think that's it.
The Fortune 500 is list of "the top 500 U.S. closely held and public
corporations as ranked by their gross revenue after adjustments". That is,
it's the 500 biggest U.S. companies for a particular definition of "big".

The Fortune 500 and the Open Data 500 are both about U.S. companies, but
the similarities stop there; as explained on the
"[About](http://www.opendata500.com/about/#about-results)" page,
the Open Data 500 is explicitly not a ranking and not about company size.

### Number of responses?
The website says that the Open Data 500 is a list of 500 companies, so it
might be that the "500" refers to the number of companies responding to the
questionnaire, but this was a bit odd to me because they had chosen the name
before they first sent out the questionnaire.

One member of the Team told me that this was just a big number as a challenge
to themselves. Another told me that they expected, based on Joel Gurin's
network, that there were about 500 companies that would respond.

## Final thoughts
HTML version is most up-to-date
