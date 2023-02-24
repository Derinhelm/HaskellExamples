module Lib
    ( Expr (..)
    , eval
    ) where
    
data Expr
  = Lit Bool                 -- ^ Значение.
  | Var String                 -- ^ Переменная.
  | And Expr Expr
  | Or Expr Expr
  deriving (Show)
  
resultProcessing :: Either String Bool -> Either String Bool -> (Bool -> Bool -> Bool) -> Either String Bool
resultProcessing (Right r1) (Right r2) fun = Right $ fun r1 r2
resultProcessing (Left e1) (Left e2) _ = Left $ e1 ++ e2
resultProcessing (Left e1) _ _ = Left e1
resultProcessing _ (Left e2) _ = Left e2
    
eval ::  [(String, Bool)] -> Expr -> Either String Bool
eval _ (Lit b) = Right b
eval vars (Var v) = case lookup v vars of
      Just n  -> Right n
      Nothing -> Left $ "Invalid variable name:" ++ v ++ ". "
eval vars (And e1 e2) = resultProcessing (eval vars e1) (eval vars e2) (&&)
eval vars (Or e1 e2) = resultProcessing (eval vars e1) (eval vars e2) (||)
