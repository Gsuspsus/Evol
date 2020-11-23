module TileMapGen where

import Tiles
import NoiseMapGen

generate :: NoiseMap -> TileMap
generate nm = map toTile <$> nm
    where toTile n = if n < 0.0 then Water else Land