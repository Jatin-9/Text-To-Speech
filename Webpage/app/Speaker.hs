module Speaker (module Speaker) where

import HspTypes(Phoneme)
import Phonemizer (phonemize)
import Soundgluer (glueSpeech, waveExtension)
import System.Process(callProcess)
import Data.List
import Codec.Audio.Wave

-- | Plays the phonems in the specified voice
speak :: String         -- ^ Name of the voice. It should match the name of the voice folder in the voxDirectory.
      -> [[Phoneme]]    -- ^ List of lists of Phonems to speak
      -> Wave
      -> IO()
speak lang (word:rest) waveHeader = do
    speakWord lang word waveHeader
    playFile emptyWave
    speak lang rest waveHeader
speak _ [] _ = return ()

-- | Creates a .tmp file with given word (list of phonems) and plays it in given voice
speakWord :: String         -- ^ Name of the voice. It should match the name of the voice folder in the voxDirectory.
            -> [Phoneme]
            -> Wave         -- ^ List of phonems (word) to speak
            -> IO()
speakWord lang word waveHeader = do
    glueSpeech lang [word] tmpFileName waveHeader
    playFile tmpFileName
    --putStrLn (intercalate "," ["tmpFileName"])

-- | Path to the "silent" waveFile
emptyWave :: FilePath
emptyWave = "../vox/std/-"

-- | Name of the .tmp file which w
tmpFileName :: FilePath
tmpFileName = "/Users/jatinkandpal/git/text-to-speech/Webpage/Static/Final_Output/output"

-- | Plays the given wave file
playFile :: String -> IO()
playFile file = callProcess "afplay" [file ++ waveExtension]


