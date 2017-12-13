module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "tc center main vh-100 ma0" ]
        [ img [ class "center pt3 h6", src "./assets/png's/homepage_logo.png" ] []
        , section [ class "center ma0 pt3" ]
            [ a [ href "#previousOverview", class "link dib ma3" ]
                [ img [ src "./assets/svg_icons/see_conn.svg" ] []
                , p [] [ text "See interactions" ]
                ]
            , a [ href "#newContactDetails", class "link dib ma3" ]
                [ img [ src "./assets/svg_icons/add_new.svg" ] []
                , p [] [ text "Add new" ]
                ]
            ]
        ]
