#include "Protheus.ch"
#include 'topconn.ch'
#include 'fwmvcdef.ch'
#include "tbiconn.ch"


/*/{Protheus.doc} Tela MVC
Tela para cadastro do fluxo do processo 
CID.
@author João Couto
@since 24/07/2024
/*/

#define Z83CAMPOS "Z83_FILIAL|Z83_ID|Z83_EMISS|Z83_FNC|Z83_DTFNC|Z83_NNOTAD|Z83_CODLC|Z83_NOMCLI|Z83_TIPCLI|Z83_DTNOTA|Z83_VLRNOT|Z83_VLRDEV|Z83_RESPIN|Z83_MTVDEV|Z83_STATUS|Z83_MTVCAN|Z83_RESPEN|"
User Function CIDMVCFLX()

Local oBrowse := NIL

oBrowse := FWMBrowse():New()

oBrowse:SetAlias('Z83')

oBrowse:SetDescription("Cadastro Ficha CID")



oBrowse:Activate()

Return NIL


Static Function MenuDef()

Local aRotina := {}
aAdd( aRotina, { 'Visualizar' , 'VIEWDEF.CIDMVCFLX'  , 0, 2, 0, NIL } )
aAdd( aRotina, { 'Incluir'    , 'VIEWDEF.CIDMVCFLX'  , 0, 3, 0, NIL } )
aAdd( aRotina, { 'Alterar'    , 'VIEWDEF.CIDMVCFLX'  , 0, 4, 0, NIL } )
aAdd( aRotina, { 'Excluir'    , 'VIEWDEF.CIDMVCFLX'  , 0, 5, 0, NIL } )
aAdd( aRotina, { 'Imprimir'   , 'VIEWDEF.CIDMVCFLX'  , 0, 8, 0, NIL } )
aAdd( aRotina, { 'Copiar'     , 'VIEWDEF.CIDMVCFLX'  , 0, 9, 0, NIL } )

Return (aRotina)

Static Function ModelDef()
Local oModel 
local oStr1 	:= FWFormStruct( 1, 'Z83' , {|cCampo|  AllTrim( cCampo ) + '|' $ Z83CAMPOS })
local oStr2	    := FWFormStruct( 1, 'Z83' , {|cCampo| !AllTrim( cCampo ) + '|' $ Z83CAMPOS })


oModel := MPFormModel():New('ModelName')

oModel:AddFields('MODEL_Z83',, oStr1)
oModel:AddFields('MODEL_Z8302','MODEL_Z83', oStr2)

oModel:SetPrimaryKey({'Z83_FILIAL','Z83_ID'})

oModel:GetModel( 'MODEL_Z83'   ):SetDescription( 'Abertura ficha CID' )
oModel:GetModel( 'MODEL_Z8302' ):SetDescription( 'Cadastro Fluxo do Processo' )
Return oModel

Static Function ViewDef()

Local oView
Local oModel := FwLoadModel('CIDMVCFLX')
local oStr1 	:= FWFormStruct( 2, 'Z83' , {|cCampo|  AllTrim( cCampo ) + '|' $ Z83CAMPOS })
local oStr2	    := FWFormStruct( 2, 'Z83' , {|cCampo| !AllTrim( cCampo ) + '|' $ Z83CAMPOS })



oView := FWFormView():New()

oView:SetModel( oModel )
 
oView:AddField( 'VIEW_Z83'  , oStr1, 'MODEL_Z83' )
oView:AddField( 'VIEW_Z8302', oStr2, 'MODEL_Z8302' )


oView:CreateFolder( 'PASTAS' )

oView:AddSheet( 'PASTAS', 'ABA01', 'Abetura Ficha C.I.D' )
oView:AddSheet( 'PASTAS', 'ABA02', 'Fluxo do Processo C.I.D' )

oView:CreateHorizontalBox( 'BOX_SUPERIOR'   , 100 ,,, 'PASTAS', 'ABA01' )
oView:CreateHorizontalBox( 'BOX_SUPERIOR02' , 100 ,,, 'PASTAS', 'ABA02' )


//Criando grupos de papeis/responsáveis
oStr2:AddGroup( 'GRUPO01', 'Comercial  '		, '', 1 )
oStr2:AddGroup( 'GRUPO02', 'Fiscal     '		, '', 2 )
oStr2:AddGroup( 'GRUPO03', 'Financeiro '		, '', 3 )
oStr2:AddGroup( 'GRUPO04', 'Logistica  '		, '', 4 )
oStr2:AddGroup( 'GRUPO05', 'Logistica  '		, '', 5 )
oStr2:AddGroup( 'GRUPO06', 'Fiscal     '		, '', 6 )
oStr2:AddGroup( 'GRUPO07', 'Financeiro '		, '', 7 )
oStr2:AddGroup( 'GRUPO08', 'Qualidade  '		, '', 8 )
oStr2:AddGroup( 'GRUPO09', 'Logistica  '		, '', 9 )


// Colocando alguns campos por agrupamentos'
oStr2:SetProperty( 'Z83_CRIADT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO01' )
oStr2:SetProperty( 'Z83_CRIAHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO01' )
oStr2:SetProperty( 'Z83_CRIAUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO01' )
oStr2:SetProperty( 'Z83_CRIASN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO01' )

oStr2:SetProperty( 'Z83_SIMDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO02' )
oStr2:SetProperty( 'Z83_SIMHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO02' )
oStr2:SetProperty( 'Z83_SIMUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO02' )
oStr2:SetProperty( 'Z83_SIMSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO02' )

oStr2:SetProperty( 'Z83_COBDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO03' )
oStr2:SetProperty( 'Z83_COBHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPOO3' )
oStr2:SetProperty( 'Z83_COBUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO03' )
oStr2:SetProperty( 'Z83_COBSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO03' )

oStr2:SetProperty( 'Z83_AGEDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO04' )
oStr2:SetProperty( 'Z83_AGEHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO04' )
oStr2:SetProperty( 'Z83_AGEUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO04' )
oStr2:SetProperty( 'Z83_AGESN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO04' )

oStr2:SetProperty( 'Z83_RECDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO05' )
oStr2:SetProperty( 'Z83_RECHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO05' )
oStr2:SetProperty( 'Z83_RECUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO05' )
oStr2:SetProperty( 'Z83_RECSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO05' )

oStr2:SetProperty( 'Z83_CONFDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO06' )
oStr2:SetProperty( 'Z83_CONFHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO06' )
oStr2:SetProperty( 'Z83_CONFUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO06' )
oStr2:SetProperty( 'Z83_CONFSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO06' )

oStr2:SetProperty( 'Z83_ABATDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO07' )
oStr2:SetProperty( 'Z83_ABATHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO07' )
oStr2:SetProperty( 'Z83_ABATUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO07' )
oStr2:SetProperty( 'Z83_ABATSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO07' )

oStr2:SetProperty( 'Z83_QUALDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO08' )
oStr2:SetProperty( 'Z83_QUALHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO08' )
oStr2:SetProperty( 'Z83_QUALUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO08' )
oStr2:SetProperty( 'Z83_QUALSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO08' )

oStr2:SetProperty( 'Z83_LOGDT'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO09' )
oStr2:SetProperty( 'Z83_LOGHR'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO09' )
oStr2:SetProperty( 'Z83_LOGUS'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO09' )
oStr2:SetProperty( 'Z83_LOGSN'	, MVC_VIEW_GROUP_NUMBER, 'GRUPO09' )


oView:SetOwnerView( 'VIEW_Z83', 'BOX_SUPERIOR'   )
oView:SetOwnerView( 'VIEW_Z8302', 'BOX_SUPERIOR02' )
oView:SetCloseonOk({||.T.})

Return oView


