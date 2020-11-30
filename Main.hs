import System.Random
import Control.Monad
import System.Console.ANSI (getTerminalSize)
import Data.Maybe
import Data.Bifunctor
import Tiles
import Front
import WorldGen
main :: IO ()
main = do
    g <- newStdGen
    maybeSize <- getTerminalSize
    let dim = bimap fromIntegral fromIntegral $ fromMaybe (80,100) maybeSize
    let world = generateWorld g [Land,Land] dim
    forever $ do
        display $ worldMap world
        getLine
        main
