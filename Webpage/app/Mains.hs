module Mains (module Mains) where

import Phonemizer
import Speaker
import Soundgluer
import Data.List


soundTest :: String -> String -> IO ()
soundTest languageId inputText = do
  let voiceName = "voice"  -- assuming a 'default' voice
  let filePath = "/Users/jatinkandpal/git/text-to-speech/Webpage/Final_Output/output"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  --speak voiceName phonemes
  glueSpeech voiceName phonemes filePath

  --Speak the phonemes
  --putStrLn (intercalate "; " (intercalate [", "] phonemes))
  --testingOutputAudio voiceName
  -- testGetAudioData
