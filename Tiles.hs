module Tiles where

data Tile = Land | Water | Plant deriving (Eq)
type Strip = [Tile]
type TileMap = [Strip]

instance Show Tile where
    show Land = "#"
    show Water = "~"
    show Plant = "&"
