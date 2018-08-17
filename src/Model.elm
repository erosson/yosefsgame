module Model
    exposing
        ( Msg(..)
        , Model(..)
        , PlayerId(..)
        , Player
        , duration
        , init
        , update
        , subs
        )

import Time as Time exposing (Time)
import AnimationFrame


type Msg
    = Tick Time
    | UserAction PlayerId String


type PlayerId
    = Player1
    | Player2


type Model
    = Loading
    | Ready ReadyModel


type alias ReadyModel =
    { start : Time, now : Time, player1 : Player, player2 : Player }


type alias Player =
    String


duration : { a | start : Time, now : Time } -> Time
duration { start, now } =
    now - start


init : ( Model, Cmd msg )
init =
    ( Loading, Cmd.none )


initPlayer : Int -> Player
initPlayer _ =
    "none"


pureUpdate : Msg -> Model -> Model
pureUpdate msg model =
    case model of
        Loading ->
            case msg of
                Tick t ->
                    Ready { start = t, now = t, player1 = initPlayer 1, player2 = initPlayer 2 }

                _ ->
                    Debug.crash "unexpected action while loading" msg

        Ready model ->
            case msg of
                Tick t ->
                    Ready { model | now = t }

                UserAction Player1 a ->
                    Ready { model | player1 = a }

                UserAction Player2 a ->
                    Ready { model | player2 = a }


update msg model =
    ( pureUpdate msg model, Cmd.none )


subs : Model -> Sub Msg
subs _ =
    AnimationFrame.times Tick
