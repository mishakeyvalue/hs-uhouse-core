{-# LANGUAGE OverloadedStrings #-}

module Uhouse.Core.Internal.Persistence where

import Database.SQLite.Simple

initDb' conn = do
    let exec = execute_ conn
    exec "CREATE TABLE Temperature (time INTEGER, value REAL);"

addTemperature' :: Connection -> (Int, Double) -> IO ()
addTemperature' conn d = execute conn "INSERT INTO Temperature VALUES (?, ?)" d

getTemperature' :: Connection -> IO [(Int, Double)]
getTemperature' conn = query_ conn "SELECT time, value FROM Temperature"
