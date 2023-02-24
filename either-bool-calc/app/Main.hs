module Main (main) where

import Lib

main :: IO ()
main = putStrLn $ show $ eval [("x", True), ("y", False)] $ And (Var "q") (Or (Lit False) (Var "t"))
