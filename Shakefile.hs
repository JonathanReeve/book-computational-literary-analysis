import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do

    "*.html" %> \out -> do
        let md = out -<.> "md"
        need [md, template]
        cmd_ "pandoc --standalone -t revealjs" [out] [md]
