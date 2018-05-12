
module Utils where

import Prelude as P
import Graphics.Image as I
import Data.List (sortOn)
import Data.Tuple (swap)

type MyPixel = Pixel RGB Word8

placeTable :: [(MyPixel,Int)]
placeTable = [(PixelRGB 0xff 0xff 0xff,0), -- white
              (PixelRGB 0xee 0xee 0xee,1), -- light gray
              (PixelRGB 0x88 0x88 0x88,2), -- gray
              (PixelRGB 0x22 0x22 0x22,3), -- black
              (PixelRGB 0xff 0xaa 0xdd,4), -- pink
              (PixelRGB 0xee 0x00 0x00,5), -- red
              (PixelRGB 0xee 0x99 0x00,6), -- orange
              (PixelRGB 0xaa 0x66 0x44,7), -- brown
              (PixelRGB 0xee 0xdd 0x00,8), -- yellow
              (PixelRGB 0x99 0xee 0x44,9), -- forest green
              (PixelRGB 0x00 0xbb 0x00,10), -- light green
              (PixelRGB 0x00 0xdd 0xdd,11), -- teal
              (PixelRGB 0x00 0x88 0xcc,12), -- kinda teal
              (PixelRGB 0x00 0x00 0xee,13), -- blue
              (PixelRGB 0xcc 0x66 0xee,14), -- lilac
              (PixelRGB 0x88 0x00 0x88,15)] -- purple

distWord8 :: Word8 -> Word8 -> Int
distWord8 = curry $ fmap fromIntegral $ (-) <$> (uncurry max) <*> (uncurry min)

distPix :: MyPixel -> MyPixel -> Int
distPix (PixelRGB r1 g1 b1) (PixelRGB r2 g2 b2)
  = distWord8 r1 r2 + distWord8 g1 g2 + distWord8 b1 b2

distPixSqu :: MyPixel -> MyPixel -> Int
distPixSqu (PixelRGB r1 g1 b1) (PixelRGB r2 g2 b2)
   = (distWord8 r1 r2)^2 + (distWord8 g1 g2)^2 + (distWord8 b1 b2)^2


smap :: (a -> b) -> [(a,c)] -> [(b,c)]
smap f = P.map $ \(a,c) -> (f a,c)

rgbToPlace :: MyPixel -> Int
rgbToPlace = snd . head . sortOn fst . (flip smap) placeTable . distPixSqu 

placeToRgb :: Int -> MyPixel
placeToRgb = (\(Just x) -> x) . (flip lookup $ P.map swap placeTable) 

rgbClosest :: MyPixel -> MyPixel
rgbClosest = placeToRgb . rgbToPlace


