{-# LANGUAGE ExistentialQuantification #-}

module Web.Crawlee.Crawler (
  Crawler(..)
  , getResults
  ) where

import Web.Crawlee.Queue
import Web.Crawlee.TypeDefs

import Control.Monad
import Data.Monoid

data Crawler q i m r = (Monoid (q i), Monoid r, Monad m) => Crawler { scrap :: (i -> m (q i, r)) }

getResults :: (Queue q i, Monoid (q i), Monoid r, Monad m) => Crawler q i m r -> q i -> m r
getResults c q =
    case qhead q of
      Nothing -> return mempty
      Just i -> getResults' i
  where
    getResults' i = do
      (q', r) <- scrap c i
      rest <- getResults c (qtail q `mappend` q')
      return $ r `mappend` rest
