module Main where

import Phonemizer
import Speaker
import Soundgluer
import Data.List

-- if not, invite me to your git repo: txw467

main :: IO ()
main = do
  let languageId = "eng"  -- assuming English language
  let voiceName = "luknz"  -- assuming a 'default' voice
  let inputText = " bb b"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  --Speak the phonemes
  --putStrLn (intercalate "; " (intercalate [", "] phonemes))
  speak voiceName phonemes
  testingOutputAudio voiceName
  -- testGetAudioData