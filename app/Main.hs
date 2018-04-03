
module Main where

import Control.Concurrent.Async
import Control.Monad.IO.Class (liftIO)
import Network.Wai.Handler.Warp
import Servant

import Uhouse.Core.Api
import Uhouse.Core.Persistence
import Uhouse.Core.Sensors


myAPI :: Proxy UhouseApi
myAPI = Proxy

server1 :: Server UhouseApi
server1 = serveTemperature

serveTemperature = liftIO getTemperature

app1 :: Application
app1 = serve myAPI server1

main :: IO ()
main = async (startReading addTemperature) >> run 8081 app1
