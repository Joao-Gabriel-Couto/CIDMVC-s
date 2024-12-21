#include 'protheus.ch'
#include 'topconn.ch'
#include 'fwmvcdef.ch'

/**
 * Tela de cadastro dos perfis para cadastrar o perfil do orçamento  
 *
 * @author Fabio Hayama
 * @since 23/02/2016
 */

#define Z84CAMPOS "Z84_ID|Z84_TIPO|Z84_DESC|"

user function CadPapeis()
	
    local oBrowse
	
	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias( 'Z84' )
	oBrowse:SetDescription('Cadastro de Papeis x Analista')
			
	oBrowse:Activate()
return nil

static function MenuDef() 
	local aRotina := {} 
	 
	AAdd( aRotina, { 'Visualizar'			, 'VIEWDEF.CadPapeis'				, 0, 2, 0, NIL } )	 	
	AAdd( aRotina, { 'Incluir'				, 'VIEWDEF.CadPapeis'				, 0, 3, 0, NIL } ) 
	AAdd( aRotina, { 'Alterar'				, 'VIEWDEF.CadPapeis'			    , 0, 4, 0, NIL } ) 
	AAdd( aRotina, { 'Excluir'				, 'VIEWDEF.CadPapeis'				, 0, 5, 0, NIL } ) 
	AAdd( aRotina, { 'Imprimir'				, 'VIEWDEF.CadPapeis'				, 0, 8, 0, NIL } ) 
	AAdd( aRotina, { 'Copiar'				, 'VIEWDEF.CadPapeis'				, 0, 9, 0, NIL } ) 
 
return aRotina 

static function ModelDef()
	local oStruCab 	:= FWFormStruct( 1, 'Z84' , {|cCampo|  AllTrim( cCampo ) + '|' $ Z84CAMPOS })
	local oStruDet	:= FWFormStruct( 1, 'Z84' , {|cCampo| !AllTrim( cCampo ) + '|' $ Z84CAMPOS })
	local oModel	:= nil

	oModel := MPFormModel():New( 'Z84MODEL' )
	
	oModel:AddFields( 	'Z84MASTER',					, oStruCab )	
	oModel:AddGrid( 	'Z84DETAIL', 'Z84MASTER'		, oStruDet )

	oModel:SetRelation(	'Z84DETAIL',{	{'Z84_FILIAL' , 'xFilial( "Z84" )'},;
                                        {'Z84_CODUSR' , 'Z84_ID'      }}, Z84->(IndexKey( 1 )))
								
	oModel:SetDescription('Cadastro de Papeis x Analista')		
	oModel:setPrimaryKey({})
return oModel

static function ViewDef()
	local oModel		:= FWLoadModel( 'CadPapeis' )
	local oStruCab	:= FWFormStruct( 2, 'Z84' , {| cCampo |  AllTrim( cCampo ) + '|' $ Z84CAMPOS })
	local oStruDet	:= FWFormStruct( 2, 'Z84' , {| cCampo | !AllTrim( cCampo ) + '|' $ Z84CAMPOS })
	local oView		:= nil
	
	oView := FWFormView():New()
	
	oView:SetModel( oModel )
	 
	
    oStruCab:SetProperty('Z84_TIPO', MVC_VIEW_COMBOBOX,{"01=Comercial","02=Financeiro","03=Logistica","04=Fiscal","05=Qualidade"})
	

	oView:AddField	('VIEW_CAB', oStruCab, 'Z84MASTER')
	oView:AddGrid	('VIEW_DET', oStruDet, 'Z84DETAIL')
		
	oView:CreateHorizontalBox( 'CABEC'	, 30 )
	oView:CreateHorizontalBox( 'CAMPOS'	, 70 )
	
	oView:SetOwnerView( 'VIEW_CAB', 'CABEC' 	)
	oView:SetOwnerView( 'VIEW_DET', 'CAMPOS' 	)
return oView



