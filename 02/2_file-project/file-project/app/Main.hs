module Main (main) where

import Data.Char

main :: IO ()
main = do
    contents <- readFile "file.txt"
    writeFile "file-2.txt" $ map toUpper contents
