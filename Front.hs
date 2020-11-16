module Front 
(
    display
)
where

import System.Console.ANSI
import Control.Monad

display :: [[Double]] -> IO ()
display m = do
    clearScreen
    setCursorPosition 0 0
    printMap $ m
    setSGR [Reset]



printMap :: [[Double]] -> IO ()
printMap = mapM_ ((>> putStrLn "") . printRow) 

printRow :: [Double] -> IO ()
printRow = mapM_ printTile

printTile :: Double -> IO ()
printTile t = if t < 0 then do
                setSGR [SetColor Foreground Vivid Blue]
                putStr "~" 
              else do
                setSGR [SetColor Foreground Dull Green] 
                putStr "#"