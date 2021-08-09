--[[local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768

rentas = {
	info = {
	{462,1759.4755859375, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+3, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+6, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+9, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+12, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+15, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{462,1759.4755859375+18, -1862.0546875, 13.576762199402-0.5, 0, 0, 0.55206298828125,10},
	{445,1759.4755859375+22, -1862.0546875, 13.576762199402-0.2, 0, 0, 0.55206298828125,20},
	{445,1759.4755859375+26, -1862.0546875, 13.576762199402-0.2, 0, 0, 0.55206298828125,20},

	},

	creados = {},
	tiempos = {}
}


addEventHandler("onClientResourceStart",getResourceRootElement(),function()

	for i,v in ipairs(rentas.info) do
		
		local id,x,y,z,rx,ry,rz,precio = unpack(v)
		rentas.creados[i] = Vehicle(id,x,y,z,rx,ry,rz)
		rentas.creados[i]:setData("Fuel", 100)
		rentas.creados[i]:setData("rentado",false)
		rentas.creados[i]:setData("rentable",true)
		rentas.creados[i]:setData('Rentable:Precio',v[8])
		rentas.creados[i]:setDamageProof( true )
		rentas.creados[i].frozen = true
		rentas.creados[i]:setLocked( true ) 
	end
	triggerServerEvent("setrespawn",localPlayer,v,rentas.creados[i])
end)




addEventHandler("onClientRender", getRootElement(), function()

	if Rentados then

		for _, rentado in ipairs(Rentados) do

			if not rentado:getData('rentado') then

				local pos = rentado.position
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D( pos, cx,cy,cz )
				local maxDist = 15
				local precio = rentado:getData('Rentable:Precio')
				local x,y = getScreenFromWorldPosition(pos, 0, false)
				local up = (getElementRadius( rentado ) or 1) * 30

				if dist <= maxDist then

					if x and y then

						dxDrawBourdeText(1, '#00FFF6Vehiculo Rentable\n#FF4800Precio: $'..precio..'x Min\n#ffffff/rentar [TIEMPO]', x, y-up, x, y, tocolor(255,255,255), tocolor(0,0,0), 1.5-(dist/maxDist), 'default-bold', 'center','center', false, false, false,true)

					end

				end

			elseif rentado:getData('rentado') == localPlayer then

				local segundos = rentado:getData('Vehiculo:Rentable:Duracion')				
				local minutos = math.abs(math.floor(segundos/60))
				local tiempo = minutos..' Min ' ..(segundos-(60*minutos))..' Seg'
				dxDrawBourdeText(1, 'Vehiculo Rentado\nDuracion '..tiempo,  96*sx, 490*sy, 251*sx, 532*sy, tocolor(255,255,255), tocolor(0,0,0), 1, 'default-bold', 'center','center', false, false, false,true)

			end

		end

	end

end)


function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2

	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

addEvent('onClienVehicleRentaText', true)
addEventHandler('onClienVehicleRentaText', root,
	function(array)

		

	end
)
]]

addEvent('SonidoEncenderVeh',true)

addEventHandler('SonidoEncenderVeh', localPlayer,

	function(type)

		local sound = playSound3D( 'http://mp3.pilo.ovh/5417baebc4f8f.mp3', source.position )

		sound:setVolume(1)

		setTimer(destroyElement, 3000, 1, sound)

	end

)


toggleControl('horn', true )



local Sirena = {}



addEvent('SirenaConfig',true)

addEventHandler('SirenaConfig', root,

	function(owner)

		if not Sirena[owner] then

			Sirena[owner] = playSound3D( 'http://mp3.pilo.ovh/0715803ae71fa.mp3', owner.position,true )

			Sirena[owner]:attach(owner)

			setSoundMaxDistance(Sirena[owner], 42 )

			setSoundVolume(Sirena[owner], 0)

		else

			Sirena[owner]:destroy()

			Sirena[owner] = nil

		end
		
	end

)

--[[
function doFlashes()
	if not (isElement(veh)) then
		vehicleFlashers[veh] = nil
	else
		local flasherState = getElementData(veh, "vehicle.flashers")
		if getEmergencyVehicle(getElementModel(veh)) then
			if flasherState and flasherState == 0 then
				vehicleFlashers[veh] = nil
				setVehicleHeadLightColor(veh, 255, 255, 255)
				setVehicleLightState(veh, 0, 0)
				setVehicleLightState(veh, 1, 0)
				setVehicleLightState(veh, 2, 0)
				setVehicleLightState(veh, 3, 0)
			else
				local state = getVehicleLightState(veh, 0)
				if flasherState == 2 then
					setVehicleHeadLightColor(veh, 255, 255, 255)
				else
					if state==0 then
						setVehicleHeadLightColor(veh, 0, 0, 255)
					else
						setVehicleHeadLightColor(veh, 255, 0, 0)
					end
				end
				setVehicleLightState(veh, 0, 1-state)
				setVehicleLightState(veh, 1, state)
			end
		else
			vehicleFlashers[veh] = nil
			setVehicleHeadLightColor(veh, 255, 255, 255)
			setVehicleLightState(veh, 0, 0)
			setVehicleLightState(veh, 1, 0)
			setVehicleLightState(veh, 2, 0)
			setVehicleLightState(veh, 3, 0)
		end
	end		
end
setTimer(doFlashes, 250, 0)]]