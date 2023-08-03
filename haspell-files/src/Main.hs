module Main where

import Phonemizer
import Speaker
import Soundgluer

main :: IO ()
main = do
  let languageId = "pol"  -- assuming English language
  let voiceName = "luknw"  -- assuming a 'default' voice
  let inputText = "jatin"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  -- Speak the phonemes
  speak voiceName phonemes