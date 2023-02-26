module Lib
    ( Expr (..)
    , eval
    ) where

data Expr
  = Lit Bool                 -- ^ Значение.
  | Var String                 -- ^ Переменная.
  | And Expr Expr
  | Or Expr Expr
  | Not (Expr)
  deriving (Show)
    
eval :: Bool -> [(String, Bool)] -> Expr -> Bool
eval _ _ (Lit b) = b
eval def vars (Var v) = case lookup v vars of
      Just n  -> n
      Nothing -> def
eval def vars (And e1 e2) = eval def vars e1 && eval def vars e2
eval def vars (Or e1 e2) = eval def vars e1 || eval def vars e2
eval def vars (Not e) = not $ eval def vars e
