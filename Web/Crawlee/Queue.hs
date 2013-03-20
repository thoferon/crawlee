{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module Web.Crawlee.Queue (
  Queue(..)
  ) where

import Web.Crawlee.TypeDefs

import Data.Monoid

class Queue q i where
  qhead :: q i -> Maybe i
  qtail  :: q i -> q i

instance Monoid a => Monoid (UniqQueue a) where
  mempty = UniqQueue mempty
  mconcat _ = undefined
  UniqQueue a `mappend` UniqQueue b = UniqQueue $ a `mappend` b

instance Queue UniqQueue a where
  qhead (UniqQueue []) = Nothing
  qhead (UniqQueue (i:_)) = Just i
  qtail (UniqQueue is) = UniqQueue $ tail is
