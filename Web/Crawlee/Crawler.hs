{-# LANGUAGE ExistentialQuantification, MultiParamTypeClasses, FlexibleInstances #-}

module Web.Crawlee.Crawler (
  Url
  , UrlQueue
  , Page
  , UniqQueue(..)
  , Crawler(..)
  , Queue
  , getResults
  ) where

import Data.Monoid
import Control.Monad

type Url = String
type UrlQueue = UniqQueue Url
data Page = Page { url :: Url, content :: String }

data UniqQueue a = UniqQueue [a]
data Crawler q i r = (Monoid (q i), Monoid r) => Crawler { scrap :: (i -> (q i, r)) }

class Queue q i where
  first :: q i -> Maybe i
  rest  :: q i -> q i

instance Monoid a => Monoid (UniqQueue a) where
  mempty = UniqQueue mempty
  mconcat _ = undefined
  UniqQueue a `mappend` UniqQueue b = UniqQueue $ a `mappend` b

instance Queue UniqQueue a where
  first (UniqQueue []) = Nothing
  first (UniqQueue (i:_)) = Just i
  rest (UniqQueue is) = UniqQueue $ tail is

getResults :: (Queue q i, Monoid (q i), Monoid r) => Crawler q i r -> q i -> r
getResults c q =
  case first q of
    Nothing -> mempty
    Just i -> let (q', r) = scrap c i
              in r `mappend` getResults c (rest q `mappend` q')
