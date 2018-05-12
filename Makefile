
all: *.hs
	ghc ImgToPlace

clean: cleanout
	rm *.hi *.o ImgToPlace 

cleanout:
	rm a.png a.js
