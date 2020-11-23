import System.Random
import NoiseMapGen
import Control.Monad
import TileMapGen
import Front
main :: IO ()
main = do
    g <- newStdGen
    let dim = (50,100)
    let ms = noiseMap (g,ridge g) dim
    display $ generate ms
    a <- getLine
    forever $ do
        let ms = noiseMap (g,ridge g) dim
        display $ generate ms
        main
