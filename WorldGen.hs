module WorldGen where

import System.Random
import Tiles
import TileMapGen
import NoiseMapGen

data World = World {
    worldMap :: TileMap,
    dimension :: (Double,Double)
}

generateWorld :: StdGen -> [Tile] -> (Double,Double) -> World
generateWorld g tiles dim = World wm dim
    where
        wm = flatten tilemaps
        tilemaps = map (uncurry generateTileMap) layers
        layers = zip (noiseMaps (g,ridge g) dim (length tiles)) tiles