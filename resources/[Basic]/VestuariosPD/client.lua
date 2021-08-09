--1275

local _skins = {

	[285] = true,

	[286] = true,

	[287] = true,

	[71] = true,

	[205] = true,

	[280] = true,

	[284] = true,

	[281] = true,

	[282] = true,
	
	[214] = true,
	
	[298] = true

}



local pickup = createPickup(268.416015625, 117.1552734375, 1004.6171875, 3, 1275, 1)

setElementInterior( pickup, 10)


window = guiCreateWindow(0.36, 0.19, 0.27, 0.65, "Vestuario - Policía", true)

guiWindowSetSizable(window, false)

guiSetVisible(window,false)



cerrar = guiCreateLabel( 0.80, 0.005, 0.20, 0.04, 'Cerrar', true, window )

guiSetFont(cerrar, "default-bold-small")

guiSetProperty(cerrar, "ClippedByParent", "False")

guiSetProperty(cerrar, "AlwaysOnTop", "True")

guiSetProperty(cerrar, "RiseOnClick", "False")

GuardarAspecto = guiCreateButton(0.50, 0.12, 0.47, 0.08, "Guardar aspecto", true, window)

TomarAspectoGuardado = guiCreateButton(0.50, 0.21, 0.47, 0.08, "Tomar aspecto guardado", true, window)

Listaparaskins = guiCreateGridList(0.04, 0.31, 0.46, 0.65, true, window)

guiGridListAddColumn(Listaparaskins, "Skins", 0.84)

TomarSkin = guiCreateButton(0.55, 0.69, 0.38, 0.15, "Tomar Skin", true, window)





addCommandHandler("vestuarios",
	function ()
		if localPlayer:getData("Roleplay:faccion") == "Policia" then
			if isPedWithinRange(268.416015625, 117.1552734375, 1004.6171875,0.1,localPlayer) then
				guiSetVisible(window,true)
				showCursor(true)
				guiGridListClear( Listaparaskins )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Cadete' ), 1, '71' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mujer Policial' ), 1, '214' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mujer Policial II' ), 1, '298' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Sargeto' ), 1, '280' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Motero' ), 1, '284' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial l' ), 1, '281' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Teniente' ), 1, '282' )	
			end
		end
	end
)



addEventHandler( "onClientRender", getRootElement(),function()
	local x,y = getScreenFromWorldPosition(268.416015625, 117.1552734375, 1004.6171875, 0, true )
	local dist = getDistanceBetweenPoints3D(268.416015625, 117.1552734375, 1004.6171875, getElementPosition(localPlayer) )
	if x and dist <= 10 then
		x = x - (dxGetTextWidth( '/vestuarios', 2-(dist/30)*2, "default-bold" )/2)
		dxDrawText('/vestuarios', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/vestuarios', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/vestuarios', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
	end
end)







addEventHandler( "onClientGUIClick", getRootElement(),function()
	if source == cerrar then

		guiSetVisible(window,false)

		showCursor(false)

	elseif source == TomarSkin then

		local id = tonumber(guiGridListGetItemData( Listaparaskins, guiGridListGetSelectedItem( Listaparaskins ), 1 )) or false

		if id then

			triggerServerEvent('VestuarioPoli',localPlayer, 'Colocar', id)

		end

	elseif source == GuardarAspecto then

		if _skins[localPlayer:getModel()] then

		else

			mySkin = localPlayer:getModel()

			triggerServerEvent('VestuarioPoli',localPlayer, 'Guardar', localPlayer:getModel())

		end

	elseif source == TomarAspectoGuardado then

		if mySkin then

			triggerServerEvent('VestuarioPoli',localPlayer, 'Tomar', mySkin)

		end

	end

end)







addEvent('refresh:MySkin', true)

addEventHandler('refresh:MySkin',localPlayer,

	function(id)

		mySkin = id

	end

)



function isPedWithinRange(x,y,z,range,ped)

	for _, type in ipairs({'player','ped'}) do

		for k,v in pairs(getElementsWithinRange(x,y,z,range, type)) do

			if v == ped then

				return true

			end

		end

	end

	return false;

end



