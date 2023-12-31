{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import Lib

import Web.Scotty as Scotty
import Mains
import Control.Monad.IO.Class as IO
import Text.Blaze.Html.Renderer.Text(renderHtml)



cssRoute :: Scotty.ScottyM ()
cssRoute = Scotty.get "/style.css" $ do
   Scotty.setHeader ("Content-Type") ("text/css")
   Scotty.file"/Users/jatinkandpal/git/text-to-speech/Webpage/Static/style.css"

backgroundImage :: Scotty.ScottyM ()
backgroundImage = Scotty.get "/background_image" $ do
   Scotty.setHeader ("Content-Type") ("image/jpeg")
   Scotty.file "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/background_image.jpeg"


audioUrl :: Scotty.ScottyM ()
audioUrl = Scotty.get "/output.wav" $ do
   Scotty.setHeader ("Content-Type") ("audio/wav")
   Scotty.file "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/Final_Output/output.wav"

main :: IO ()
main = Scotty.scotty 4000 $ do
    cssRoute
    backgroundImage
    audioUrl
    Scotty.get(capture "/") $ do
       Scotty.html $ renderHtml
         myForm
    post "/" $ do
       languageId <- param "language" :: ActionM String
       inputText <- param "input"     :: ActionM String
       IO.liftIO $ soundTest languageId inputText
       Scotty.html $ renderHtml
        audioForm
       



       

   

