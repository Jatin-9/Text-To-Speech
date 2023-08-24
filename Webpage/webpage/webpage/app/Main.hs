{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import Lib
import Web.Scotty as Scotty
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text(renderHtml)
import Control.Monad (forM_)
import qualified Data.Text.Lazy as TL
import Network.Wai.Middleware.Static (staticPolicy, addBase)


cssRoute :: Scotty.ScottyM ()
cssRoute = Scotty.get "/style.css" $ do
   Scotty.setHeader ("Content-Type") ("text/css")
   Scotty.file"/Users/jatinkandpal/Text-To-Speech-WebPage/Static/style.css"

main :: IO ()
main = Scotty.scotty 3000 $ do
    Scotty.middleware $ staticPolicy (addBase "Static")
    cssRoute
    Scotty.get(capture "/") $ do
       Scotty.html $ renderHtml
         myForm
