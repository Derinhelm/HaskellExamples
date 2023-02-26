module Main (main) where

import Lib

main :: IO ()
main = putStrLn $ show $ eval [("x", True), ("y", False)] $ Not (And (Var "x") (Or (Lit False) (Var "y")))
