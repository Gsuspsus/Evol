import Front
import System.Random
import NoiseMapGen
import TileMapGen

main :: IO ()
main = do
    g <- newStdGen
    let m = generate $ noiseMap (g,perl g) (50,100)
    display m