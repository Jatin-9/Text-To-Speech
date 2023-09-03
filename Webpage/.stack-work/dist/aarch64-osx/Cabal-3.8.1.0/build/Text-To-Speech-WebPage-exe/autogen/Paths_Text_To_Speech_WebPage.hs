{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_Text_To_Speech_WebPage (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/bin"
libdir     = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/lib/aarch64-osx-ghc-9.4.5/Text-To-Speech-WebPage-0.1.0.0-GeFgU9vZnki2myGU4BH9Sk-Text-To-Speech-WebPage-exe"
dynlibdir  = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/lib/aarch64-osx-ghc-9.4.5"
datadir    = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/share/aarch64-osx-ghc-9.4.5/Text-To-Speech-WebPage-0.1.0.0"
libexecdir = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/libexec/aarch64-osx-ghc-9.4.5/Text-To-Speech-WebPage-0.1.0.0"
sysconfdir = "/Users/jatinkandpal/git/text-to-speech/Webpage/.stack-work/install/aarch64-osx/de895998364870e08a05c8bd089092f918a72de88ef30917dea52d6da1a088fb/9.4.5/etc"

getBinDir     = catchIO (getEnv "Text_To_Speech_WebPage_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "Text_To_Speech_WebPage_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "Text_To_Speech_WebPage_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "Text_To_Speech_WebPage_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Text_To_Speech_WebPage_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Text_To_Speech_WebPage_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
