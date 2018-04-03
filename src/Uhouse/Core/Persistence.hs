module Uhouse.Core.Persistence
(
      initDb
    , addTemperature
    , getTemperature
) where

import Database.SQLite.Simple (withConnection)

import Uhouse.Core.Internal.Persistence

defaultDb = "uhouse.db"

addTemperature :: (Int, Double) -> IO ()
addTemperature d = withConnection defaultDb (\c -> addTemperature' c d)

getTemperature :: IO [(Int, Double)]
getTemperature = withConnection defaultDb getTemperature'

initDb = withConnection defaultDb initDb'
