#include 'protheus.ch'

/*/{Protheus.doc} WFResFnc
WF de resunmo de FNC
@author fabio
@since 20/08/2016
@version 1.0
/*/
class WFResFnc 
	data oRelResFnc
	data cHtmlResm
	
	method new() constructor 
	method wrkFlow()
	method montaHtml()
	method envMail()	
endclass

/*/{Protheus.doc} new
Metodo construtor
@author fabio
@since 20/08/2016 
@version 1.0
/*/
method new() class WFResFnc
	::oRelResFnc 	:= RelResFnc():new()
	::cHtmlResm		:= "" 
return

/*/{Protheus.doc} new
Metodo construtor
@author fabio
@since 20/08/2016 
@version 1.0
/*/
method wrkFlow(cTpResumo) class WFResFnc
	::oRelResFnc:getInfFnc(cTpResumo)
	
	::montaHtml()
	::envMail(cTpResumo)
return

/*/{Protheus.doc} envMail
Envia o e-mail de fato
@author fabio
@since 20/08/2016 
@version 1.0
/*/
method envMail(cTpResumo) class WFResFnc
	local cParDest 		:= GetMv("ZZ_RESRNCM")
	local oEnviaMail	:= EnviaMail():new()
	local cAssunto 		:= "Resumo FNC: " + DtoC(dDataBase) + iif(Alltrim(Upper(cTpResumo)) == ::oRelResFnc:TP_FNC_PEN," - Pendente"," - Cliente")
	
	//cParDest := "fabio@geekercompany.com"
	 		
	oEnviaMail:enviaEmail(::cHtmlResm,cAssunto,cParDest)
return

/*/{Protheus.doc} montaHtml
Monta o html do e-mail
@author fabio
@since 20/08/2016 
@version 1.0
/*/
method montaHtml1() class WFResFnc		
	::cHtmlResm += '<html xmlns="http://www.w3.org/1999/xhtml"> '
	::cHtmlResm += '	<head> '
	::cHtmlResm += '		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> '
	::cHtmlResm += '		<title>Untitled Document</title> '
	::cHtmlResm += '	</head> '
	::cHtmlResm += '	<body> '
	::cHtmlResm += '	<table width="80%" border="1" cellspacing="1" cellpadding="1"> '
	::cHtmlResm += '<tr bgcolor="#C5D9F1"> '
	::cHtmlResm += '		    <th width="10%" scope="col">ID RNC</th> '
	::cHtmlResm += '		    <th width="10%" scope="col">Revisão</th> '
	::cHtmlResm += '		    <th width="30%" scope="col">Status</th> '
	::cHtmlResm += '		    <th width="30%" scope="col">Responsável</th> '
	::cHtmlResm += '		    <th width="10%" scope="col">Data processo</th> '
	::cHtmlResm += '		    <th width="10%" scope="col">Inclusão</th> '	
	::cHtmlResm += '	      </tr> '

	for nI := 1 to Len(::oRelResFnc:aDados)			
		::cHtmlResm += '		  <tr> '
		::cHtmlResm += '		    <td>'+ ::oRelResFnc:aDados[nI]:cNumFnc			+'</td> '
		::cHtmlResm += '		    <td>'+ ::oRelResFnc:aDados[nI]:cRevFnc			+'</td> '
		::cHtmlResm += '		    <td>'+ ::oRelResFnc:aDados[nI]:cStatus			+'</td> '
		::cHtmlResm += '		    <td>'+ ::oRelResFnc:aDados[nI]:cRespon			+'</td> '
		::cHtmlResm += '		    <td>'+ DtoC(::oRelResFnc:aDados[nI]:dDtRespo)	+'</td> '
		::cHtmlResm += '		    <td>'+ DtoC(::oRelResFnc:aDados[nI]:dDtCria)	+'</td> '
		::cHtmlResm += '	      </tr> '	
	next nTitulo

	::cHtmlResm += '    </table> '
	::cHtmlResm += '	</body> '
	::cHtmlResm += '</html> '
return
