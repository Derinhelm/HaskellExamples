module Main (main) where

import Lib

main :: IO ()
main = putStrLn $ show $ eval True [("x", True), ("y", False)] $ And (Var "z") (Or (Lit False) (Lit True))