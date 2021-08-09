
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        ceuntabancaria = guiCreateWindow(0.31, 0.22, 0.41, 0.53, "Cuenta Bancaria", true)
        guiWindowSetMovable(ceuntabancaria, false)
        guiWindowSetSizable(ceuntabancaria, false)

        
        master = guiCreateStaticImage(0.20, 0.06, 0.14, 0.08, "gui_empezar/master.png", true, ceuntabancaria)
        visa = guiCreateStaticImage(0.03, 0.06, 0.14, 0.09, "gui_empezar/visa.png", true, ceuntabancaria)
        masterwhi = guiCreateStaticImage(0.41, 0.06, 0.56, 0.40, "gui_empezar/msaterbl.png", true, ceuntabancaria)
        masterblack = guiCreateStaticImage(0.41, 0.59, 0.56, 0.36, "gui_empezar/masterne.png", true, ceuntabancaria)
        black = guiCreateRadioButton(0.41, 0.49, 0.21, 0.07, "Black", true, ceuntabancaria)
        guiSetFont(black, "default-bold-small")
        white = guiCreateRadioButton(0.71, 0.49, 0.21, 0.07, "White", true, ceuntabancaria)
        guiSetFont(white, "default-bold-small")
        guiRadioButtonSetSelected(white, true)
        bancol = guiCreateLabel(0.03, 0.19, 0.33, 0.09, "Banco LS", true, ceuntabancaria)
        local font0_EmblemaOne = guiCreateFont("gui_empezar/EmblemaOne.ttf", 20)
        guiSetFont(bancol, font0_EmblemaOne)
        guiLabelSetHorizontalAlign(bancol, "center", false)
        guiLabelSetVerticalAlign(bancol, "center")
        registrar = guiCreateButton(0.05, 0.90, 0.22, 0.07, "Registrar", true, ceuntabancaria)
        guiSetFont(registrar, "default-bold-small")
        guiSetProperty(registrar, "NormalTextColour", "FEFFFFFF")
        firma1 = guiCreateLabel(0.07, 0.30, 0.26, 0.05, "Firma", true, ceuntabancaria)
        local font1_PetitFormalScript = guiCreateFont("gui_empezar/PetitFormalScript.ttf", 18)
        guiSetFont(firma1, font1_PetitFormalScript)
        guiLabelSetHorizontalAlign(firma1, "center", false)
        guiLabelSetVerticalAlign(firma1, "center")
        firma = guiCreateEdit(0.03, 0.38, 0.31, 0.06, "", true, ceuntabancaria)
        cuenta = guiCreateEdit(0.03, 0.65, 0.31, 0.06, "", true, ceuntabancaria)
        cuenta1 = guiCreateLabel(0.05, 0.58, 0.28, 0.04, "Tipo de Cuenta", true, ceuntabancaria)
        guiSetFont(cuenta1, "default-bold-small")
        guiLabelSetHorizontalAlign(cuenta1, "center", false)
        guiLabelSetVerticalAlign(cuenta1, "center")
        ayuda = guiCreateButton(0.35, 0.65, 0.05, 0.07, "?", true, ceuntabancaria)
        guiSetFont(ayuda, "default-bold-small")
        guiSetProperty(ayuda, "NormalTextColour", "FEFFFFFF")
        x = guiCreateButton(0.31, 0.91, 0.06, 0.07, "X", true, ceuntabancaria)
        guiSetFont(x, "default-bold-small")
        guiSetProperty(x, "NormalTextColour", "FEFFFFFF")  
		guiSetVisible(ceuntabancaria, false)
    end
)
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        cuentaswin = guiCreateWindow(0.02, 0.31, 0.20, 0.20, "TIPO DE CUENTAS", true)
        guiWindowSetSizable(cuentaswin, false)

        cuentas = guiCreateGridList(0.03, 0.14, 0.81, 0.80, true, cuentaswin)
        guiGridListAddColumn(cuentas, "Cuentas", 0.9)
        cerrar2 = guiCreateButton(0.86, 0.71, 0.10, 0.16, "X", true, cuentaswin)
        guiSetFont(cerrar2, "default-bold-small")
        guiSetProperty(cerrar2, "NormalTextColour", "FEFFFFFF") 
			guiSetVisible(cuentaswin, false)
    end
)
local cuentaslis = {

{"Debito"},
{"Credito"},
{"Corriente"},
{"Ahorros"},

}
addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == x then
        guiSetVisible(ceuntabancaria, false)
		guiSetVisible(cuentaswin, false)
	showCursor(false)
	elseif source == registrar then
	local sigue = guiGetText(firma)
	local cuen = guiGetText(cuenta)
	if sigue ~="" then
		if cuen == "Ahorros" or cuen == "Credito" or cuen == "Debito" or cuen == "Corriente" then
		guiSetVisible(ceuntabancaria, false)
		guiSetVisible(cuentaswin, false)
		showCursor(false)
		outputChatBox("Acabas de ser Fotografiado y tomaron tus huellas para tu tarjeta de crédito.", 25, 80, 150, true)
		setElementData(source,"firma",sigue)
		else
		outputChatBox("Has puesto una cuenta invalida", 150, 50, 50)	
		end
	else
	outputChatBox("¡Debes poner algo en la Firma!", 150, 50, 50)
	end
	elseif source == master then
	guiStaticImageLoadImage(masterwhi, "gui_empezar/msaterbl.png")
	guiStaticImageLoadImage(masterblack, "gui_empezar/masterne.png")
	elseif source == visa then
	guiStaticImageLoadImage(masterwhi, "gui_empezar/visawh.png")
	guiStaticImageLoadImage(masterblack, "gui_empezar/visabla.png")	
	elseif source == ayuda then
	if guiGetVisible(cuentaswin) == true then
        guiSetVisible(cuentaswin, false)
        showCursor(false)
    else
		guiGridListClear( cuentas )
        showCursor(true)
        guiSetVisible(cuentaswin, true)
				for i, v in ipairs(cuentaslis) do
       			 local row = guiGridListAddRow( cuentas )
       			guiGridListSetItemText(cuentas, row, 1, v[1], false, true)
				guiGridListSetItemData(cuentas, row, 1, v[1] )
    		end
    end
	elseif source == cerrar2 then
	guiSetVisible(cuentaswin, false)
    end
end)

function abrir()

    if guiGetVisible(ceuntabancaria) == true then

        guiSetVisible(ceuntabancaria, false)

        showCursor(false)

    else

        showCursor(true)

        guiSetVisible(ceuntabancaria, true)

    end

end
addEvent("tarjeta",true)
addEventHandler("tarjeta",root,abrir)

