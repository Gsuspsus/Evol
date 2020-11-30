module Front 
(
  display,
  printMap
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
                case t of  
                  Water -> setSGR [SetColor Foreground Vivid Blue]
                  Land -> setSGR [SetColor Foreground Dull Green]
                  Plant -> setSGR [SetColor Foreground Vivid Red]
                  Empty -> setSGR [Reset]
                putStr $ show t