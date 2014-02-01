#!/usr/bin/env python3
import os
import csv
import io

from lxml.html import parse

candidates_fields = [
    ('name','a/h3/strong/text()'),
    ('location','p[@class="m-homepage-list-location"]/text()'),
    ('company.function','em/text()'),
    ('short.description','p[@class="m-homepage-list-desc"]/text()'),
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
        'name': html.xpath('//h1/a/text()')[0],
        'url': html.xpath('//h1/a/@href')[0],
    }
    div = html.xpath('//div[@class="m-list-company-full"]')[0]
    def get_section(section):
        return div.xpath('//h3[text()="%s"]/following-sibling::p' % section)
    def clean_text(dirty):
        return dirty.lower().rstrip(': ').replace(' ','.')

    for p in get_section('Company Information'):
        key = clean_text(p.xpath('strong/text()')[0])
        value = p.xpath('text()')[0].strip() if len(p.xpath('text()')) == 1 else None
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
        html_candidate = parse(path_candidate).getroot()
        row.update(candidate(html_candidate))
        yield row

fields = [
    'href',
    'name',
    'url',
    'location',

    'year.founded',
    'fte',
    'type.of.company',
    'category',
    'company.function',
    'sector(s)',
    'source.of.revenue',

    'description',
    'short.description',
    'social.impact',
    'financial.info',

    'data.collection',

    'datasets',
]

def to_csv():
    out = open('od500.csv', 'w')
    writer = csv.DictWriter(out, fields)
    writer.writeheader()
    for row in data():
        # Nested CSV
        with io.StringIO() as fp:
            subwriter = csv.DictWriter(fp, ['href','name'])
            subwriter.writeheader()
            for dataset in row.get('datasets', []):
                subwriter.writerow(dataset)
            row['datasets'] = fp.getvalue()

        # Collapse the preview and survey nonsense.
        if row['preview.company'] != row['survey.company']:
            warnings.warn('preview.company != survey.company for %s' % row['href'])
        row['data.collection'] = row['preview.company']
        del(row['preview.company'])
        del(row['survey.company'])

        writer.writerow(row)
    out.close()

def all_columns():
    k = set()
    for row in data():
        k = k.union(row.keys())
    return k

if __name__ == '__main__':
    to_csv()
