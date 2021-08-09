loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local baliza = {}


permisos = {
["Admin"]=true,
["Mod"]=true,
["SuperMod"]=true,
["Sup.Staff"]=true,
["Sup.Facciones"]=true,
["Sup.Grupos"]=true,
["Sup.Asesores"]=true,
}


local CinturonSeguridad = {}

addCommandHandler("balizas",function(source)
	local veh = getPedOccupiedVehicle(source)
	if veh then
		if baliza[veh] == true then
			baliza[veh] = false
		else
			baliza[veh] = true
		end
	end
end)



addEventHandler("onVehicleEnter", getRootElement(), function( thePlayer, seat, jacked )

	if thePlayer:getType() == "player" then

		if seat == 0 then

			if thePlayer:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:Mision") == source:getData("VehiculoPublico") then

			else

				thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

				source:setEngineState (false)

				source:setLightState(0, 1)

				source:setLightState(1, 1)

				source:setFrozen(false)

				outputChatBox("Este vehículo le pertenece a un vehiculos publico",thePlayer, 150, 50, 50, true)

				--

			end

		end

	end

end)

addCommandHandler("paintjob",function(source,cmd,id)
	local accName = getAccountName ( getPlayerAccount ( source ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPPro" ) ) then
		if tonumber(id) then
			if tonumber(id) >= 0 and tonumber(id) <= 3 then
				local veh = source:getOccupiedVehicle()
				if source:isInVehicle() then
					setVehiclePaintjob(veh,id)
				else
					source:outputChat("[ERROR] Deves estar en un vehiculo",255,50,50,true)
				end
			else
				source:outputChat("[ERROR] Pon un numero del 0 al 3",255,50,50,true)
			end
		else
			source:outputChat("[ERROR] Syntax: /paintjob [0 - 3]",255,50,50,true)
		end
	end
end)


addCommandHandler("respawnveh",function(source)
	if permisos[getACLFromPlayer(source)] == true then
		for i,v in ipairs(Element.getAllByType("vehicle")) do
			local d = v:getData("VehiculoPublico")
			if d ~= false then
				if isVehicleEmpty( v ) then
					setTimer(function(v)
						v:respawn()
						if d == "Camionero" or d == "Basurero" or d == "Taxista" or d == "Pizzero" then
							triggerEvent("veh"..d,root)
						end
					end,15000,1,v)
				end
			end
		end
		for i, v in ipairs(Element.getAllByType("player")) do
			v:outputChat("#DB5A05Server Informa: #FFFFFF En 15 Segundos los Vehiclos publicos seran Respawneados", 20, 150, 20, true)
		end
		setTimer(function()
			exports['Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #FF7100vehículos públicos #FFFFFFhan sido respawneados.")
		end,15000,1)
	end
end)

addCommandHandler("llenargasveh",function(source)
	if permisos[getACLFromPlayer(source)] == true then
		for _, v in ipairs(Element.getAllByType("vehicle")) do
			if v:getData("VehiculoPublico") ~= false then
				v:setData("Fuel",100)
			end
		end
	end
	exports['Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #FF7100vehículos públicos #FFFFFFhan sido llenados de gasolina.")
end)

setTimer(function()
	for i,v in ipairs(Element.getAllByType("vehicle")) do
		local d = v:getData("VehiculoPublico")
		if d ~= false then
			v:setData("Fuel",100)
			if isVehicleEmpty( v ) then
				setTimer(function(v)
					v:destroy()
					if d == "Camionero" or d == "Basurero" or d == "Taxista" or d == "Pizzero" then
						triggerEvent("veh"..d,root)
					end
				end,15000,1,v)
			end
		end
	end
	exports['Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #FF7100vehículos públicos #FFFFFFhan sido llenados de gasolina.")
	for i, v in ipairs(Element.getAllByType("player")) do
		v:outputChat("#DB5A05Server Informa: #FFFFFF En 15 Segundos los Vehiclos publicos seran Respawneados", 20, 150, 20, true)
	end
	setTimer(function()
		exports['Notificaciones']:setTextNoti(Element.getAllByType("player"), "#FFFFFFTodos los #FF7100vehículos públicos #FFFFFFhan sido respawneados.")
	end,15000,1)
end,1000*60*30,0)


addEventHandler("onVehicleStartExit", getRootElement(), function(thePlayer, seat)
	local veh = thePlayer:getOccupiedVehicle()
	if veh:getData('Locked') == 'Cerrado' then
		thePlayer:outputChat("Este vehiculo esta cerrado no puedes salir",255,50,50,true)
		cancelEvent()
	else
	 	if CinturonSeguridad[thePlayer] then
			if CinturonSeguridad[thePlayer] == true then
				MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")
				CinturonSeguridad[thePlayer] = nil
				setElementData(thePlayer,"cinturon",false)
			end
		end
	end
end)


addEventHandler("onVehicleDamage", getRootElement(), function(loss)
	local thePlayer = source:getOccupant()
	if (thePlayer) then
		local dmg = math.floor(loss)
		if dmg >= 100 then
			if CinturonSeguridad[thePlayer] then
				if CinturonSeguridad[thePlayer] == true then
					thePlayer:outputChat("El vehículo acaba de sufrir un fuerte choque..", 150, 50, 50)
					thePlayer:outputChat("Como llevas el cinturon de seguridad no sufriste daños.", 50, 150, 50)
					thePlayer:setHealth(source:getHealth())
				end
			else
				thePlayer:outputChat("El vehículo acaba de sufrir un fuerte choque.", 150, 50, 50)
				thePlayer:outputChat("Como no llevas el cinturon de seguridad sufriste daños.", 150, 50, 50)
				if thePlayer:getHealth() >= 20 then
					thePlayer:setHealth(thePlayer:getHealth() - math.random(3,8) )
				end
			end
			source:setEngineState (false)
			source:setFrozen(false)
			source:setLightState(0, 1)
			source:setLightState(1, 1)
			source:setData('Motor', 'apagado')
		end
	end
end)


setTimer(
function ( )
	for _, vehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
	 if getElementHealth(vehicle) < 401 then
	 setVehicleDamageProof( vehicle, true)
	 setVehicleEngineState( vehicle, false)
 else
     if getElementHealth(vehicle) > 402 then
	 setVehicleDamageProof( vehicle, false)
   end
  end
 end
end,
100, 0
)

addCommandHandler("cinturon", function(thePlayer)
	local veh = thePlayer:getOccupiedVehicle()
	local seat = thePlayer:getOccupiedVehicleSeat()
	if veh then 
		if CinturonSeguridad[thePlayer] then
			MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")
			CinturonSeguridad[thePlayer] = nil		
			setElementData(thePlayer,"cinturon",false)
		else
			MensajeRol(thePlayer, " se abrocha el cinturon de seguridad.")
			CinturonSeguridad[thePlayer] = true
			setElementData(thePlayer,"cinturon",true)
		end
	end
end)

bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}

addEventHandler("onVehicleEnter", getRootElement(), function( player, seat, jacked, door )
	if source:getHealth() <= 280 then
		source:setEngineState (false)
		source:setFrozen(false)
		source:setLightState(0, 1)
		source:setLightState(1, 1)
		source:setData('Motor', 'apagado')
	end
	if seat == 0 then
		if not bicicletas[source:getModel()] then
			if source:getHealth() >= 300 then
				if source:getData('Motor') == 'apagado' then
					local gas = getElementData(source, "Fuel") or 0
					if gas >= 1 then 
						source:setEngineState (false)
						source:setLightState(0, 1)
						source:setLightState(1, 1)
						exports['Notificaciones']:setTextNoti(player, "Usa el comando #00FF00/motor #FFFFFFpara encender/apagar el vehículo.")
					end
					source:setFrozen(false)
				end	
			else
				source:setEngineState (false)
				source:setFrozen(false)
				source:setLightState(0, 1)
				source:setLightState(1, 1)
				source:setData('Motor', 'apagado')
				player:outputChat("¡El motor esta malogrado, necesita reparación el vehículo!", 150, 50, 50, true)
			end
		end
	end
end) 

addCommandHandler("fuel",function(player,cmd,fuel)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) then
		local veh = player:getOccupiedVehicle()
		setElementData(veh,"Fuel",tonumber(fuel))
	end
end)

addCommandHandler("motor", function(player)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if veh and seat == 0 then
			local gas = getElementData(veh, "Fuel") or 0
			if gas >= 1 then 
				if not player:getData("EnGasolinera") then
					if veh:getHealth() >= 300 then
						if veh:getData('Motor') == 'apagado' then
							MensajeRol(player, " esta encendiendo el motor del vehículo")
							setTimer(function(player, veh)
								MensajeRol(player, "El motor del vehículo de ".._getPlayerNameR(player).." fue encendido (".._getPlayerNameR(player)..")", 1)
								veh:setEngineState(true)
								veh:setData('Motor','encendido',false)
								veh:setFrozen(false)
							end, 1500, 1, player, veh)
							for i,v in ipairs(getPlayersOverArea(player,10)) do
								v:triggerEvent('SonidoEncenderVeh',v,'auto')
							end
						else
							MensajeRol(player, " apago el motor del vehículo")
							setTimer(function(player, veh)
								MensajeRol(player, "El motor del vehículo de ".._getPlayerNameR(player).." fue apagado (".._getPlayerNameR(player)..")", 1)
								veh:setEngineState(false)
							--	veh:setFrozen(true)
								veh:setData('Motor','apagado')
							end, 500, 1, player, veh)
						end
					end
				end
			end
		end
	end
end)

local Lights = {}
addCommandHandler('luces',
	function(player)
		local veh = player.vehicle
    	if veh then
    		Lights[veh] = 3 - (Lights[veh] or 1)
    		setVehicleOverrideLights( veh, Lights[veh] )
    	end

    end
)

local veh_sirens = {}

local sirensOffs = {

	[596] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[597] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[598] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[599] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},

	[490] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},

	[528] = {{0.5, 0.5, 1.1},{-0.5, 0.5, 1.1},{0, 0.5, 1.1},{255,0,0},{0,0,255}},

	[427] = {{0.3, 0.8, 1.2},{-0.3, 0.8, 1.2},{0, 0.8, 1.2},{255,0,0},{0,0,255}},

	[523] = {{0.3, -1, 0.5},{-0.3, -1, 0.5},{0, -1, 0.5},{255,0,0},{0,0,255}},

	[416] = {{0.3, 1.2, 1.2},{-0.3, 1.2, 1.2},{0, 1.2, 1.2},{255,0,0},{0,0,255}},

	[407] = {{0.7, 3.2, 1.3},{-0.7, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},

	[544] = {{0.6, 3.2, 1.3},{-0.6, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},

	[433] = {{0.4, 1, 1.8},{-0.4, 1, 1.8},{0, 1, 1.8},{73,41,3},{73,41,3}},



}



function toggleHordVehicle(player)

	local veh = player.vehicle;

	local seat = player:getOccupiedVehicleSeat()

	if veh and seat == 0 or seat == 1 then

		local id = veh.model;

		if id == 596 or id == 597 or id == 598 or id == 599 or id == 490 or id == 528 or id == 427 or id == 523 or id == 416 or id == 407 or id == 544 or id == 433 then
			
			if not veh_sirens[veh] then

				veh_sirens[veh] = true
				setVehicleSirensOn( veh, true )

				triggerClientEvent('SirenaConfig',root, veh)
				addVehicleSirens(veh,3,2,false,false,true)

				local fr,fg,fb = unpack(sirensOffs[id][1]) 

				local r,g,b = unpack(sirensOffs[id][4])

				setVehicleSirens(veh, 1, fr,fg,fb, (r or 255), (g or 0), (b or 0), 255, 255 )

				local fr,fg,fb = unpack(sirensOffs[id][2])

				local r,g,b = unpack(sirensOffs[id][5])

				setVehicleSirens(veh, 2, fr,fg,fb, (r or 0), (g or 0), (b or 255), 255, 255 )

				local fr,fg,fb = unpack(sirensOffs[id][3])

				setVehicleSirens(veh, 3, fr,fg,fb, 255, 255, 255, 255, 255 )
			
			else

				removeVehicleSirens(veh)
				triggerClientEvent('SirenaConfig',root, veh)
			
				veh_sirens[veh] = nil
				setVehicleSirensOn( veh, false)

			end
		end

	end

end


function startJoin()

	if eventName == 'onPlayerJoin' then

		bindKey(source,"horn","down", toggleHordVehicle )

	else

		for i,v in ipairs(Element.getAllByType('player')) do
			bindKey(v,"horn","down", toggleHordVehicle )
		end

	end
end
addEventHandler( "onPlayerJoin", getRootElement(), startJoin )
addEventHandler( "onResourceStart", getResourceRootElement(  ), startJoin )






function isVehicleEmpty( vehicle )
	if isElement( vehicle ) or getElementType( vehicle ) == "vehicle" then
		for ind,val in ipairs(getVehicleOccupants(vehicle)) do
			return false
		end
	return true
	end
end

function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.3 then
				return veh
			end
		end
	end
	return false
end

function getPlayersOverArea(player,range)

	local new = {}

	local x, y, z = getElementPosition( player )

	local chatCol = ColShape.Sphere(x, y, z, range)

	new = chatCol:getElementsWithin("player") or {}

	chatCol:destroy()

	return new

end
