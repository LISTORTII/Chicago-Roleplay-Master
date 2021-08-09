local blip = {}

addEvent("Police:create_blip", true)
function create_blip(p)
	local pos = Vector3(p:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	blip[p] = Blip.createAttachedTo(p, 0, 3, 20, 80, 100, 500)
end
addEventHandler("Police:create_blip", root, create_blip)

addEvent("Police:destroy_blip", true)
function destroy_blip(p)
	if isElement(blip[p]) then
		destroyElement(blip[p])
	end
end
addEventHandler("Police:destroy_blip", root, destroy_blip)


addEventHandler("onClientResourceStart", resourceRoot, function()
	EngineTXD("files/taser.txd"):import(347)
	EngineDFF("files/taser.dff"):replace(347)
end)

--
function fireTaserSound(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
	if (weapon == 23) then
		Sound3D("files/Fire.wav", startX, startY, startZ)
		local s = Sound3D("files/Fire.wav", hitX, hitY, hitZ)
		s:setMaxDistance(50)
		for i=1, 5, 1 do
			Effect.addPunchImpact(hitX, hitY, hitZ, 0, 0, 0)
			Effect.addSparks(hitX, hitY, hitZ, 0, 0, 0, 8, 1, 0, 0, 0, true, 3, 1)
		end
		Effect.addPunchImpact(startX, startY, startZ, 0, 0, -3)
		if (source == localPlayer) then
			toggleControl("fire", false)
			setTimer(function()
				toggleControl("fire", true)
			end, 350, 1)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), fireTaserSound)
--
function AnimacionTaser(attacker, weapon, bodypart, loss)
	if (weapon == 23) then
		triggerServerEvent("setAnimAndCable", attacker, source)
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), AnimacionTaser)

addEventHandler ("onClientPlayerDamage", root, 
function (attacker, weapon)
	if source == localPlayer then
		if localPlayer:getData("NoDamageKill") == true then
			cancelEvent()
		end
	end
end
)

pickups_infos = {
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara salir", 1414.2526855469, -11.995247840881, 1000.9251708984-1, int = 6, dim = 4, r = 255, g = 255, b = 255, font = "default-bold"  },--CMED SALIDA
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara entrar", 1176.970703125, -1308.7109375, 13.911705970764-1, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CMED ENTRADA
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara entrar", 1825.2353515625, -1538.1396484375, 13.546875-1, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CPD PRISION Entrada
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara salir", 1821.4619140625, -1537.7236328125, 13.479822158813-1, int = 6, dim = 4, r = 255, g = 255, b = 255, font = "default-bold"  },--CPD PRISION SALIDA
	{ info = "Usa #FF8300/vender + tipo de objeto #FFFFFF+ cantidad", 2948.212890625, -1524.9697265625, 1.5488405227661-1, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
	--PD
--	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara entrar", 5.7446880340576, -1086.0267333984, 27.966259002686-1, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
--	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara salir",  478.8291015625, 103.01953887939, 1021.7077636719-1, int = 4, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },

	{ info = "/emergencia\n#004500$100 dólares",1176.3369140625, -1339.4853515625, 13.980255126953, int = 0, dim = 0, r = 150, g = 50, b = 50, font = "default-bold"}
}

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 10 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

--win veh pub

winpubveh = guiCreateWindow(0.01, 0.33, 0.25, 0.52, "Vehiculos - LCPD", true)
guiWindowSetSizable(winpubveh, false)

vehlist = guiCreateGridList(0.03, 0.06, 0.94, 0.78, true, winpubveh)
guiGridListAddColumn(vehlist, "ID", 0.2)
guiGridListAddColumn(vehlist, "Vehiculo", 0.3)
guiGridListAddColumn(vehlist, "Int", 0.2)
guiGridListAddColumn(vehlist, "Key", 0.1)
respawnear = guiCreateButton(0.24, 0.86, 0.53, 0.09, "Respawnear", true, winpubveh)
guiSetFont(respawnear, "default-bold-small")
guiSetProperty(respawnear, "NormalTextColour", "FFFFFEFE")
cerrar = guiCreateButton(0.86, 0.86, 0.11, 0.09, "x", true, winpubveh)
guiSetFont(cerrar, "default-bold-small")
guiSetProperty(cerrar, "NormalTextColour", "FFF10000")
guiSetVisible(winpubveh,false)



addEventHandler("onClientGUIClick",getRootElement(),function()
		local id = guiGridListGetItemText( vehlist, guiGridListGetSelectedItem ( vehlist ), 1 )
    	local itenName = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 2 )
    	local int = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 3 )
    	local key = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 4 )
	if source == cerrar then
		guiSetVisible(winpubveh,false)
		showCursor(false)
	elseif source == respawnear then
		if itenName ~= "" then
			outputChatBox("Has Respawneado el Vehiculo "..itenName,50,255,50,true)
			--guiSetVisible(winpubveh,false)
			--showCursor(false)
			triggerServerEvent("spawnpd",localPlayer,id,key)
		else
			outputChatBox("[ERROR] Selecciona un Vehiculo primero",255,50,50,true)
		end
	end
end)



function vehpub(id)
	if id == 598 or id == 599 or id == 523 or id == 468 or id == 490 or id == 528 or id == 490 then
		return "Policia"
	end
end

local listaveh = {
	{598,"Police LV",4,5105},
	{597,"Police LS",4,8462},
	{599,"Police Ranger",4,9462},
	{523,"HPV1000",4,6486},
	{468,"Sanchez",4,8943},
	{528,"FBI Truck",4,9766},
	{426,"Premier",4,6842},
	{427,"Enforcer",4,8432},
	{601,"S.W.A.T",4,9432},
	{525,"Towtruck",4,1510},
	{490,"Inteligencia",4,2062}
}

local pickup = Pickup(1603.498046875, -1711.24609375, 5.890625,3,1239)

function verwin()
	if getElementData(localPlayer,"Roleplay:faccion") == "Policia" then
		if isElementWithinPickup(localPlayer,pickup) then
			guiSetVisible(winpubveh,true)
			showCursor(true)
			guiGridListClear( vehlist )
			for i,v in pairs(listaveh) do
				local row = guiGridListAddRow(vehlist)
		   		guiGridListSetItemText(vehlist, row, 1, v[1], false, true)
		    	guiGridListSetItemText(vehlist, row, 2, v[2], false, true)
		    	guiGridListSetItemText(vehlist, row, 3, v[3], false, true)
		    	guiGridListSetItemText(vehlist, row, 4, v[4], false, true)
		 	end
		end
	end
end
addCommandHandler("veh",verwin)

function isElementWithinPickup(theElement, thePickup)
	if (isElement(theElement) and getElementType(thePickup) == "pickup") then
		local x, y, z = getElementPosition(theElement)
		local x2, y2, z2 = getElementPosition(thePickup)
		if (getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) <= 1) then
			return true
		end
	end
	return false
end

addEventHandler( "onClientRender", getRootElement(), 

	function()

		local x,y = getScreenFromWorldPosition(1603.498046875, -1711.24609375, 5.890625, 0, true )

		local dist = getDistanceBetweenPoints3D(1603.498046875, -1711.24609375, 5.890625, getElementPosition(localPlayer) )



		if x and dist <= 10 then

			x = x - (dxGetTextWidth( '/veh', 2-(dist/30)*2, "default-bold" )/2)

			

			dxDrawText('/veh', x-1, y-1, x+1, y+5, tocolor(0,0,0,255), 1.8-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/veh', x+1, y+1, x-1, y-5, tocolor(0,0,0,255), 1.8-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/veh', x, y, x, y+3, tocolor(2,172,240,255), 1.8-(dist/10), "default-bold","left","top",false,false,false,false,false)

		end

		local x2,y2 = getScreenFromWorldPosition(1601.171875, -1704.0966796875, 5.890625, 0, true )

		local dist2 = getDistanceBetweenPoints3D(1601.171875, -1704.0966796875, 5.890625, getElementPosition(localPlayer) )



		if x2 and dist2 <= 10 then

			x2 = x2 - (dxGetTextWidth( '/borrarveh', 2-(dist/30)*2, "default-bold" )/2)

			

			dxDrawText('/borrarveh', x2-1, y2-1, x2+1, y2+5, tocolor(0,0,0,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/borrarveh', x2+1, y2+1, x2-1, y2-5, tocolor(0,0,0,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/borrarveh', x2, y2, x2, y2+3, tocolor(2,172,240,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)

		end

	end

)
