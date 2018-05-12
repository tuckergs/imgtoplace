
import Utils

import Prelude as P
import Graphics.Image as I hiding (map)

import Control.Monad
import Data.Tuple
import System.Environment
import System.Exit
import System.IO


main = do
  args <- getArgs
  when (length args /= 1) $ do
    hPutStrLn stderr "Usage: ./ImgToPlace <filename>"
    exitFailure
  let (fileName:_) = args
  jsHdl <- openFile "a.js" WriteMode
  let pts = hPutStr jsHdl
  putStrLn "Reading image..."
  img <- readImageExact' PNG fileName :: IO (Image VS RGB Word8)
  pts "var f = function(x,y) { "
  let imgArray = I.toLists img
      imgArrayPad = map (\(rw,r) -> map (\(px,c) -> (px,(c,r))) $ zip rw [0..]) $ zip imgArray [0..]
  putStrLn "Writing JS code to a.js and creating preview..."
  imgArray2 <- forM imgArrayPad $ mapM $ \(px,(x,y)) -> do
    let colorIdx = rgbToPlace px
    when (colorIdx /= -1) $ do
      pts "sendColorUpdate("
      pts $ "x+" ++ show x
      pts $ ",y+" ++ show y
      pts $ (',':) $ show $ colorIdx
      pts ");"
    return $ placeToRgb colorIdx
  pts " };"
  putStrLn "JS code generated!"
  putStrLn "Writing preview to a.png..."
  let img2 = fromListsR VS imgArray2
  writeImageExact PNG [] "a.png" img2
  hClose jsHdl
  putStrLn "All done! May the bagels be ever in your favour!"
  
