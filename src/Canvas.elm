port module Canvas exposing (getImageData, putImageData, setImageData)


port getImageData : () -> Cmd msg


port putImageData : List Int -> Cmd msg


port setImageData : (List Int -> msg) -> Sub msg
