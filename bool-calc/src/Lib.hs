module Lib
    ( Expr (..)
    , eval
    ) where

    
data Expr a
  = Lit Bool
  | And (Expr a) (Expr a)
  | Or (Expr a) (Expr a)
  deriving (Show)
    
eval :: Expr Bool -> Bool
eval (Lit n) = n
eval (And e1 e2) = eval e1 && eval e2
eval (Or e1 e2) = eval e1 || eval e2
