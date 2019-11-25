module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Canvas
import Html exposing (Html, div)
import Html.Attributes
import Html.Events


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    String


type alias Ints =
    List Int


type Msg
    = SetImageData Ints
    | Act


view : Model -> Html Msg
view m =
    Html.div
        [ Html.Attributes.style "background-color" "#dc5052"
        , Html.Attributes.style "margin" "0"
        , Html.Attributes.style "padding" "10px"
        ]
        [ Html.button [ Html.Events.onClick Act ] [ Html.text "Act" ] ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetImageData s ->
            let
                ss =
                    Debug.log "imagedata" s
            in
            ( model, Canvas.putImageData s )

        Act ->
            ( model, Canvas.getImageData () )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Canvas.setImageData SetImageData


init : flasgs -> ( Model, Cmd msg )
init _ =
    ( ""
    , Cmd.none
    )
