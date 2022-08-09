PROCEDURE main   
   LOCAL hIniData    := HB_ReadIni( "config.ini" )
   LOCAL cHost       := LTrim(hIniData["SERVER"]["host"])
   LOCAL cPort       := LTrim(hIniData["SERVER"]["port"])
   LOCAL cVersion    := LTrim(hIniData["SERVER"]["version"])
   local cUrl        := [http://] + cHost + [:] + cPort + [/api/] + cVersion

   
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