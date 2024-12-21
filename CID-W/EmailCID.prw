#include 'totvs.ch'
#include "Protheus.ch"
#include 'topconn.ch'
#include "tbiconn.ch"
user function EmailCID()
    RPCSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
          
	    u_uEmailCID()

	RESET ENVIRONMENT

return
user function uEmailCID()
    local oExeMail
    
          oExeMail := MailCID():new()
 
          oExeMail:wrkFlow()
         
return 
class MailCID

    data oDadosCID
    data cAliasQry 

    data cIdCID
    data cHtmlQuery 
    data cQuery

    method new() constructor
    method wrkFlow()
    method montaHtml()
    method enviaMAIL()
    method get_infCID()
endclass

method new() class MailCID

    ::cIdCID       := "000002"
    ::cHtmlQuery   := ""
    ::cAliasQry := GetNextAlias()
    ::oDadosCID    := NIl

return
method wrkFlow() class MailCID	

	::get_infCID()

	::montaHtml()
	::enviaMAIL()
return
method enviaMAIL() class MailCID
	local cParDest 		:= "joaogabrielcouto925@outlook.com"
	local oEnviaMail	:= EnviaMail():new()
	local cAssunto 		:= "Pendêcias relacionadas a processos internos de devolução"
	
	//cParDest := "fabio@geekercompany.com"
	 		
	oEnviaMail:enviaEmail(::cHtmlQuery,cAssunto,cParDest)
return

method montaHtml() class MailCID
    //local ::cAliasQry := GetNextAlias()
    ::cHtmlQuery += '<html xmlns="http://www.w3.org/1999/xhtml"> '
	::cHtmlQuery += '	<head> '
	::cHtmlQuery += '		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> '
	::cHtmlQuery += '		<title>Untitled Document</title> '
	::cHtmlQuery += '	</head> '
	::cHtmlQuery += '	<body> '
	::cHtmlQuery += '	<table width="80%" border="1" cellspacing="1" cellpadding="1"> '
	::cHtmlQuery += '<tr bgcolor="#C5D9F1"> '
	::cHtmlQuery += '		    <th width="10%" scope="col">ID CID</th> '
	::cHtmlQuery += '		    <th width="10%" scope="col">Comercial</th> '
	::cHtmlQuery += '		    <th width="10%" scope="col">Fiscal</th> '
	::cHtmlQuery += '		    <th width="20%" scope="col">Financeiro</th> '
	::cHtmlQuery += '		    <th width="10%" scope="col">Logistica</th> '
	::cHtmlQuery += '		    <th width="10%" scope="col">Logistiva</th> '
    ::cHtmlQuery += '		    <th width="10%" scope="col">Fiscal</th> '
    ::cHtmlQuery += '		    <th width="10%" scope="col">Financeiro</th> '
    ::cHtmlQuery += '		    <th width="10%" scope="col">Qualidade</th> '
    ::cHtmlQuery += '		    <th width="10%" scope="col">Logistica</th> '        	
	::cHtmlQuery += '	      </tr> '
	
     while(!(::cAliasQry)->(Eof()))			
		::cHtmlQuery += '		  <tr> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_ID)			+'</td> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_CRIADT + Z83_CRIAHR + Z83_CRIAUS + Z83_CRIASN)+'</td> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_SIMDT  + Z83_SIMHR  + Z83_SIMUS  + Z83_SIMSN)+'</td> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_COBDT  + Z83_COBHR  + Z83_COBUS  + Z83_COBSN)+'</td> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_AGEDT  + Z83_AGEHR  + Z83_AGEUS  + Z83_AGESN)+'</td> '
		::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_RECDT  + Z83_RECHR  + Z83_RECUS  + Z83_RECSN)+'</td> '
        ::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_CONFDT + Z83_CONFHR + Z83_CONFUS  + Z83_CONFSN)+'</td> '
        ::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_QUALDT + Z83_QUALHR + Z83_QUALUS + Z83_QUALSN)+'</td> '
        ::cHtmlQuery += '		    <td>'+ AllTrim((::cAliasQry)->Z83_LOGDT  + Z83_LOGHR  + Z83_LOGUS  + Z83_LOGSN )+'</td> '
		::cHtmlQuery += '	      </tr> '	
	(::cAliasQry)->(DbSkip())
    enddo

	::cHtmlQuery += '    </table> '
	::cHtmlQuery += '	</body> '
	::cHtmlQuery += '</html> '
    
    if(Select(::cAliasQry) > 0)
	  (::cAliasQry)->(DbCloseArea())
	endIf
return 

method get_infCID() class MailCID

    local ::cAliasQry := GetNextAlias()
    local cQuery    := ""
    

    cQuery += CRLF + "  SELECT                                           "
    cQuery += CRLF + "  Z83_ID,                                          "               
    cQuery += CRLF + "  Z83_CRIADT, Z83_CRIAHR, Z83_CRIAUS, Z83_CRIASN,  "
    cQuery += CRLF + "  Z83_SIMDT , Z83_SIMHR , Z83_SIMUS , Z83_SIMSN,   "
    cQuery += CRLF + "  Z83_COBDT , Z83_COBHR , Z83_COBUS , Z83_COBSN,   "
    cQuery += CRLF + "  Z83_AGEDT , Z83_AGEHR , Z83_AGEUS , Z83_AGESN,   "
    cQuery += CRLF + "  Z83_RECDT , Z83_RECHR , Z83_RECUS , Z83_RECSN,   "
    cQuery += CRLF + "  Z83_CONFDT, Z83_CONFHR, Z83_CONFUS, Z83_CONFSN,  "
    cQuery += CRLF + "  Z83_ABATDT, Z83_ABATHR, Z83_ABATUS, Z83_ABATSN,  "
    cQuery += CRLF + "  Z83_QUALDT, Z83_QUALHR, Z83_QUALUS, Z83_QUALSN,  "
    cQuery += CRLF + "  Z83_LOGDT , Z83_LOGHR , Z83_LOGUS , Z83_LOGSN    "
    cQuery += CRLF + "  FROM "+ RetSqlName("Z83") +" Z83                 "
    cQuery += CRLF + "  WHERE   Z83.Z83_FILIAL  = '"+ xFilial("Z83")+"'    "
    cQuery += CRLF + "  AND     Z83_ID          = '"+ ::cIdCID     +"'  "
    cQuery += CRLF + "  AND     Z83.D_E_L_E_T_  =  ''                   "

    TcQuery cQuery New Alias (::cAliasQry) 
    
return ::cAliasQry



