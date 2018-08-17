module View exposing (view)

import Html as H
import Html.Attributes as A
import Html.Events as E
import Model as M


view : M.Model -> H.Html M.Msg
view model =
    case model of
        M.Loading ->
            H.text "loading..."

        M.Ready model ->
            H.div []
                [ H.div [] [ H.text <| "time: " ++ (toString <| M.duration model) ]
                , H.div [] [ H.text "p1: ", viewPlayer M.Player1 model.player1 ]
                , H.div [] [ H.text "p2: ", viewPlayer M.Player2 model.player2 ]
                , H.hr [] []
                , model |> toString |> H.text
                ]


viewPlayer : M.PlayerId -> M.Player -> H.Html M.Msg
viewPlayer id player =
    let
        button action =
            H.button [ E.onClick <| M.UserAction id action ] [ H.text action ]
    in
        H.div []
            [ H.div [] [ H.text <| toString id ]
            , H.div [] [ H.text <| "last action: " ++ player ]
            , button "grow"
            , button "split"
            , button "burst"
            , button "attack"
            ]
