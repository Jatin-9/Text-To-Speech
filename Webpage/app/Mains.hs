module Mains (module Mains) where

import Phonemizer
import Speaker
import Soundgluer
import Data.List
import Codec.Audio.Wave


soundTest :: String -> String -> IO () -- had to change it because of the argument coming from Main.hs
soundTest languageId inputText = do
  waveHeader <- readWaveFile waveHeaderPath
  let (voiceName, waveHeaders) = if languageId == "pol" then ("luknw" , waveHeader) else ("voice" , defaultWave)
  let filePath = "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/Final_Output/output" -- default loacation for output sound generated from TextToSpeech
  -- Convert the input text to phonemes
  phonemes <- phonemize languageId inputText
  --speak voiceName phonemes
  glueSpeech voiceName phonemes filePath waveHeaders
 
  --Speak the phonemes
  --putStrLn (intercalate "; " (intercalate [", "] phonemes))
  --testingOutputAudio voiceName
  -- testGetAudioData
