#!/usr/bin/env python3
import os
from lxml.html import parse

def candidates(html):
    html.

def data():
    path_candidates = os.path.join('www.opendata500.com','candidates','index.html')
    html_candidates = parse(path_candidates).getroot()
    for row in candidates(html_candidates):
        path_candidate = os.path.join('www.opendata500.com', row['href'].lstrip('/'))
        html_candidate = parse(path_candidate).getroot()
        row.update(candidate(html_candidate))
        yield data
