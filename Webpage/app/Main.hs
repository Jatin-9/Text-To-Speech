{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import Lib
import Web.Scotty as Scotty
import Mains

import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text(renderHtml)
import Control.Monad (forM_)
import qualified Data.Text.Lazy as TL
import Network.Wai.Middleware.Static (staticPolicy, addBase)

cssRoute :: Scotty.ScottyM ()
cssRoute = Scotty.get "/style.css" $ do
   Scotty.setHeader ("Content-Type") ("text/css")
   Scotty.file"/Users/jatinkandpal/git/text-to-speech/Webpage/Static/style.css"


-- soundRoute :: Scotty.ScottyM ()
-- soundRoute = Scotty.get "/Mains.hs" $ do
--    Scotty.setHeader ("Content-Type") ("text/plain")
--    Scotty.file"/Users/jatinkandpal/git/text-to-speech/Webpage/src/Main.hs"

main :: IO ()
main = Scotty.scotty 3000 $ do
    Scotty.middleware $ staticPolicy (addBase "Static")
    cssRoute
    Scotty.get(capture "/") $ do
       Scotty.html $ renderHtml
         myForm
    post "/convert" $ do
       -- languageId <- param "languageId"
       -- inputText <- param "inputText"
       _ <- return soundTest
       text $ "Done!"
