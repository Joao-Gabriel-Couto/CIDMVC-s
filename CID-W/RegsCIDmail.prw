#include 'totvs.ch'
#include "Protheus.ch"
#include 'topconn.ch'
#include "tbiconn.ch"
user function RegsCIDmail()
    RPCSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
          
	    u_uRegsCIDmail()

	RESET ENVIRONMENT
return 

user function uRegsCIDmail()
  
  local oRegsCID 
        oRegsCID := RegsCID():new()
        oRegsCID:get_infCID()
return 

class RegsCID

    data cIdCID

    method new() constructor
    method get_infCID()
    method get_IdCID()

endClass
method new() class RegsCID
    ::cIdCID    := "000002"
return
method get_IdCID() class RegsCID

return 
method get_infCID() class RegsCID

    local cAliasQry := GetNextAlias()
    local cQuery    := ""
   
    
    DbSelectArea("Z83")

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

    TcQuery cQuery New Alias cAliasQry
    
    
return cAliasQry

   