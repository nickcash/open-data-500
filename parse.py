#!/usr/bin/env python3
import os
from lxml.html import parse

candidates_fields = [
    ('name','a/h3/strong/text()'),
    ('city','p[@class="m-homepage-list-location"]/text()'),
    ('function','em/text()'),
    ('description.short','p[@class="m-homepage-list-desc"]/text()'),
    ('preview.company','contains(@class, "preview-company")'),
    ('survey.company','contains(@class, "survey-company")'),
    ('href','a/@href'),
]

def candidates(html):
    for div in html.xpath('//div[@class="m-candidates isotopes-container"]/div'):
        flatten = lambda x: x[0] if hasattr(x, '__len__') else x
        yield {key: flatten(div.xpath(xpath)) for (key, xpath) in candidates_fields}

def candidate(html):
    row = {
        'title': html.xpath('//h1/a/text()')[0],
        'website': html.xpath('//h1/a/@href')[0],
    }
    div = html.xpath('//div[@class="m-list-company-full"]')[0]
    def get_section(section):
        return div.xpath('//h3[text()="%s"]/following-sibling::p[position()=1]' % section)
    def clean_text(dirty):
        return dirty.lower().rstrip(':').replace(' ','.')

    for p in get_section('Company Information'):
        key = clean_text(p.xpath('strong/text()')[0])
        value = p.xpath('text()')[0].strip()
        row[key] = value

    # Run this only if the full questionnaire has been completed.
    if len(div.xpath('//strong[text()="FTE:"]')) > 0:
        for section in div.xpath('div[@class="m-half"][position()=2]/h3/text()'):
            row[clean_text(section)] = get_section(section)[0].text_content()

        x = 'div[@class="m-full datasets"]/ul/li/a'
        row['datasets'] = [{'href':a.xpath('@href')[0], 'name': a.xpath('text()')[0]} \
            for a in div.xpath(x)]

    return row

def data():
    path_candidates = os.path.join('www.opendata500.com','candidates','index.html')
    html_candidates = parse(path_candidates).getroot()
    for row in candidates(html_candidates):
        path_candidate = os.path.join('www.opendata500.com', row['href'].lstrip('/'))
        print(path_candidate)
        html_candidate = parse(path_candidate).getroot()
        print(html_candidate)
        row.update(candidate(html_candidate))
        yield row

if __name__ == '__main__':
    for row in data():
        pass
