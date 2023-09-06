module Lib
    (myForm
    ) where
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

import Text.Blaze.Html.Renderer.Text(renderHtml)
import qualified Data.Text.Lazy as TL
import Control.Monad (forM_)
-- import Mains

cssLink :: H.Html
cssLink = H.link
  H.! A.rel (H.stringValue "stylesheet")
  H.! A.href (H.stringValue "/style.css")

soundRoute :: H.Html
soundRoute = H.link
  H.! A.rel (H.stringValue "audio")
  H.! A.href(H.stringValue "/Static/Final_Output/output.wav")

myForm :: H.Html
myForm = H.docTypeHtml $ do
    H.head $ do
        H.title $ H.toHtml "Text-to-Speech Search"
        cssLink
    H.body $ do
        H.div H.! class_(H.stringValue "big-box") $ do
         H.div H.! class_(H.stringValue "small-box") $ do
           H.form H.! A.action (H.stringValue "") H.! A.method (H.stringValue"post") $ do
            H.label $ H.toHtml "Text-to-Speech Form "
            H.textarea H.! A.type_(H.stringValue "text") H.! A.name (H.stringValue "input") H.! A.required (H.stringValue "required") H.! A.rows (H.stringValue "15") H.! A.cols (H.stringValue "20") $ H.toHtml " "
            H.br
            H.label $ H.toHtml "Select Language: "
            H.select H.! A.name (H.stringValue "language") H.! A.id (H.stringValue "language") $ do
                H.option H.! A.value (H.stringValue "eng") $ H.toHtml "English"
                H.option H.! A.value (H.stringValue "pol") $ H.toHtml "Polish"
            H.br
            H.button H.! A.type_ (H.stringValue "submit") H.! A.class_ (H.stringValue "submit") $ H.toHtml "Convert"
            H.audio H.! A.controls (H.stringValue "controls") $ H.toHtml $ do
                H.source H.! A.src (H.stringValue "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/Final_Output/output.wav") H.! A.type_ (H.stringValue "audio/wav") 
