import System.Random
import Control.Monad
import Data.Maybe
import Tiles
import Front
import WorldGen
main :: IO ()
main = do
    g <- newStdGen
    let dim = (50,100)
    let world = generateWorld g [Land,Water] dim
    forever $ do
        let layer = getLayer world Water
        display (snd $ fromJust layer)
        getLine
        main
