module Lib
    (myForm
    ) where
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text(renderHtml)
import qualified Data.Text.Lazy as TL
import Control.Monad (forM_)


cssLink :: H.Html
cssLink = H.link
  H.! A.rel (H.stringValue "stylesheet")
  H.! A.href (H.stringValue "/style.css")


myForm :: H.Html
myForm = H.docTypeHtml $ do
    H.head $ do
        H.title $ H.toHtml "Text-to-Speech Search"
        cssLink
    H.body $ do
        H.div H.! class_(H.stringValue "big-box") $ do
         H.div H.! class_(H.stringValue "small-box") $ do
           H.form H.! A.action (H.stringValue "/convert") H.! A.method (H.stringValue"post") $ do
            H.label $ H.toHtml " "
            -- H.input H.! A.type_ (H.stringValue"text") H.! A.name (H.stringValue"text") H.! A.required (H.stringValue "required") [used to make small box]
            H.textarea H.! A.id (H.stringValue "text") H.! A.required (H.stringValue "required") H.! A.rows (H.stringValue "15") H.! A.cols (H.stringValue "20") $ H.toHtml "Lets start converting"
            H.br
            H.label $ H.toHtml "Select Language: "
            H.select H.! A.id (H.stringValue "language") $ do
                H.option H.! A.value (H.stringValue "eng") $ H.toHtml "English"
                H.option H.! A.value (H.stringValue "pol") $ H.toHtml "Polish"
            H.br
            H.button H.! A.type_ (H.stringValue "submit") H.! A.class_ (H.stringValue "submit") $ H.toHtml "Convert"

           H.div H.! class_(H.stringValue "controlling-audio") $ do
            H.audio  H.! A.type_ (H.stringValue"audioPlayer") H.! A.controls (H.stringValue" ") $ do
             H.source H.! A.src (H.stringValue " ") H.! A.type_ (H.stringValue" audio/mpeg")
            --H.button H.! A.type_(H.stringValue "button") H.! A.id (H.stringValue "play-button") $ H.toHtml"Play" [no need for play button]
            H.div H.! A.class_ (H.stringValue "timeline") $ do
             H.div H.! A.class_ (H.stringValue "progress") $ H.toHtml ""
