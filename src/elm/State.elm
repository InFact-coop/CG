module State exposing (..)

import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , currentContact = Nothing
    , currentConnection = Nothing
    , recordedContacts = initRecordedContacts
    , recordedConnections = []
    }


initRecordedContacts : List Contact
initRecordedContacts =
    [ Contact 1 "Alexa Vega" "PHS Limited" "alexavega@gmail.com" 7598772611 [ 1 ]
    , Contact 2 "Daryl Sabara" "Cortez Ltd" "darylsabara@cortez.com" 7532172611 [ 2 ]
    , Contact 3 "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" 7598772987 [ 1 ]
    ]



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
