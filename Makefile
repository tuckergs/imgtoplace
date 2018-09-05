
all: *.hs
	ghc ImgToPlace.hs

clean: cleanout
	rm *.hi *.o ImgToPlace 

cleanout:
	rm a.png a.js
