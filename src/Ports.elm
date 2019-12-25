port module Ports exposing (askCookie, updateCookie, CookieValue)


type alias CookieValue =
    String


type alias CookieName =
    String


port updateCookie : (Maybe CookieValue -> msg) -> Sub msg


port askCookie : CookieName -> Cmd msg
