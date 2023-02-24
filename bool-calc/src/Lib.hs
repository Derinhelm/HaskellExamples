module Lib
    ( Bool (..)
    , Expr (..)
    , eval
    ) where

    
data Expr a
  = Lit Bool                 -- ^ Целочисленный литерал.
--  | Var a                   -- ^ Переменная.
  | And (Expr a) (Expr a)   -- ^ Сложение.
  | Or (Expr a) (Expr a)   -- ^ Умножение.
  deriving (Show)--, Functor)
    
eval :: Expr Bool -> Bool
eval (Lit n) = n
--eval (Var n) = n
eval (And e1 e2) = eval e1 && eval e2
eval (Or e1 e2) = eval e1 || eval e2
