module Main (main) where

main :: IO ()
main = do
    putStrLn "Ваше имя?"
    name <- getLine
    let newText = "Привет, " ++ name ++ "!\n"
    putStrLn newText
