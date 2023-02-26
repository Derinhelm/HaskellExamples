module Fun
    ( someFunc
    ) where

import Data.List (sort)

someFunc :: String
someFunc = show $ sort $ ([1, 5, 3] :: [Int])
