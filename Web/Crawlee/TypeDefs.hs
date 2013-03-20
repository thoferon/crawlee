module Web.Crawlee.TypeDefs (
  UniqQueue(..)
  , Url
  , UrlQueue
  , Page
  ) where

data UniqQueue a = UniqQueue [a]
type Url = String
type UrlQueue = UniqQueue Url
data Page = Page { url :: Url, content :: String } deriving (Eq,Show)
