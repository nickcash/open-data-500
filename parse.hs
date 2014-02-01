{-# LANGUAGE OverloadedStrings #-}

import AlphaHeavy.XPathParsers

main = do
  text <- readFile "www.opendata500.com/Vizzuality"
  putStrLn text
