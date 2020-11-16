import Front
import TileMapGen
import System.Random

type Position = (Int,Int)
data Tile = Land Position | Water Position | Plant Position

main :: IO ()
main = do
    g <- newStdGen
    let m = noiseMap (g,perl g) (50,100)
    display m