#!/usr/bin/env python3
import os
from lxml.html import parse

def candidates(html):
    for div in html.xpath('//div[@class="m-candidates isotopes-container"]/div'):
        yield {'href':div.xpath('a/@href')[0]}
        #   name = candidates.html.field('a/h3/strong/text()', xmlValue),
        #   city = candidates.html.field('p[@class="m-homepage-list-location"]/text()', xmlValue),
        #   func = candidates.html.field('em/text()', xmlValue),
        #   desc = candidates.html.field('p[@class="m-homepage-list-desc"]/text()', xmlValue),
        #   preview.company = candidates.html.field(preview.company.xpath),
        #   survey.company = candidates.html.field(survey.company.xpath),
        #   href = candidates.html.field('a/@href')

def data():
    path_candidates = os.path.join('www.opendata500.com','candidates','index.html')
    html_candidates = parse(path_candidates).getroot()
    for row in candidates(html_candidates):
    #   path_candidate = os.path.join('www.opendata500.com', row['href'].lstrip('/'))
    #   html_candidate = parse(path_candidate).getroot()
    #   row.update(candidate(html_candidate))
        yield row

if __name__ == '__main__':
    for row in data():
        print(row)
