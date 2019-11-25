module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Canvas
import Html exposing (Html, div)
import Html.Attributes
import Html.Events
import List.Extra


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
        [ Html.Attributes.style "background-color" ""
        , Html.Attributes.style "margin" "0"
        , Html.Attributes.style "padding" "10px"
        ]
        [ Html.button [ Html.Events.onClick Act ] [ Html.text "Act" ] ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetImageData s ->
            let
                new =
                    fuckitup s
            in
            ( model, Canvas.putImageData new )

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


fuckitup : List Int -> List Int
fuckitup ints =
    fuck [] 0 ints |> List.reverse


fuck : List Int -> Int -> List Int -> List Int
fuck outs error ints =
    case ints of
        [ r, g, b, a ] ->
            let
                ( abgr, nerror ) =
                    honk a b g r error
            in
            abgr ++ outs

        r :: g :: b :: a :: rest ->
            let
                ( abgr, nerror ) =
                    honk a b g r error
            in
            fuck (abgr ++ outs) nerror rest

        [] ->
            []

        _ ->
            []


honk : Int -> Int -> Int -> Int -> Int -> ( List Int, Int )
honk a b g r error =
    let
        gray =
            r + b // 2

        witherror =
            gray + error

        mono =
            \x -> ((x |> toFloat) / 256 |> round) * 256

        monoavg =
            mono witherror

        newerror =
            witherror - monoavg
    in
    ( [ monoavg, 255, 255, 255 ], newerror )
