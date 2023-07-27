module Main where

import Phonemizer
import Speaker

main :: IO ()
main = do
  let languageId = "pol"  -- assuming English language
  let voiceName = "luknw"  -- assuming a 'default' voice
  let inputText = "Hello, world"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  -- Speak the phonemes
  speak voiceName phonemes