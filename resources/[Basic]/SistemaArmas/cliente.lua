
GUIEditor = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        windowp = guiCreateWindow(0.31, 0.28, 0.31, 0.49, "Armas-LSPD", true)
        guiWindowSetSizable(windowp, false)

        tomararma = guiCreateButton(0.03, 0.73, 0.51, 0.18, "Tomar Armas", true, windowp)
        guiSetFont(tomararma, "default-bold-small")
        guiSetProperty(tomararma, "NormalTextColour", "FE60EFF8")
        guardar = guiCreateButton(0.57, 0.68, 0.41, 0.12, "Guardar armas", true, windowp)
        guiSetFont(guardar, "default-bold-small")
        guiSetProperty(guardar, "NormalTextColour", "FE60EFF8")
        guardatom = guiCreateButton(0.57, 0.83, 0.41, 0.12, "Tomar armas guardadas", true, windowp)
        guiSetFont(guardatom, "default-bold-small")
        guiSetProperty(guardatom, "NormalTextColour", "FE60EFF8")
        armitas = guiCreateGridList(0.02, 0.07, 0.73, 0.60, true, windowp)
        guiGridListAddColumn(armitas, "ID", 0.4)
        guiGridListAddColumn(armitas, "Arma", 0.5)
        cerrar = guiCreateButton(0.78, 0.07, 0.19, 0.08, "Cerrar", true, windowp)
        guiSetFont(cerrar, "default-bold-small")
	guiSetProperty(cerrar, "NormalTextColour", "FE60EFF8")
        GUIEditor.label[1] = guiCreateLabel(0.78, 0.17, 0.17, 0.04, "By Phoenix", true, windowp)
        guiSetFont(GUIEditor.label[1], "default-bold-small")    
	 guiSetVisible(windowp, false)
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function()
    local id = guiGridListGetItemData( armitas, guiGridListGetSelectedItem ( armitas ), 1 )
    local itenName = guiGridListGetItemText ( armitas, guiGridListGetSelectedItem ( armitas ), 2 )
    if source == cerrar then
        guiSetVisible(windowp, false)
	showCursor(false)
    elseif source == tomararma then
        if itenName ~="" then
           triggerServerEvent("buyarma", localPlayer, id, itenName)
        end
    end
end)

local swat = {
{3,"Porra"},
{24,"Deagle"},
{22,"9mm"},
{29,"MP5"},
{23,"Taser"},
{25,"Escopeta"},
{31,"M4A1"},
{17,"Teargas"},
{41,"Gas Pimienta"},
{0,"Chaleco"},
}

addEvent("Openarm", true)
addEventHandler("Openarm", root, function()
	if guiGetVisible(windowp) == true then
		guiSetVisible(windowp, false)
		showCursor(false)
	else
		guiGridListClear( armitas )
		guiSetVisible(windowp, true)
		showCursor(true)
		for i, v in ipairs(swat) do
			local row = guiGridListAddRow(armitas)
       			guiGridListSetItemText(armitas, row, 1, v[1], false, true)
        		guiGridListSetItemText(armitas, row, 2, v[2], false, true)
        --
        		guiGridListSetItemData(armitas, row, 1, v[1] )
       	 		guiGridListSetItemData(armitas, row, 2, v[3] )
		end
	end
end)



addEventHandler( "onClientRender", getRootElement(), 

	function()

		local x,y = getScreenFromWorldPosition(268.4697265625, 119.4306640625, 1004.6171875, 0, true )

		local dist = getDistanceBetweenPoints3D(268.4697265625, 119.4306640625, 1004.6171875, getElementPosition(localPlayer) )



		if x and dist <= 10 then

			x = x - (dxGetTextWidth( '/armas', 2-(dist/30)*2, "default-bold" )/2)

			

			dxDrawText('/armas', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/armas', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/armas', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

		end

	end

)

