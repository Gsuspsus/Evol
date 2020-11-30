module NoiseMapGen 
(
    NoiseMap,
    Dimension,
    noiseMap,
    noiseMaps,
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
        scale = 0.05
        persistence = 0.2

ridge :: StdGen -> Ridged
ridge g = ridged seed octave scale persistence lacunarity
    where 
        seed = fst (random g)
        octave = 3
        scale = 0.5
        persistence = 0.3
        lacunarity = 0.5

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

noiseMaps :: (Noise a) => (StdGen,a) -> Dimension -> Int -> [NoiseMap]
noiseMaps _ _ 0 = []
noiseMaps ng dim n = noiseMap ng dim : noiseMaps ng' dim (pred n)
    where ng' = BF.first (snd . split) ng