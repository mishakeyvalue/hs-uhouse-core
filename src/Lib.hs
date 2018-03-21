{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where


someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- import Codec.Serialise
-- import Control.Exception.Base (bracket)
-- import Data.ByteString (ByteString)
-- import Data.Default (def)
-- import GHC.Generics

-- import qualified Data.ByteString as BS
-- import qualified Data.ByteString.Lazy as BSL
-- import qualified Database.RocksDB as Rocks

-- data TimeBinding = LightBinding { lightId :: Int, fromTime :: Int, toTime :: Int} deriving (Show, Generic)

-- instance Serialise TimeBinding where



-- toStrict :: BSL.ByteString -> ByteString
-- toStrict = BS.concat . BSL.toChunks

-- withRocksDB = withRocksDB' dbPath

-- sampleBinding = LightBinding 12 155 166

-- dbPath :: FilePath
-- dbPath = "_mydb"

-- withRocksDB' :: FilePath -> (Rocks.DB -> IO c) -> IO c
-- withRocksDB' path = bracket (openDB path) Rocks.close

-- openDB path = Rocks.open path def { Rocks.createIfMissing = True }
