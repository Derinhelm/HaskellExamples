module Main (main) where

import Lib

main :: IO ()
main = putStrLn $ show $ eval $ Not (And (Lit True) (Or (Lit False) (Lit True)))
