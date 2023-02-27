module Fun
    ( getName
    ) where

import Data.Char (isUpper)
import Data.List.Split (splitOn)
import Data.Sort (sort)


getName :: [Char] -> [String]
getName input = sort $ filter (\word -> isUpper $ head word) $ splitOn " " input
    