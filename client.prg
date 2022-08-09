PROCEDURE main   

RETURN


********************************************
FUNCTION Comunicate
   PARAM cUrl
   LOCAL oUrl := TUrl():new(cUrl)
   LOCAL oHttp, cJson
   LOCAL hEvent := {=>}

   oHttp:= TIpClientHttp():new(cUrl)
   IF oHttp:open()
      cJson := oHttp:readAll()
      oHttp:close()
      HB_JsonDecode(cJson , @hEvent)
   ELSE
      ? "Connection error:", oHttp:lastErrorMessage()
   ENDIF
RETURN hEvent