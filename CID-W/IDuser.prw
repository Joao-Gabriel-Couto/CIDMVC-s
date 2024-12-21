#include "Protheus.ch"
#include 'topconn.ch'
#include 'fwmvcdef.ch'
#include "tbiconn.ch"

user function IDuser( cPapel, cUsrPapel )   
    local lRet := .F.
    
    default cPapel      := ""
    default cUsrPapel   := __cUserID

    DbSelectArea("Z84")
    DbSetOrder(2)    
    If Z84->( DbSeek(xFilial("Z84") +   PadR( cPapel    , GetSx3Cache("Z84_TIPO"  ,'X3_TAMANHO') ) +;
                                        PadR( cUsrPapel , GetSx3Cache("Z84_CODUSR",'X3_TAMANHO') ) ) )
        lRet := .T.
    endif  
         
return lRet


