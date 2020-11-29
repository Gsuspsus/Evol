module NoiseMapGen 
(
    NoiseMap,
    Dimension,
    noiseMap,
    perl,
    ridge,
)
where

import System.Random
import Numeric.Noise
import Numeric.Noise.Perlin
import qualified Data.Bifunctor as BF 
import Numeric.Noise.Ridged

type NoiseMap = [[Double]]
type Dimension = (Double,Double)
type Column = Double
type Row = Double

perl :: StdGen -> Perlin
perl g = perlin seed octave scale persistence
    where 
        seed = fst (random g)
        octave = 2
        scale = 0.025
        persistence = 0.2

ridge :: StdGen -> Ridged
ridge g = ridged seed octave scale persistence lacunarity
    where 
        seed = fst (random g)
        octave = 3
        scale = 0.1
        persistence = 0.5
        lacunarity = 3

noiseAt :: (Noise a) => (StdGen, a) -> Point -> (Double, (StdGen,a))
noiseAt ng p = (noiseValue (snd ng) p, ng')
    where 
        ng' = BF.first (snd . split) ng

noiseRow :: (Noise a) => (StdGen,a) -> Dimension -> Column -> Row -> [Double] 
noiseRow ng dim c r = if c >= snd dim then [] else v : noiseRow ng' dim (c+1) r
    where 
        (v,ng') = noiseAt ng (c,r,0)
                        
noiseMap :: (Noise a) => (StdGen,a) -> Dimension -> NoiseMap
noiseMap ng dim = [ noiseRow ng dim 0 y | y <- [0..fst dim] ]