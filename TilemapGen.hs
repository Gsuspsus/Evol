module TileMapGen 
(
    noiseMap,
    perl
)
where

import System.Random
import Numeric.Noise
import Numeric.Noise.Perlin
import qualified Data.Bifunctor as BF 

type NoiseGen = (StdGen, Perlin)
type Dimension = (Double,Double)
type TileMap = [[Double]]
type Column = Double
type Row = Double

perl :: StdGen -> Perlin
perl g = perlin seed octave scale persistence
    where 
        seed = fst (random g)
        octave = 2
        scale = 0.025
        persistence = 0.2

noiseAt :: NoiseGen -> Point -> (Double, NoiseGen)
noiseAt ng p = (noiseValue (snd ng) p, ng')
    where 
        ng' = BF.first (snd . split) ng

noiseRow :: NoiseGen -> Dimension -> Column -> Row -> [Double] 
noiseRow ng dim c r = if c >= snd dim then [] else v : noiseRow ng' dim (c+1) r
    where 
        (v,ng') = noiseAt ng (c,r,0)
                        
noiseMap :: NoiseGen -> Dimension -> TileMap
noiseMap ng dim = [ noiseRow ng dim 0 y | y <- [0..fst dim] ]