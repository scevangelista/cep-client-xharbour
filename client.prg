PROCEDURE main   
   LOCAL hIniData    := HB_ReadIni( "config.ini" )
   LOCAL cHost       := LTrim(hIniData["SERVER"]["host"])
   LOCAL cPort       := LTrim(hIniData["SERVER"]["port"])
   LOCAL cVersion    := LTrim(hIniData["SERVER"]["version"])
   LOCAL cUrl        := [http://] + cHost + [:] + cPort + [/api/] + cVersion
   LOCAL cSendUrl, hResponse, hForeach, cKey

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
   

   *****************************************
   ** Módulo Estado
   *****************************************
   ? WaitKey(Hb_AnsiToOem("Módulo Estado"), Hb_AnsiToOem("listar todos os estados"))
   cSendUrl    := cUrl + [/states/country/1058]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))            + " - "
      ?? Hb_AnsiToOem("Nome: ")   + hb_UTF8ToStr(LTrim(hForeach["name"]))   + " - "
      ?? Hb_AnsiToOem("País: ")   + LTrim(str(hForeach["country_code"]))    + " - "
      ?? Hb_AnsiToOem("Sigla: ")  + LTrim(hForeach["initials"])
   NEXT
   
   ? WaitKey(Hb_AnsiToOem("Módulo Estado"), Hb_AnsiToOem("retornar dados do estado 33"))
   cSendUrl    := cUrl + [/states/33]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))            + " - "
      ?? Hb_AnsiToOem("Nome: ")   + hb_UTF8ToStr(LTrim(hForeach["name"]))   + " - "
      ?? Hb_AnsiToOem("País: ")   + LTrim(str(hForeach["country_code"]))    + " - "
      ?? Hb_AnsiToOem("Sigla: ")  + LTrim(hForeach["initials"])
   NEXT

   
   *****************************************
   ** Módulo Cidade
   *****************************************
   ? WaitKey(Hb_AnsiToOem("Módulo Cidade"), Hb_AnsiToOem("listar todas as cidades"))
   cSendUrl    := cUrl + [/cities]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))            + " - "
      ?? Hb_AnsiToOem("Nome: ")   + hb_UTF8ToStr(LTrim(hForeach["name"]))   + " - "
      ?? Hb_AnsiToOem("Estado: ") + LTrim(str(hForeach["state_code"]))
   NEXT

   ? WaitKey(Hb_AnsiToOem("Módulo Cidade"), Hb_AnsiToOem("listar cidades do estado 52"))
   cSendUrl    := cUrl + [/cities/state/52]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))            + " - "
      ?? Hb_AnsiToOem("Nome: ")   + hb_UTF8ToStr(LTrim(hForeach["name"]))   + " - "
      ?? Hb_AnsiToOem("Estado: ") + LTrim(str(hForeach["state_code"]))
   NEXT

   ? WaitKey(Hb_AnsiToOem("Módulo Cidade"), Hb_AnsiToOem("retornar cidade 5221403"))
   cSendUrl    := cUrl + [/cities/5221403]
   hResponse   := Comunicate(cSendUrl)
   FOR EACH hForeach IN hResponse
      ?  Hb_AnsiToOem("Código: ") + LTrim(str(hForeach["code"]))            + " - "
      ?? Hb_AnsiToOem("Nome: ")   + hb_UTF8ToStr(LTrim(hForeach["name"]))   + " - "
      ?? Hb_AnsiToOem("Estado: ") + LTrim(str(hForeach["state_code"]))
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
