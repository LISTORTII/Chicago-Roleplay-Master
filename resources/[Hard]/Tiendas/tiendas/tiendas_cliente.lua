
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelComidas = guiCreateWindow(0.75, 0.31, 0.24, 0.45, "Tienda", true)
        guiWindowSetSizable(PanelComidas, false)

        ListaComidas = guiCreateGridList(0.03, 0.07, 0.94, 0.78, true, PanelComidas)
        guiGridListAddColumn(ListaComidas, "Objeto", 0.5)
        guiGridListAddColumn(ListaComidas, "Precio", 0.3)
        botonComprarComida = guiCreateButton(0.33, 0.89, 0.33, 0.08, "COMPRAR", true, PanelComidas)
        guiSetFont(botonComprarComida, "default-bold-small")
        guiSetProperty(botonComprarComida, "NormalTextColour", "FFFFFEFE")
        cerrar2 = guiCreateButton(0.87, 0.89, 0.07, 0.08, "X", true, PanelComidas)
        guiSetFont(cerrar2, "default-bold-small")
        guiSetProperty(cerrar2, "NormalTextColour", "FFFF2525")    
        guiSetVisible(PanelComidas,false)
        showCursor(false)
  
    end
)


addEventHandler("onClientGUIClick", resourceRoot, function()
	local itemName = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 1 )
	local costo = guiGridListGetItemData( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 2 )
	if source == cerrar2 then
		setVisible(PanelComidas)
	elseif source == botonComprarComida then
		setEnabled(botonComprarComida, 1000)
		if itemName ~="" then
			triggerServerEvent("BuyItem", localPlayer, itemName, costo)
		end
	end
end)

local items = { 
{"Telefono", 100},
{"Camara", 50},
{"Radio", 50},
{"Cuchillo de Caza (Arma)", 200},
{"Bidon Vacio", 250},
{"Lata de Spray", 50},
{"Kit Herramientas", 1000},
{"Pizzeta", 50},
{"Pizza Chica", 20},
{"Pizza Grande", 30},
--
{"Pata de Pollo", 10},
{"Hamb. de Pollo", 20},
{"Pollo Asado", 30},
--
{"Cerveza", 20},
{"Agua", 30},
{"Agua Grande",50},
{"Caja de Cigarros", 50},
{"Encendedor", 25},
{"Chocolate",10},
{"Pastel",20},
--
{"Hamburguesa", 10},
{"Hamburguesa Chica", 20},
{"Hamburguesa Grande", 30},

--
{"Caña de pescar", 100},
{"Cebo", 10},
}

addEvent("Comidas:setWindow", true)
addEventHandler("Comidas:setWindow", root, function( tab )
	setVisible(PanelComidas)
	guiGridListClear( ListaComidas )
	for i, v in ipairs( tab ) do
		local row = guiGridListAddRow(ListaComidas)
		guiGridListSetItemText( ListaComidas, row, 1, v, false, true )
		for index, valor in ipairs( items ) do
			if valor[1] == v then
				guiGridListSetItemText( ListaComidas, row, 2, "  $"..valor[2], false, true )
				guiGridListSetItemData( ListaComidas, row, 2, valor[2] )
			end
		end
	end
end)

function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end

function setVisible( var )
	if guiGetVisible( var ) == true then
		guiSetVisible(var, false)
		showCursor(false)
		guiSetInputEnabled(false)
	else
		guiSetVisible(var, true)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end

