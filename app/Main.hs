
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TupleSections     #-}
{-# LANGUAGE TypeOperators     #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Data.Aeson
import Data.Aeson.TH
import Data.Maybe (catMaybes, isJust, listToMaybe, mapMaybe)
import Data.Time.Clock
import Data.Time.Clock.POSIX
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.Cors
import Servant
import Servant.API.ResponseHeaders
import Servant.JS
import Text.Blaze.Html.Renderer.String



import qualified Data.ByteString.Char8 as BSC
import qualified Data.ByteString.Lazy as B



data RawTemperature = RawTemperature { getRawTemp :: String } deriving (Show, Read)

instance ToJSON TempData
data TempData = TempData {
        time          :: Int
        , temperature :: Int
    } deriving (Show, Read, Generic)

type MyApi = "temperature" :> Get '[JSON] [TempData]


myAPI :: Proxy MyApi
myAPI = Proxy



server1 :: Server MyApi
server1 = serveTemp

serveTemp :: Handler [TempData]
serveTemp = liftIO $ (map mapTemp) <$> readTemp

mapTemp :: (UTCTime, RawTemperature) -> TempData
mapTemp (tim, (RawTemperature tem)) = TempData (round . utcTimeToPOSIXSeconds $ tim) (read tem)

filePath = "/home/mitutee/temperature.ds18s20.log"

readTemp :: IO  [(UTCTime, RawTemperature)]
readTemp = catMaybes . (map (\(x, y) -> (x,) <$> y)) . (mapMaybe maybeRead) . lines <$>readFile filePath

maybeRead :: Read a =>  String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

app1 :: Application
app1 = serve myAPI server1

main :: IO ()
main = run 8081 app1
