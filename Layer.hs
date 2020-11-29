module Layer where

import NoiseMapGen
import Tiles

type LayerType = Tile

type NoiseLayer = (LayerType, NoiseMap)

type Layer = (LayerType, TileMap)

convertNoiseToLayer :: NoiseMap -> LayerType -> Layer
convertNoiseToLayer nm t = (t, map toTile <$> nm)
  where
    toTile n = if n < 0.0 then Empty else t