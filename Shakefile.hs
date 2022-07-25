import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import Lucid

destToSrc dest = ("src" </>) $ dropDirectory1 $ dest -<.> "org"

srcToDest src = ("dest" </>) $ dropDirectory1 $ src -<.> "html"

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do

  -- We need all .html files to be built from .org sources
  action $ do
    srcs <- getDirectoryFiles "" ["src/*.org"]
    liftIO $ print srcs
    let dests = map srcToDest srcs
    liftIO $ print dests
    need dests

  -- Here's how to build html files from org sources
  "dest/*.html" %> \out -> do
    let orgFile = ("src" </>) $ dropDirectory1 $ out -<.> "org"
    need [orgFile]
    cmd_ "pandoc --standalone -o" [out] [orgFile]
