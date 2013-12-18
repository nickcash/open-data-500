#!/bin/sh
mkdir -p download
for file in index.html Preview50_Companies.csv 500_Companies.csv OD500_Companies.json OD500_Datasets.json; do
  if ! test -e download/$file; then
    wget -O download/$file \
      http://www.opendata500.com/download/$file
  fi
done
