module Types exposing (..)

import Date exposing (..)
import DatePicker
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
    , datePicker : DatePicker.DatePicker
    }


type NoteState
    = Choose
    | Text
    | Audio


type alias Interaction =
    { interactionDate : Maybe Date
    , name : String
    , organisation : String
    , email : String
    , phone : String
    , notes : Notes
    , tags : String
    , recommendations : List Recommendation
    , followUpDate : Maybe Date
    , currentMember : CurrentMemberOptions
    }


type CurrentMemberOptions
    = CurrentMemberNotSet
    | CurrentMemberYes
    | CurrentMemberNo


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
    | SetContactEmail String
    | SetContactPhone String
    | SetContactOrganisation String
    | GoBack
    | SetCurrentContact CurrentMemberOptions
    | ChangeNotes NoteState
    | UpdateTextNote String
    | RequestDate
    | ReceiveDate Date
    | SetDatePicker DatePicker.Msg
    | StartRecording
    | StopRecording
    | RecieveAudio String
    | PlayAudio Bool
    | ReRecord
    | UpdateTags String
