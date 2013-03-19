{-# LANGUAGE ExistentialQuantification #-}

module Web.Crawlee.Crawler (
  Crawler(..)
  , Queue
  , Url
  , Page
  , f
  ) where

import Data.Monoid
import Control.Monad

data UniqQueue a = UniqQueue a
data Crawler q i r = (Queue (q i), Monoid r) => Crawler { scrap :: (i -> (q i, r)) }

class Monoid q => Queue q where
  first :: q -> i
  rest  :: q -> q

instance Monoid a => Monoid (UniqQueue a) where
  mempty = UniqQueue mempty
  mconcat _ = undefined
  UniqQueue a `mappend` UniqQueue b = UniqQueue $ a `mappend` b

instance Queue (UniqQueue a) where
  first (UniqQueue (i:_)) = i
  rest (UniqQueue is) = UniqQueue $ tail is

getResults :: (Queue (q i), Monoid r) => Crawler q i r -> q i -> r
getResults (Crawler scrap) queue
  | queue == mempty = mempty
  | otherwise = mempty
