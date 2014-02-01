#!/bin/sh
set -e

cd www.opendata500.com
for file in $(ls |grep .1$); do
  git rm -r $(basename "$file" .1)
  git mv "$file" $(basename "$file" .1)
done
