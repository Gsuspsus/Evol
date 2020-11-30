module Tiles where

data Tile = Land | Water | Plant | Empty deriving (Eq)
type Strip = [Tile]
type TileMap = [Strip]

getCutoff :: Tile -> Double
getCutoff t = case t of 
                Water -> 0.0
                Land -> 0.5
                Plant -> 0.8

instance Show Tile where
    show Land = "#"
    show Water = "~"
    show Plant = "%"
    show Empty = " "