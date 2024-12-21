#include 'protheus.ch'
#include 'tbiconn.ch'
#include 'tbicode.ch'

/*/{Protheus.doc} shWfAcoAprv
Executa workflow e títulos sem vinculo

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
/*/
user function shWfAcoAprv()
	local cAuxEmp := "01"
	local cAuxFil := "07"
		
	if (!Empty(cAuxEmp) .and. !Empty(cAuxFil))	 
		RPCSetType(3)
		PREPARE ENVIRONMENT EMPRESA cAuxEmp FILIAL cAuxFil
			SetModulo("SIGATMK","TMK")
			
			Conout("SCHEDMAT - Iniciando rotinas scheduladas em " + DtoC(date()) + " as " + Time())
			Conout("Iniciando Processo") 
			Conout("Empresa: "+ cAuxEmp +" Filial: "+ cAuxFil)
				
			u_exWfAcoAprv()	
				
			Conout("SCHEDMAT - Finalizando rotinas scheduladas em " + DtoC(Date()) + " as " + Time())
		RESET ENVIRONMENT	 


	endif

return

/*/{Protheus.doc} exWfAcoAprv
Executa workflow e títulos sem vinculo

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
/*/
user function exWfAcoAprv()
	local oWfAcoAprv := WfAcoAprv():new()
	
	oWfAcoAprv:wrkFlow()
return

/*/{Protheus.doc} WfAcoAprv
Workflow e títulos sem vinculo

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
/*/
class WfAcoAprv
	data oDados
	data cCorpo
	data cAssunto
	data cDestino
	data oDdAcoAprv
		
	method new() constructor 	
	method wrkFlow()
	method getDadosMail()
	method getAssunto()
	method getDestino()
	method getCorpo()
	method envMail()	
endClass

/*/{Protheus.doc} new
Metodo construtor

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018 
@version 1.0
/*/
method new() class WfAcoAprv
	::oDados		:= DdAcoAprv():new()	
	::cCorpo		:= ""
	::cAssunto		:= ""
	::cDestino		:= ""
return


/*/{Protheus.doc} new
Metodo construtor
@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
@version 1.0
/*/
method wrkFlow() class WfAcoAprv
	::getDadosMail()
	::getAssunto()
	::getDestino()
	::getCorpo()
	::envMail()
return

/*/{Protheus.doc} getDadosMail
Get dados de pré inspeção

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018 
@version 1.0
/*/
method getDadosMail() class WfAcoAprv	
	::oDados:exec() 
return

/*/{Protheus.doc} envMail
Envia o e-mail de fato
@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
@version 1.0
/*/
method envMail() class WfAcoAprv
	local oEnviaMail	:= EnviaMail():new()
	
	oEnviaMail:enviaEmail(::cCorpo,::cAssunto,::cDestino)
return

/*/{Protheus.doc} getCorpo
Monta o html do e-mail
@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
@version 1.0
/*/
method getCorpo() class WfAcoAprv		
	::cCorpo += '<html xmlns="http://www.w3.org/1999/xhtml"> '
	::cCorpo += '	<head> '
	::cCorpo += '		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> '
	::cCorpo += '		<title>Untitled Document</title> '
	::cCorpo += '	</head> '
	::cCorpo += '	<body> '
	
	//Joao
	::cCorpo += '	<table width="100%" border="1" cellspacing="1" cellpadding="1"> '
	::cCorpo += '		  <tr bgcolor="#C5D9F1"> '
	::cCorpo += '		    <th width="12%" scope="col">ID</th> '
	::cCorpo += '		    <th width="12%" scope="col">Orcam</th> '
	::cCorpo += '		    <th width="12%" scope="col">Emissao</th> '
	::cCorpo += '		    <th width="12%" scope="col">Hra Emiss</th> '	
	::cCorpo += '		    <th width="12%" scope="col">Hra Random</th> '
	::cCorpo += '		    <th width="20%" scope="col">Tipo</th> '
	::cCorpo += '		    <th width="20%" scope="col">Aprovador</th> '
	::cCorpo += '	      </tr> '	
	
	while(!(::oDados:cAliasJoao)->(Eof()))
		::cCorpo += '		  <tr> '					
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->Z73_ID)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->Z73_NUM)			+'</td> '
		::cCorpo += '		    <td>'+ DtoC((::oDados:cAliasJoao)->Z73_EMIS)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->Z73_HREMIS)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->Z73_HRRAND)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->TIPO)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasJoao)->APROV)			+'</td> '		
		::cCorpo += '	      </tr> '	
		
		(::oDados:cAliasJoao)->(DbSkip())
	endDo				 
	::cCorpo += '    </table><br> '
	
	if(Select(::oDados:cAliasJoao) > 0)
		(::oDados:cAliasJoao)->(DbCloseArea())
	endIf
	
	//Eric
	::cCorpo += '	<table width="100%" border="1" cellspacing="1" cellpadding="1"> '
	::cCorpo += '		  <tr bgcolor="#C5D9F1"> '
	::cCorpo += '		    <th width="12%" scope="col">ID</th> '
	::cCorpo += '		    <th width="12%" scope="col">Orcam</th> '
	::cCorpo += '		    <th width="12%" scope="col">Emissao</th> '
	::cCorpo += '		    <th width="12%" scope="col">Hra Emiss</th> '	
	::cCorpo += '		    <th width="12%" scope="col">Hra Random</th> '
	::cCorpo += '		    <th width="20%" scope="col">Tipo</th> '
	::cCorpo += '		    <th width="20%" scope="col">Aprovador</th> '
	::cCorpo += '	      </tr> '	
	
	while(!(::oDados:cAliasEric)->(Eof()))
		::cCorpo += '		  <tr> '					
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->Z73_ID)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->Z73_NUM)			+'</td> '
		::cCorpo += '		    <td>'+ DtoC((::oDados:cAliasEric)->Z73_EMIS)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->Z73_HREMIS)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->Z73_HRRAND)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->TIPO)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasEric)->APROV)			+'</td> '		
		::cCorpo += '	      </tr> '	
		
		(::oDados:cAliasEric)->(DbSkip())
	endDo				 
	::cCorpo += '    </table><br> '
	
	if(Select(::oDados:cAliasEric) > 0)
		(::oDados:cAliasEric)->(DbCloseArea())
	endIf
	
	//Auto
	::cCorpo += '	<table width="100%" border="1" cellspacing="1" cellpadding="1"> '
	::cCorpo += '		  <tr bgcolor="#C5D9F1"> '
	::cCorpo += '		    <th width="12%" scope="col">ID</th> '
	::cCorpo += '		    <th width="12%" scope="col">Orcam</th> '
	::cCorpo += '		    <th width="12%" scope="col">Emissao</th> '
	::cCorpo += '		    <th width="12%" scope="col">Hra Emiss</th> '	
	::cCorpo += '		    <th width="12%" scope="col">Hra Random</th> '
	::cCorpo += '		    <th width="20%" scope="col">Tipo</th> '
	::cCorpo += '		    <th width="20%" scope="col">Aprovador</th> '
	::cCorpo += '	      </tr> '	
	
	while(!(::oDados:cAliasAuto)->(Eof()))
		::cCorpo += '		  <tr> '					
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->Z73_ID)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->Z73_NUM)			+'</td> '
		::cCorpo += '		    <td>'+ DtoC((::oDados:cAliasAuto)->Z73_EMIS)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->Z73_HREMIS)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->Z73_HRRAND)		+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->TIPO)			+'</td> '
		::cCorpo += '		    <td>'+ Alltrim((::oDados:cAliasAuto)->APROV)			+'</td> '		
		::cCorpo += '	      </tr> '	
		
		(::oDados:cAliasAuto)->(DbSkip())
	endDo				 
	
	if(Select(::oDados:cAliasAuto) > 0)
		(::oDados:cAliasAuto)->(DbCloseArea())
	endIf
	
	::cCorpo += '    </table><br> '
	::cCorpo += '	</body> '
	::cCorpo += '</html> '
return

/*/{Protheus.doc} getDestino
Get destino

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
@version 1.0
/*/
method getDestino() class WfAcoAprv
	//::cDestino := SuperGetMv("ZZ_WFACAPR",.T.,"eric@walsywa.com.br;fabio@geekercompany.com")			
	::cDestino := SuperGetMv("ZZ_WFACAPR",.T.,"")			
return

/*/{Protheus.doc} getAssunto
Busca os assuntos

@author Thomas Galvao - Dominicus Solutions Ltda - thomas.galvao@dominicus.com.br
@since 14/05/2018
@version 1.0
/*/
method getAssunto() class WfAcoAprv		
 	::cAssunto := "Resumo das aprovações" 
return
