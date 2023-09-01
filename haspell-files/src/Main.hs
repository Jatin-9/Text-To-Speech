module Main (module SoundTest) where

import Phonemizer
import Speaker
import Soundgluer
import Data.List

-- if not, invite me to your git repo: txw467

SoundTest :: IO ()
SoundTest = do
  let languageId = "eng"  -- assuming English language
  let voiceName = "voice"  -- assuming a 'default' voice
  let inputText = "why"
  let filePath = "/Users/jatinkandpal/git/text-to-speech/haspell-files/Final_Output/output"
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  glueSpeech voiceName phonemes filePath

  --Speak the phonemes
  --putStrLn (intercalate "; " (intercalate [", "] phonemes))

  --testingOutputAudio voiceName
  -- testGetAudioData
