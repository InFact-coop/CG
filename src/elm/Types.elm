module Types exposing (..)

import Date exposing (..)
import Navigation
import Dict


-- Model


type Route
    = HomeRoute
    | NewDateRoute
    | NewNotesRoute
    | NewRecommendRoute
    | NewShareRoute
    | NewFollowUpRoute
    | NewAddToDBRoute
    | NewEndRoute
    | NotFoundRoute
    | NewOrOldContactRoute
    | NewCreateContactRoute


type alias Model =
    { route : Route
    , currentContact : Maybe Contact
    , currentConnection : Maybe Connection
    , recordedContacts : List Contact
    , recordedConnections : List Connection
    , fieldInputs : Dict.Dict String String
    , contactInput : String
    }


type alias Connection =
    { connectionId : Int
    , date : Date
    , notes : List String
    , tags : Tags
    , recommendations : Maybe Recommendation
    , followUpDate : Date
    }


type alias Contact =
    { contactId : Int
    , name : String
    , organisation : String
    , email : String
    , phone : Int
    , connections : List Int
    }


type alias Recommendation =
    { name : String
    , organisation : String
    }


type Tags
    = Artist
    | CGmember
    | Event



-- Update


type Msg
    = UrlChange Navigation.Location
    | ChangeModelInput String String
    | SetContact String
