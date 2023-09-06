module Soundgluer (module Soundgluer) where

import System.Directory

import Control.Monad

import qualified Data.Map as M
import qualified Data.Text as T -- pack, unpack, takeEnd, dropEnd
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Builder as B
import System.Process (callCommand)
import Codec.Audio.Wave
import HspTypes (Phoneme)
import Data.List


defaultWave :: Wave
defaultWave =
  Wave
    { waveFileFormat = WaveVanilla,
      waveSampleRate = 44100,
      waveSampleFormat = SampleFormatPcmInt 16,
      waveChannelMask = speakerStereo,
      waveDataOffset = 0,
      waveDataSize = 0,
      waveSamplesTotal = 0,
      waveOtherChunks = []
    }



-- | Extension of audio files representing phonems.
waveExtension :: FilePath
waveExtension = ".wav"

-- | Probably a naive reimplementation of some builtin.
pathSeparator :: FilePath
pathSeparator = "/"

-- -- | Name of the root languages directory.
-- langsDirectory :: FilePath
-- langsDirectory = "lang"

-- | Name of the folder containing standard phonems (like silence), which appear accross all languages.
stdVox :: FilePath
stdVox = "../vox/std"

-- | Name of the directory containing voice files
voxDirectory :: FilePath
voxDirectory = "../vox"

-- | Path of the wave header used during generation of the output.
waveHeaderPath :: FilePath
waveHeaderPath = voxDirectory ++ pathSeparator ++ stdVox ++ pathSeparator ++ "header.wav"

-- | Converts a list of phonemized words into an audio representation in some voice and writes it to a file.
glueSpeech :: String        -- ^ Name of the voice. It should match the name of the voice folder in the voxDirectory.
           -> [[Phoneme]]     -- ^ List of phonemized words
           -> String       -- ^ Path of the output file
           -> Wave
           -> IO ()
glueSpeech vox words filePath waveHeaders
        | null words = return ()
        | otherwise = do
            --putStrLn waveHeaderPath
            putStrLn (intercalate ";" (intercalate [","] words))
            phoneSpeechMap <- loadVoxAudio vox
            --phoneAudioMap <- loadVoxAudio vox
            --waveHeader <- readWaveFile waveHeaderPath [needed to remove as it was overriding the WaveHeader argument sent from Mains.hs module]
            let appendWord w1 w2 = w1 `mappend` (phoneSpeechMap M.! "-") `mappend` w2
            let gluedSpeech = foldr appendWord (mempty :: B.Builder)
                            $ map (wordToSpeech phoneSpeechMap) words
            let phonesWriter = flip B.hPutBuilder gluedSpeech
            
            --made changes to writeWaveFile
            writeWaveFile (filePath ++ waveExtension) waveHeaders phonesWriter


-- The quick brown fox jumps over the lazy dog

-- ## test
--did test for the glueSpeech but faced the same white noise but only this works as it is atleast palying the sound

--glueSpeech "luknz" [["b", "d"], ["h", "b"]] "outputFileName"            

-- | Maps word to speech using provided map
wordToSpeech :: M.Map Phoneme B.Builder    -- ^ Phone-(audio data) map
            -> [Phoneme]                   -- ^ Mapped word
            -> B.Builder                 -- ^ Lazy ByteString Builder of audio data
wordToSpeech phoneSpeechMap word =
    mconcat $ map (phoneSpeechMap M.!) word

-- ## test
-- even this not playing

testWordToSpeech :: [Phoneme] -> IO ()
testWordToSpeech ps = do
   allAudio <- loadVoxAudio "luknz"
   let phonemeAudio = wordToSpeech allAudio ps
   -- L.writeFile "testWordToSpeech.wav" phonemeAudio
   waveHeader <- readWaveFile waveHeaderPath
   writeWaveFile "testWordToSpeech.wav" defaultWave (flip B.hPutBuilder phonemeAudio)

-- | Loads lazily phonems of a given voice into memory.
loadVoxAudio :: String                        -- ^ Language name with a matching folder in langsDirectory
              -> IO (M.Map Phoneme B.Builder)    -- ^ Map from phonem name to its audio data as a lazy ByteString Builder
loadVoxAudio vox =
    M.union <$> loadVoxAudio' vox <*> loadVoxAudio' stdVox
  where
    loadVoxAudio' vox = do
        let voxDirectory = getVoxPath vox
        dirWaves <- filter isWave <$> listDirectory voxDirectory
        --putStrLn (intercalate "," dirWaves)
        phoneAudioList <- zip <$> (return $ map phoneName dirWaves)
                              <*> forM dirWaves (getAudioData voxDirectory)

        -- ## test
        -- taking the phoneme part from the phoneAudioList (Phoneme, Audio Dta for that particular phoneme)
        -- let phoneNames = map fst phoneAudioList
        -- putStrLn(intercalate "," phoneNames) --[this is working fine the phoneName is correct]
        return $ M.fromList phoneAudioList

-- ## test
-- -- no output is found means for a given a phoneme it is not able to fetch an audio

testingOutputAudio :: FilePath -> IO()
testingOutputAudio vox = do
    allAudio <- loadVoxAudio vox
    let somePhoneAudio = M.lookup "b.wav" allAudio
    case somePhoneAudio of
        Just audios -> do
            let audioFormat = audios
            waveHeader <- readWaveFile waveHeaderPath
            writeWaveFile "temp_audio.wav" defaultWave (flip B.hPutBuilder audioFormat)
            --callCommand "afplay temp_audio.wav"
        Nothing -> putStrLn "No Phoneme sound in the map found"     --[ when running this it doesnt output any sound but give this string as a result]


-- ## test
-- tried to play all the phoneme one by one but failed

-- testingOutputAudio :: IO()
-- testingOutputAudio = do
--     allAudio <- loadVoxAudio "luknz"
--     -- get all keys (phoneme names) from the map
--     let phonemes = M.keys allAudio

--     forM_ phonemes $ \phoneme -> do
--         let somePhoneAudio = M.lookup phoneme allAudio
--         case somePhoneAudio of
--             Just audios -> do
--                 let audioData = B.toLazyByteString audios
--                 L.writeFile "temp_audio.wav" audioData
--                 putStrLn $ "Playing audio for phoneme: " ++ phoneme
--                 callCommand "afplay temp_audio.wav"
--                 doesFileExist "temp_audio.wav" >>= \exists ->
--                   when (not exists) $ putStrLn "File does not exist!"
--             Nothing -> putStrLn $ "No audio found for phoneme: " ++ phoneme



-- | Checks using extension if file has the WAV format.
isWave :: FilePath      -- ^ Path of the checked file
       -> Bool          -- ^ Is it a WAV?
isWave fileName = waveExtension == ( T.unpack
                                   . T.takeEnd (length waveExtension)
                                   . T.pack
                                   $ fileName)

-- | Extracts the phone name from a file name.
phoneName :: FilePath     -- ^ File name
          -> String       -- ^ Extracted phone name
phoneName fileName = T.unpack
                   . T.dropEnd (length waveExtension)
                   . T.pack
                   $ fileName

-- | Returns path to the directory of a specified voice.
getVoxPath :: String           -- ^ Name of the voice matching its folder name
            -> FilePath         -- ^ Path to a specific voice folder
getVoxPath vox = voxDirectory ++ pathSeparator ++ vox

-- | Loads into memory raw audio data without header from a single wave file and returns a Builder of a lazy ByteString.
getAudioData :: FilePath        -- ^ Voice directory as returned by getLangPath
             -> FilePath        -- ^ Name of a wave file to read
             -> IO B.Builder    -- ^ Lazy ByteString Builder
getAudioData voxDirectory fileName = do
    let wavePath = voxDirectory ++ pathSeparator ++ fileName
    waveMetadata <- readWaveFile wavePath
    waveData <- L.readFile wavePath
    let waveHeaderLength = fromIntegral $ waveDataOffset waveMetadata
    return $ B.lazyByteString
           $ L.drop waveHeaderLength waveData

-- ## test
-- this is not working either

testGetAudioData :: IO ()
testGetAudioData = do
    audioDataBuilder <- getAudioData "../vox/luknz" "b.wav"
    L.writeFile "testGetAudioData.wav" (B.toLazyByteString audioDataBuilder)
    --callCommand "afplay testGetAudioData.wav"

-- | Utility for generating a wave file containing only a header and no audio data.
generateHeader :: IO ()
generateHeader = do
    a <- readWaveFile $ (getVoxPath stdVox) ++ pathSeparator ++ "-.wav"
    writeWaveFile waveHeaderPath a (\h -> return ())

-- ## test
-- noticed that I can find this directory but when i tried to play it it shows error " AudioFileOpen failed ('typ?') "

concatenate :: IO ()
concatenate = do
    bAudio <- getAudioData "../vox/luknz/"  "b.wav"
    let combinedAudio = bAudio `mappend` bAudio
    writeWaveFile"combinedB.wav" defaultWave(flip B.hPutBuilder combinedAudio)