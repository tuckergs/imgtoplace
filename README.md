# imgtoplace

## Wat?

A program that takes a PNG image and generates a JavaScript function that puts it on COSI Place. As Place currently allows only 16 colors, it currently uses Euclidean distance to find the closest admissable color. The program also generates a nice PNG preview so you can see what the function will do.

## Compiling

First, I recommend getting the Haskell Platform if you don't have it. You then need the package "hip", which is an image processing library. You can install it by running these commands:

```
cabal update
cabal install hip
```

You can then compile by running, as per the L^2 norm:

```
make
```

Note the makefile also has a target, called cleanout, to clear the a files

## Notes

First, the program's usage is like this

```
./ImgToPlace <filename>
```

Second, the function it generates will be in a.js, and it will have by default the name "f". You can change it by opening up your favorite text editor, like vim. Likewise, the preview is in a.png. 

Third, COSI Place is 500x500, so scale your image down to that size. COSI Place's indexes are between [0,499] for both x and y. The x-axis goes right while the y-axis goes down. Place doesn't crash on out-of-bound indices, so you can have your image greater than 500x500.

Fourth, this accepts only PNGs.

Fifth, if you get errors saying that the image has RGBA8 format when it should have RGB8, just go into GIMP and under Layer -> Transparency, select Remove Alpha Channel, then export to PNG

