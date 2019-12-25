module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Ports exposing (CookieValue, askCookie, updateCookie)



---- MODEL ----


type alias Model =
    Maybe CookieValue


init : ( Model, Cmd Msg )
init =
    ( Nothing, askCookie "some_cookie" )



---- UPDATE ----


type Msg
    = GotCookie (Maybe CookieValue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCookie maybeCookie ->
            ( maybeCookie, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        cookieText =
            case model of
                Just c ->
                    text c

                Nothing ->
                    text "Did not get any cookie"
    in
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ cookieText ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = \_ -> updateCookie GotCookie
        }
