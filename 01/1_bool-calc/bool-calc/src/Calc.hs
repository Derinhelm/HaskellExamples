module Calc
    ( Expr (..)
    , eval
    ) where

    
data Expr
  = Lit Bool
  | And Expr Expr
  | Or Expr Expr
  | Not Expr
  deriving (Show)
    
eval :: Expr -> Bool
eval (Lit n) = n
eval (And e1 e2) = eval e1 && eval e2
eval (Or e1 e2) = eval e1 || eval e2
eval (Not e) = not $ eval e
