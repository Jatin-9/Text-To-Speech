module Main where

import Phonemizer
import Speaker
import Soundgluer
import Data.List

main :: IO ()
main = do
  let languageId = "eng"  -- assuming English language
  let voiceName = "luknz"  -- assuming a 'default' voice
  let inputText = "hell"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  -- Speak the phonemes
  --putStrLn (intercalate "; " (intercalate [", "] phonemes))
  speak voiceName phonemes