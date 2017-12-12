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
    , currentContacts : List Contact
    }


type alias Connection =
    { date : Date
    , notes : List String
    , tags : Tags
    , recommendations : Maybe List Contact
    , followUpDate : Date
    }


type alias Contact =
    { name : String
    , email : String
    , phone : Int
    , connections : List Contection
    }


type Tags
    = Artist
    | CGmember
    | Event



-- Update


type Msg
    = Change String
    | UrlChange Navigation.Location
