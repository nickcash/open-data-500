#!/bin/sh

# Download the "download" section
mkdir -p download
for file in index.html Preview50_Companies.csv 500_Companies.csv OD500_Companies.json OD500_Datasets.json; do
  if ! test -e download/$file; then
    wget -O download/$file \
      http://www.opendata500.com/download/$file
  fi
done
# As of January 31, the files haven't changed since I first downloaded them.
