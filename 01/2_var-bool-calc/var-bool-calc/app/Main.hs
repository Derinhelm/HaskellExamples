module Main (main) where

import VarCalc

main :: IO ()
main = putStrLn $ show $ eval True [("x", True), ("y", False)] $ Not (And (Var "z") (Or (Lit False) (Lit True)))