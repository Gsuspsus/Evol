module WorldGen where

import System.Random
import Data.Foldable
import Layer
import Tiles
import NoiseMapGen

newtype World = World { getWorldLayers :: [Layer]} deriving (Show) 

generateWorld :: StdGen -> [LayerType] -> Dimension -> World
generateWorld g types dim = World $ map (convertNoiseToLayer nm) types
    where 
        ng = (g,ridge g)
        nm = noiseMap ng dim

getLayer :: World -> LayerType -> Maybe Layer
getLayer w t = find ((==t) . fst) $ getWorldLayers w