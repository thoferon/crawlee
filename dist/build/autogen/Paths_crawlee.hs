module Paths_crawlee (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/thoferon/.cabal/bin"
libdir     = "/Users/thoferon/.cabal/lib/crawlee-0.1.0.0/ghc-7.4.2"
datadir    = "/Users/thoferon/.cabal/share/crawlee-0.1.0.0"
libexecdir = "/Users/thoferon/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "crawlee_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "crawlee_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "crawlee_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "crawlee_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
