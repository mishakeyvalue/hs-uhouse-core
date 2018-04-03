{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module Uhouse.Core.Api
 (
    UhouseApi
 ) where

import Servant

type UhouseApi = "temperature" :> Get '[JSON] [(Int, Double)]
