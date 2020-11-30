module TileMapGen where

import Tiles
import NoiseMapGen

generateTileMap :: NoiseMap -> Tile -> TileMap
generateTileMap nm t = map toTile <$> nm
    where
        toTile v = if v < cutoff then Empty else t 
        cutoff = getCutoff t


overlap :: TileMap -> TileMap -> TileMap
overlap tm tm2 = map stack <$> zipWith zip tm tm2
    where 
        stack (Empty, Empty) = Water
        stack (Empty, t) = t
        stack (t, Empty) = t
        stack (t,_) = t


flatten :: [TileMap] -> TileMap 
flatten [m] = m
flatten (m:rest) = overlap m $ flatten rest