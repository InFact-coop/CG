module Types exposing (..)

import Date exposing (..)
import Navigation


-- Model


type Route
    = HomeRoute
    | NewContactDetailsRoute
    | NewNotesRoute --| with date
    | NewRecommendRoute --| with tags
    | NewShareRoute --| with follow up date
    | NewThankYouRoute
    | PreviousInteractionsOverviewRoute
    | PreviousInteractionsDetailRoute
    | NotFoundRoute


type alias Model =
    { route : Route
    , currentInteraction : Interaction
    , recordedInteractions : List Interaction
    , notesPage : NoteState
    , isRecording : Bool
    }


type NoteState
    = Choose
    | Text
    | Audio


type alias Interaction =
    { name : String
    , organisation : String
    , email : String
    , phone : String
    , notes : Notes
    , tags : List Tags
    , recommendations : List Recommendation
    , followUpDate : Maybe Date
    }


type alias Recommendation =
    { name : String
    , organisation : String
    }


type alias Notes =
    { text : String
    , audioUrl : String
    }


type Tags
    = Artist
    | CGmember
    | Event



-- Update


type Msg
    = UrlChange Navigation.Location
    | SetContactName String
