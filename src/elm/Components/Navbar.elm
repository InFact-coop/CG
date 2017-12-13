module Components.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navbar : Model -> Html Msg
navbar model =
    ul [ class "dn dib ma0 bg-green w-100 pa2" ]
        navbarContent


navbarLink : String -> Html Msg
navbarLink linkStr =
    li [ class "list dib ma3" ] [ a [ class "dn link dim white b", href ("/#" ++ linkStr) ] [ text linkStr ] ]


navbarContent : List (Html Msg)
navbarContent =
    List.map navbarLink
        [ "home"
        , "newContactDetails"
        , "newNotes"
        , "newRecommend"
        , "newShare"
        , "newThankYou"
        , "previousOverview"
        , "previousDetail"
        ]
