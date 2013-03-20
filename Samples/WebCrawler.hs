import Web.Crawlee
import Data.Monoid

scrapUrl :: Url -> IO (UrlQueue, [Page])
scrapUrl url = do
  putStrLn url
  return (UniqQueue ["blah"], mempty)

main = do
  let initQueue = UniqQueue ["https://github.com/thoferon/crawlee"]
  results <- getResults crawler initQueue
  print $ take 5 results

crawler :: Crawler UniqQueue Url IO [Page]
crawler = Crawler scrapUrl
