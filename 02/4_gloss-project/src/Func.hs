{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-} -- for newtype Time 
module Func
    ( run
    ) where

import Data.Char
import System.Random

import Graphics.Gloss.Interface.Pure.Game

--------------
-- Data types.
--------------

newtype Time = Time Int
  deriving (Num)

instance Show Time where
  show (Time t) = show t

-- Game state.
data GameState = GameState
  { gameTime      :: Time          -- Game time.
  , gameAnswer    :: Int          -- Answer for the task.
  , gameLastValue :: Maybe Int    -- Last entered value.
  , gameFinished  :: Bool         -- Has the game been completed.
  } deriving Show

-------------
-- Constants.
-------------

-- Game display mode.
display :: Display
display = InWindow "Game" (800, 800) (50, 50)--FullScreen

-- Background color.
bgColor :: Color
bgColor = white --makeColor 0.5 0.9 0.7 1.0

-- Text color.
timeColor :: Color
timeColor = orange

textColor :: Color
textColor = blue

-- Simulation steps per second.
stepsPerSecond :: Int
stepsPerSecond = 1

-- Text shift on screen.
textShift :: Float
textShift = 200

-- Random numbers range.
range :: (Int, Int)
range = (0, 9)

------------------
-- Pure functions.
------------------

drawFinish :: Maybe Int -> Int -> Picture
drawFinish Nothing _ = Color textColor $ Text $ "Help!" -- Impossible option. There is a bug in the program
drawFinish (Just _) answer = Translate (-textShift) 0 $ Color textColor $ Text $ "Win:" ++ (show answer)

drawIntermediate :: Maybe Int -> Time -> Picture
drawIntermediate Nothing time = Color timeColor $ Text $ show time
drawIntermediate (Just lastVal) time = Pictures [leftHalf, rightHalf]
  where 
    leftHalf = Translate (-textShift) 0 $ Color timeColor $ Text $ show time
    rightHalf = Translate textShift 0 $ Color textColor $ Text $ show lastVal

drawGame :: GameState -> Picture
drawGame GameState{..}
  | gameFinished==True = drawFinish gameLastValue gameAnswer
  | otherwise = drawIntermediate gameLastValue gameTime

hadleKey :: Char -> GameState -> GameState
hadleKey key state@GameState{..} 
  | isDigit key = if digitToInt key == gameAnswer
                  then state{gameFinished=True, gameLastValue=Just $ digitToInt key}
                  else state{gameLastValue=Just $ digitToInt key}
  | otherwise = state -- Another key.

-- Handle events.
handleEvent :: Event -> GameState -> GameState
handleEvent _ state@GameState{gameFinished=True} = state
handleEvent (EventKey (Char key) Down _ _) state = hadleKey key state -- Check the answer when Enter is pressed.
handleEvent _ g = g -- Ignore all other events.

-- Simulation step (updates time).
update :: Float -> GameState -> GameState
update _ state@GameState{..} = state{ gameTime = gameTime + 1}

------------------------------
-- Main function for this app.
------------------------------

-- Run game. This is the ONLY unpure function.
run :: IO ()
run = do
  -- Get new random number generator (unpure action).
  gen <- newStdGen
  let
    (answer, _) = randomR range gen-- pure action
    initState = GameState 0 answer Nothing False
  putStrLn $ show initState -- for our understanding
  play display bgColor stepsPerSecond initState drawGame handleEvent update

