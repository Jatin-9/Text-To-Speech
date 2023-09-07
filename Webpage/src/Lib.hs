module Lib
    (myForm , audioForm
    ) where
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

cssLink :: H.Html
cssLink = H.link
  H.! A.rel (H.stringValue "stylesheet")
  H.! A.href (H.stringValue "/style.css")

background :: H.Html
background = H.link
  H.! A.rel (H.stringValue "background-image")
  H.! A.href (H.stringValue "/background_image")

audioLink :: H.Html
audioLink = H.link
  H.! A.rel (H.stringValue "audio")
  H.! A.href (H.stringValue "/output.wav")

myForm :: H.Html
myForm = H.docTypeHtml $ do
    H.head $ do
        H.title $ H.toHtml "Text-to-Speech Search"
        cssLink
        background
    H.body H.! A.style (H.stringValue "background-image: url('/background_image')") $ do
        H.div H.! A.class_(H.stringValue "big-box") $ do
         H.div H.! A.class_(H.stringValue "small-box") $ do
           H.form H.! A.action (H.stringValue "") H.! A.method (H.stringValue"post") $ do
            H.label H.! class_(H.stringValue"label") $ H.toHtml "Text To Speech Engine Generator" 
            H.textarea H.! A.type_(H.stringValue "text") H.! A.name (H.stringValue "input") H.! A.required (H.stringValue "required") $ H.toHtml " "
            H.br
            H.div H.! A.class_(H.stringValue "elementals") $ do
             H.div H.! A.class_(H.stringValue "select") $ do
              H.select H.! A.name (H.stringValue "language") H.! A.id (H.stringValue "language") $ do
                H.option H.! A.selected (H.stringValue " ") H.! A.disabled (H.stringValue " ") $ H.toHtml "Language Choice"
                H.option H.! A.value (H.stringValue "eng") $ H.toHtml "English"
                H.option H.! A.value (H.stringValue "pol") $ H.toHtml "Polish"
             H.br
             H.button H.! A.type_ (H.stringValue "submit") H.! A.class_ (H.stringValue "submit") $ H.toHtml "Convert"
             H.br

audioForm :: H.Html
audioForm = H.docTypeHtml $ do
    H.head $ do
        H.title $ H.toHtml "Text-to-Speech Search"
        cssLink
        background
        audioLink
    H.body H.! A.style (H.stringValue "background-image: url('/background_image')") $ do
        H.div H.! A.class_(H.stringValue "big-box") $ do
         H.div H.! A.class_(H.stringValue "small-box") $ do
           H.form H.! A.action (H.stringValue "") H.! A.method (H.stringValue"post") $ do
            H.label H.! class_(H.stringValue"label") $ H.toHtml "Text To Speech Engine Generator" 
            H.textarea H.! A.type_(H.stringValue "text") H.! A.name (H.stringValue "input") H.! A.required (H.stringValue "required") $ H.toHtml " "
            H.br
            H.div H.! A.class_(H.stringValue "elementals") $ do
             H.div H.! A.class_(H.stringValue "select") $ do
              H.select H.! A.name (H.stringValue "language") H.! A.id (H.stringValue "language") $ do
                H.option H.! A.selected (H.stringValue " ") H.! A.disabled (H.stringValue " ") $ H.toHtml "Language Choice"
                H.option H.! A.value (H.stringValue "eng") $ H.toHtml "English"
                H.option H.! A.value (H.stringValue "pol") $ H.toHtml "Polish"
             H.br
             H.button H.! A.type_ (H.stringValue "submit") H.! A.class_ (H.stringValue "submit") $ H.toHtml "Convert"
             H.br
            H.audio H.! A.controls (H.stringValue "autoplay") $ do
              H.source H.! A.src (H.stringValue "/output.wav") H.! A.type_ (H.stringValue "audio/wav") 
