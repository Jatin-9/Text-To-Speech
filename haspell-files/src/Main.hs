module Main where

import Phonemizer
import Speaker
import Soundgluer

main :: IO ()
main = do
  let languageId = "eng"  -- assuming English language
  let voiceName = "luknz"  -- assuming a 'default' voice
  let inputText = "hello world"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  -- Speak the phonemes
  speak voiceName phonemes