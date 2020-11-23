import Front
import System.Random
import NoiseMapGen
import TileMapGen

main :: IO ()
main = do
    g <- newStdGen
    let dim = (50,100)
    let ms = noiseMap (g,ridge g) dim
    display $ generate ms