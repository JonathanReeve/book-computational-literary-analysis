import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import Lucid

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do

    "*.html" %> \out -> do
        let orgFiles = out -<.> "org"
        need [orgFiles]
        cmd_ "pandoc --standalone" [out] [orgFiles]
