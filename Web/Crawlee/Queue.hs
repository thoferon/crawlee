{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module Web.Crawlee.Queue (
  Queue(..)
  ) where

import Web.Crawlee.TypeDefs

import Data.Monoid

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
