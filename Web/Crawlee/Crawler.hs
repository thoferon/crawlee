{-# LANGUAGE ExistentialQuantification #-}

module Web.Crawlee.Crawler (
  Crawler(..)
  , getResults
  ) where

import Web.Crawlee.Queue
import Web.Crawlee.TypeDefs

import Data.Monoid

data Crawler q i r = (Monoid (q i), Monoid r) => Crawler { scrap :: (i -> (q i, r)) }

getResults :: (Queue q i, Monoid (q i), Monoid r) => Crawler q i r -> q i -> r
getResults c q =
  case qhead q of
    Nothing -> mempty
    Just i -> let (q', r) = scrap c i
              in r `mappend` getResults c (qtail q `mappend` q')
