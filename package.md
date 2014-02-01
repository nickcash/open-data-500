I've recently been trying to understand the
[Open Data 500](http://www.opendata500.com) data format,
and my [work thus far](/!/open-data-500-data-dictionary)
leaves much to be desired.

## More stuff I figured out about the Open Data 500 data
It was pretty simple to convert the data formats once I figured them out, but
that step took me a while. The main issue was reconciling the conflicting data
that are reported on the Open Data 500 site.

### The conflicting data
The Open Data 500 Team released four data files in its "Downloads" section,
and it implicitly released two HTML data files elsewhere on its site.
Some of these seem to present the same data in different formats, but when
I looked closely, I found that they actually contained different data, and
I wasn't really sure which data to use. Do I combine the different files?
If a company is in one file but not another, is it part of the study?
Is one of the files more up-to-date?

I never really figured out what to do about all this.

### All questionnaire responses will be included
Until I did last week's research into the Open Data 500 methodology,
I had the impression that the Open Data 500 involved some assessment of
companies beyond what they say in the questionnaire. Now, I think that
the study is just an ordinary questionnaire survey and that they want as
many responses as they can get. If this is the case, the Open Data 500 Team
would probably want to report any company that completed the questionnaire.

In assembling my Open Data 500 dataset, I thus think it's safe to include
any company that was included in any of the official Open Data 500 dataset
releases.

### Only the HTML version gets updated
The CSV and JSON versions of the larger Open Data 500 list include
51 companies each, and the HTML version of the larger Open Data 500 list
includes 100 companies. I wasn't really sure what to make of this, but now
I have a guess.

I scraped the data from the various HTML pages on the site, and I noticed
that there is indeed quite complete data for all of these 100 companies.
I thus think that these companies responded to the questionnaire.

Separately, I know for sure that the "download"
section isn't being updated because I downloaded those files when they
were first released in December, and they haven't changed. I haven't
been downloading the HTML files regularly, 

I found [this git repository](https://github.com/GovLab/OpenData500),
which seems to be the code for the site. In that repository as well,
the "download" files have never been updated. But recent development on
the site has been happening, so I find it conceivable that the data behind
the HTML files is being updated. The data are being stored in Mongo rather
than as files in the repository, so I can't say for sure that the data are
being updated, but it seems likely.

Anyway, my broader conclusion is that the HTML pages **are** being updated and
the "download" section **is not** being updated.

## Packaging the data
I produced a single CSV file to describe the data, and this file should make
a lot more sense than the official CSV files.

### Upstream sources
The data come from the "full list" section of the Open Data 500 website.
I took most of the data for any particular company from its page on the website;
for example, most of the data for Appallicious came from
[`http://www.opendata500.com/Appallicious/`](http://www.opendata500.com/Appallicious/).
I also took data from the [full list page](http://www.opendata500.com/candidates).
If the same field was present on both pages (for example, the company name),
I used the value on the company's particular page rather than the value on the
main "full list" page.

### Schema
The dataset is a single CSV file, where each row is a company and most columns
are answers to questionnaire questions. (I think! Remember that I'm guessing at
all of this.) Here are the columns that I think to come from the first page of
the questionnaire.

Column name             | Question from the questionnaire
----------------------- | -------------------------------
`name`                  | Name of your company
`url`                   | Company URL
`location`              | "In which city is this company located?", and "State" (two questions)
`year.founded`          | Founding Year
`fte`                   | Number of FTE's
`type.of.company`       | Type of Company
`category`              | What category best describes your company?
`function`              | Which best describes the function of your company?
`source.of.revenue`     | Which of the following are significant sources of revenue for your company?
`description`           | Please give us a short public statement describing your company’s mission and work. You can take this material from your website or other publications if you choose to.
`description.short`     | As a summary, please provide a one sentence description of your company.
`social.impact`         | Besides revenue generation, how do you measure the impact your company has for society and the public good? 
`financial.info`        | Please include any financial or operational information that will help us understand your company. We are interested in specific information like past and projected annual revenues, total outside investment dollars to date, and significant investors or partners. 

The `dataset` field contains a CSV file of the datasets listed on subsequent
pages of the questionnaire. This file has a row for each dataset, and it has
columns for the URL and title of the dataset.

The three remaining fields are not from the questionnaire

Column name             | Meaning
----------------------- | -------------------------------
`href`                  | Location of the company page within the Open Data 500 website
`data.collection`       | Which method was used for data collection? ("questionnaire" or "undocumented")

And I suspect that the `sectors(s)` column comes from the questionnaire,
but I haven't figured out what question it's from.

### Questionnaire versus undocumented data collection
I separate the data collection methods for the Open Data 500 into two methods.

1. Convenience-sampled questionnaire responses
    ("[comprehensive call](#comprehensive-call-sampling-strategy))
2. Undocumented data collection

Data from both sorts of data collection are included in the dataset that I
provide, and the `data.collection` field indicates which method was used.
You'll also notice that much of the data are missing for rows that were
collected with the undocumented method.

## Using the data
You can download the file at
[https://raw.github.com/tlevine/open-data-500/master/open-data-500.csv](https://raw.github.com/tlevine/open-data-500/master/open-data-500.csv).

I've also packaged the it as a
[Data Package](http://data.okfn.org/standards/data-package),
so you can use any of
[these fancy tools](http://data.okfn.org/tools)
to load it.

Do tell me if you have any trouble with the files. I'd love to hear about
anything that you find with the data!