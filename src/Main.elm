module Main exposing (main)

import Html as H
import Model
import View


main =
    H.program
        { init = Model.init
        , update = Model.update
        , subscriptions = Model.subs
        , view = View.view
        }
