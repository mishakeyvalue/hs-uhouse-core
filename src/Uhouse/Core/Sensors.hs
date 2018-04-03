{-# LANGUAGE TypeApplications #-}

module Uhouse.Core.Sensors
 (
      Temperature
    , UnixTime
    , TemperatureLog
    , startReading
 ) where

import Data.Time.Clock.POSIX (getPOSIXTime)
import Time (Second, Time, threadDelay)

import Uhouse.Hardware.DS18B20 (Temperature, getTemperatureFile, initModprobe, readTemp)

type UnixTime = Int
type TemperatureLog = (UnixTime, Temperature)

defaultThreadDelay = threadDelay @Second 1

startReading :: (TemperatureLog -> IO()) -> IO ()
startReading wr = do
    file <- getTemperatureFile
    go file
      where
        go :: FilePath -> IO ()
        go file = do
            temp <- readTemp file
            currTime <- round <$> getPOSIXTime
            let d = sequenceA (currTime, temp)
            mapM_ wr d
            defaultThreadDelay
            go file

