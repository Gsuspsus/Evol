import Control.Monad
import Data.Bifunctor
import Data.Maybe
import Front
import System.Console.ANSI (getTerminalSize)
import System.Random
import Tiles
import WorldGen

main :: IO ()
main = do
  maybeSize <- getTerminalSize
  let dim = bimap fromIntegral fromIntegral $ fromMaybe (80, 100) maybeSize
  forever $ do
    g <- newStdGen
    let world = generateWorld g [Land, Land] dim
    display $ worldMap world
    getLine