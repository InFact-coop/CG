module State exposing (..)

import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , currentContact = Nothing
    , recordedContacts = []
    , recordedConnections = []
    }



--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "" ->
            HomeRoute

        "#home" ->
            HomeRoute

        "#newOrOldContact" ->
            NewOrOldContactRoute

        "#newCreateContact" ->
            NewCreateContactRoute

        "#newDate" ->
            NewDateRoute

        "#newNotes" ->
            NewNotesRoute

        "#newRecommend" ->
            NewRecommendRoute

        "#newShare" ->
            NewShareRoute

        "#newFollowUp" ->
            NewFollowUpRoute

        "#newAddToDB" ->
            NewAddToDBRoute

        "#newEnd" ->
            NewEndRoute

        _ ->
            NotFoundRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | route = (getRoute location.hash) }, Cmd.none )
