{-# LANGUAGE OverloadedStrings #-}

import           AlphaHeavy.XPathParsers
import qualified Data.ByteString as B

main = do
  text <- B.readFile "www.opendata500.com/Vizzuality"
  foo <- evaluateHTMLXPath "//strong/text()" "" text
  putStrLn $ show foo
