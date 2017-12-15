module Types exposing (..)

import Date exposing (..)
import DatePicker
import Navigation


-- Model


type Route
    = HomeRoute
    | NewContactDetailsRoute
    | NewNotesRoute
    | NewRecommendRoute
    | PreviousInteractionsOverviewRoute
    | PreviousInteractionsDetailRoute
    | NotFoundRoute


type alias Model =
    { route : Route
    , currentInteraction : Interaction
    , recordedInteractions : List Interaction
    , notesPage : NoteState
    , isRecording : Bool
    , liveInteraction : Interaction
    , searchInput : String
    , datePicker : DatePicker.DatePicker
    , detailsPage : DetailsState
    , newRecommend : Recommendation
    , shared1 : Bool
    , shared2 : Bool
    , shared3 : Bool
    , shared4 : Bool
    , shared5 : Bool
    , dataProtect : Bool
    }


type NoteState
    = Choose
    | Text
    | Audio


type DetailsState
    = ChooseDeets
    | Recommendations
    | FollowUp
    | Share


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
    , event : String
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


tagToString : Tags -> String
tagToString tags =
    case tags of
        Artist ->
            "Artist"

        CGmember ->
            "CGmember"

        Event ->
            "Event"



-- Update


type Msg
    = UrlChange Navigation.Location
    | SetContactName String
    | SelectInteractionItem Interaction
    | SetSearchInput String
    | SetContactEmail String
    | SetContactPhone String
    | SetContactOrganisation String
    | SetContactWhere String
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
    | ChangeDetails DetailsState
    | SetNewRecName String
    | SetNewRecOrg String
    | AddRecommendations Recommendation
    | Shared1
    | Shared2
    | Shared3
    | Shared4
    | Shared5
    | SetDatePickerF DatePicker.Msg
    | AddInteraction
    | DataProtect
