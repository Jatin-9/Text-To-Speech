{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import Lib
import Web.Scotty as Scotty
import Mains
import Control.Monad.IO.Class as IO
import Codec.Audio.Wave
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


--soundRoute :: Scotty.ScottyM ()
--soundRoute = Scotty.get "/output.wav" $ do
  -- Scotty.setHeader ("Content-Type") ("audio/wav")
   --Scotty.file "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/Final_Output/output.wav"

main :: IO ()
main = Scotty.scotty 3000 $ do
    Scotty.middleware $ staticPolicy (addBase "Static")
    cssRoute
    Scotty.get(capture "/") $ do
       Scotty.html $ renderHtml
         myForm
    post "/convert" $ do
       languageId <- param "language" :: ActionM String
       inputText <- param "input"     :: ActionM String
       IO.liftIO $ soundTest languageId inputText

       text $ TL.pack languageId <> " " <> TL.pack inputText
    --soundRoute
       

   

