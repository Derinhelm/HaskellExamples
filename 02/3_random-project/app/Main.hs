module Main (main) where

--import Lib
import System.Random

main :: IO ()
main = do
    gen <- getStdGen
    putStrLn $ take 20 $ randomRs ('a', 'z') gen
