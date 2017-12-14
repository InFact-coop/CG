port module Subscriptions exposing (..)

import Types exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ audioUrl RecieveAudio
        ]


port recordStart : () -> Cmd msg


port recordStop : () -> Cmd msg


port audioUrl : (String -> msg) -> Sub msg


port playStart : Bool -> Cmd msg
