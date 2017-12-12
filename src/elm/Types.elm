module Types exposing (..)

import Date exposing (..)
import Navigation


-- Model


type Route
    = HomeRoute
    | NewDateRoute
    | NewContactRoute
    | NewNotesRoute
    | NewRecommendRoute
    | NewShareRoute
    | NewFollowUpRoute
    | NewAddToDBRoute
    | NewEndRoute
    | NotFoundRoute


type alias Model =
    { route : Route
    , userInput : String
    }


type alias Connection =
    { connectionId : Int
    , date : Date
    , name : String
    , email : String
    , phone : Int
    , notes : List String
    , tags : Tags
    , recommendations : List Recommendations
    , followUpDate : Date
    }


type Tags
    = Artist
    | CGmember
    | Event


type alias Recommendations =
    { name : String
    , organisation : String
    }



-- Update


type Msg
    = Change String
    | UrlChange Navigation.Location
