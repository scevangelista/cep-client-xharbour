PROCEDURE main   
   LOCAL hIniData    := HB_ReadIni( "config.ini" )
   LOCAL cHost       := LTrim(hIniData["SERVER"]["host"])
   LOCAL cPort       := LTrim(hIniData["SERVER"]["port"])
   LOCAL cVersion    := LTrim(hIniData["SERVER"]["version"])
   local cUrl        := [http://] + cHost + [:] + cPort + [/api/] + cVersion
   local cSendUrl, hResponse, hForeach, cKey

   CLS 
   ? Hb_AnsiToOem("Exemplos de Uso da API CEP")


   *****************************************
   ** Módulo País
   *****************************************   
   WaitKey(Hb_AnsiToOem("Módulo País"), "listar os paises")
   cSendUrl    := cUrl + [/countries]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))  + " - "
      ?? Hb_AnsiToOem("Nome: ")   + LTrim(hForeach["name"])       + " - "
      ?? Hb_AnsiToOem("Sigla: ")  + LTrim(hForeach["initials"])
   NEXT

   WaitKey(Hb_AnsiToOem("Módulo País"), Hb_AnsiToOem("retornar dados do País 1058"))
   cSendUrl    := cUrl + [/countries/1058]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))  + " - "
      ?? Hb_AnsiToOem("Nome: ")   + LTrim(hForeach["name"])       + " - "
      ?? Hb_AnsiToOem("Sigla: ")  + LTrim(hForeach["initials"])
   NEXT
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


********************************************
PROCEDURE WaitKey
   PARAM cModule, cMessage
   LOCAL cInput
   Inkey(5)
   CLS
   ? cModule
   __Wait("Pressione uma tecla para " + cMessage + [: ])
   ?
   ? "Resultado: "
RETURN