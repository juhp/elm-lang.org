
import Signal.HTTP (gets)
import Signal.Input (stringDropDown)
import Foreign.JavaScript.JSON

(zipPicker, zipCode) = stringDropDown [ "10001", "90210", "12345" ]
    
detail =
  let toUrl s = Just $ "http://zip.elevenbasetwo.com/v2/US/" ++ s in
  lift extract . gets $ lift toUrl zipCode
           
extract response =
  case response of
  { Just (Success json) -> findWithDefault JsonNull "city" $ fromString json
  ; _ -> JsonNull }

display info =
  flow down [ zipPicker, plainText "is the zip code for", asText info ]
  
main = lift display detail