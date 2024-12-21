#include 'protheus.ch'
#include 'topconn.ch'
#include 'fwmvcdef.ch'

/**
 * Tela de cadastro dos perfis para cadastrar o perfil do orçamento  
 *
 * @author Fabio Hayama
 * @since 23/02/2016
 */

#define Z34CAMPOS "Z34_ID|Z34_DESCRI|Z34_ORIGEM|"

user function TlFilPerfil()
	local oBrowse
	
	private cOpcPerfil 	:= "E"
	private _xRetF3Dina
	
	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias( 'Z34' )
	oBrowse:SetDescription('Filtros do perfil do orçamento')
			
	oBrowse:Activate()
return nil

static function MenuDef() 
	local aRotina := {} 
	 
	AAdd( aRotina, { 'Visualizar'			, 'VIEWDEF.TlFilPerfil'				, 0, 2, 0, NIL } )	 	
	AAdd( aRotina, { 'Incluir'				, 'u_AbEscPerf(3)'					, 0, 3, 0, NIL } ) 
	AAdd( aRotina, { 'Alterar'				, 'u_AbEscPerf(4)'					, 0, 4, 0, NIL } ) 
	AAdd( aRotina, { 'Excluir'				, 'VIEWDEF.TlFilPerfil'				, 0, 5, 0, NIL } ) 
	AAdd( aRotina, { 'Imprimir'				, 'VIEWDEF.TlFilPerfil'				, 0, 8, 0, NIL } ) 
	AAdd( aRotina, { 'Copiar'				, 'VIEWDEF.TlFilPerfil'				, 0, 9, 0, NIL } ) 
 
return aRotina 

static function ModelDef()
	local oStruCab 	:= FWFormStruct( 1, 'Z34' , {|cCampo|  AllTrim( cCampo ) + '|' $ Z34CAMPOS })
	local oStruDet	:= FWFormStruct( 1, 'Z34' , {|cCampo| !AllTrim( cCampo ) + '|' $ Z34CAMPOS })
	local oModel	:= nil

	oModel := MPFormModel():New( 'Z34MODEL' )
	
	oModel:AddFields( 	'Z34MASTER',					, oStruCab )	
	oModel:AddGrid	( 	'Z34DETAIL', 'Z34MASTER'		, oStruDet )
	
	oModel:SetRelation(	'Z34DETAIL',{	{'Z34_FILIAL' , 'xFilial( "Z34" )'},;											
										{'Z34_ID'		, 'Z34_ID'},;
										{'Z34_DESCRI'	, 'Z34_DESCRI'},;
										{'Z34_ORIGEM'	, 'Z34_ORIGEM'}}, Z34->(IndexKey( 1 )))
																			
	oModel:SetDescription('Filtros para perfil do orçamento')		
	oModel:setPrimaryKey({})
return oModel

static function ViewDef()
	local oModel		:= FWLoadModel( 'TlFilPerfil' )
	local oStruCab	:= FWFormStruct( 2, 'Z34' , {| cCampo |  AllTrim( cCampo ) + '|' $ Z34CAMPOS })
	local oStruDet	:= FWFormStruct( 2, 'Z34' , {| cCampo | !AllTrim( cCampo ) + '|' $ Z34CAMPOS })
	local oView		:= nil
	
	oView := FWFormView():New()
	
	oView:SetModel( oModel )
	 
	if(Alltrim(Upper(cOpcPerfil)) == "E")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"01=Cep","02=Municipio","03=Estado","16=Grp Trib Cli"})
	elseif(Alltrim(Upper(cOpcPerfil)) == "V")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"13=Cep","14=Municipio","15=Estado"})
	elseif(Alltrim(Upper(cOpcPerfil)) == "O")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"05=Linhas","06=Valor","17=E-Massa"})
	elseif(Alltrim(Upper(cOpcPerfil)) == "P")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"08=Produto","09=Grp Produto","12=Estoque x Média"})
	elseif(Alltrim(Upper(cOpcPerfil)) == "C")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"07=Segmento","10=Classificação","11=Última compra (meses)"})
	elseif(Alltrim(Upper(cOpcPerfil)) == "T")
		oStruDet:SetProperty('Z34_TIPO', MVC_VIEW_COMBOBOX,{"01=Cep Cli","02=Municipio Cli","03=Estado Cli","16=Grp Trib Cli",;
															"05=Linhas Orc","06=Valor Orc",;
															"07=Segmento Cli","08=Produto","09=Grp Produto",;
															"10=Classificação Cli","11=Última compra (meses)","12=Estoque x Média",;																	
															"13=Cep Vend","14=Municipio Vend","15=Estado Vend","16=Grp Trib Cli",;
															"17=E-Massa","18=Ult orçamento a mais (meses)","19=Ult visita a mais (dias)",;
															"20=Está no limbo","21=Última compra(data)","22=Cliente com E-massa",;
															"23=Ult. Compra(produto)","24=Ult. Compra data(Grupo Prod.)"})																	
	endIf

	oView:AddField	('VIEW_CAB', oStruCab, 'Z34MASTER')
	oView:AddGrid	('VIEW_DET', oStruDet, 'Z34DETAIL')
		
	oView:CreateHorizontalBox( 'CABEC'	, 30 )
	oView:CreateHorizontalBox( 'CAMPOS'	, 70 )
	
	oView:SetOwnerView( 'VIEW_CAB', 'CABEC' 	)
	oView:SetOwnerView( 'VIEW_DET', 'CAMPOS' 	)
return oView
