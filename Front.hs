module Front 
(
  display
)
where

import System.Console.ANSI
import Control.Monad ()
import Tiles

display :: TileMap -> IO ()
display m = do
    clearScreen
    setCursorPosition 0 0
    printMap m
    setSGR [Reset]


printMap :: TileMap -> IO ()
printMap = mapM_ ((>> putStrLn "") . printStrip) 

printStrip :: Strip -> IO ()
printStrip = mapM_ printTile

printTile :: Tile -> IO ()
printTile t = do 
                if t == Water then 
                  setSGR [SetColor Foreground Vivid Blue]
                else 
                  setSGR [SetColor Foreground Dull Green] 
                
                putStr $ show t