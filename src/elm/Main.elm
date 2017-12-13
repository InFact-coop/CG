module Main exposing (..)

-- My Elm Files

import DatePicker
import Navigation
import State exposing (..)
import Types exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = always init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
