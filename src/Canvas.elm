port module Canvas exposing (..)


port getImageData : () -> Cmd msg


port putImageData : List Int -> Cmd msg


port setImageData : (List Int -> msg) -> Sub msg
