import           AlphaHeavy.XPathParsers
import qualified Data.ByteString as B

xpath :: B.ByteString -> String -> IO [String]
xpath html theXPath = do
  values <- evaluateHTMLXPath theXPath "" html
  return $ lines $ show values

main = do
  html <- B.readFile "www.opendata500.com/Vizzuality"
  strongs <- xpath html "//strong/text()"
  putStrLn $ strongs !! 0
