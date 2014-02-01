#!/usr/bin/env python3
import os
from lxml.html import parse

candidates_fields = [
    ('name','a/h3/strong/text()'),
    ('city','p[@class="m-homepage-list-location"]/text()'),
    ('func','em/text()'),
    ('desc','p[@class="m-homepage-list-desc"]/text()'),
    ('preview.company','contains(@class, "preview-company")'),
    ('survey.company','contains(@class, "survey-company")'),
    ('href','a/@href'),
]

def candidates(html):
    for div in html.xpath('//div[@class="m-candidates isotopes-container"]/div'):
        flatten = lambda x: x[0] if hasattr(x, '__len__') else x
        yield {key: flatten(div.xpath(xpath)) for (key, xpath) in candidates_fields}

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
