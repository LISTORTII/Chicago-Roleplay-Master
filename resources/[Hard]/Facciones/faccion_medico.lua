local pickEmerg = Pickup( 1176.3369140625, -1339.4853515625, 13.980255126953, 3, 1240, 0)

local pickMarker = Marker( 1176.3369140625, -1339.4853515625, 13.980255126953-1, "cylinder", 1.3, 100, 100, 100, 0)


permisosTotal = {
["Admin"]=true,
["Mod"]=true,
["SuperMod"]=true,
["Sup.Facc"]=true,
["Sup.Asesor"]=true,
["Sup.Grupos"]=true,
["Sup.Staff"]=true,

}


addCommandHandler("emergencia", function(player)

	if not notIsGuest(player) then

		if player:isWithinMarker(pickMarker) then

			if player:getMoney() >= 100 then

				if player:getHealth() <= 60 then
				
					player:setInterior(3)
					
					player:setPosition(441.7841796875, 137.69706726074, 1017.85546875)
					
					player:setAnimation("crack", "crckidle2", -1,false, true, false,false)
									
					player:outputChat("¡Has sido totalmente curado!", 50, 150, 50, true)

					player:setHealth(200)

					player:takeMoney(100)

					player:setData("Herido",nil)

				else

					exports['Notificaciones']:setTextNoti(player, "Debes tener menos de 60% de vida", 150, 50, 50)

				end

			else

				exports['Notificaciones']:setTextNoti(player, "No tienes suficiente dinero", 150, 50, 50)

			end

		end

	end

end)

--- Spawn

local JugadorMuerto = {}

local ValoresTablaAsesinato = {}

local antiSpamMensajes = {}



cuerpos = {

[3]="Torso", 

[4]="Culo", 

[5]="Brazo izquierdo", 

[6]="Brazo derecho", 

[7]="Pierna izquierda", 

[8]="Pierna derecha", 

[9]="Cabeza", 

}
local adentro = {}

function PlayerDamageText( attacker, weapon, bodypart, loss )
	if source:getHealth() >= 20 then
		source:setData("Herido", {"", 150, 50, 0})
		if ( attacker and attacker:getType() == "player" and bodypart ) then
			if ( source and source:getType() == "player" ) then
				if not source:isDead() then
					local tick = getTickCount()
					if (antiSpamMensajes[source] and antiSpamMensajes[source][1] and tick - antiSpamMensajes[source][1] < 10000) then
						return
					end
					source:outputChat(exports["Mysql"]:_getPlayerNameR(attacker).." te acaba de atacar.", 150, 50, 50, true)
					if (not antiSpamMensajes[source]) then
						antiSpamMensajes[source] = {}
					end
					antiSpamMensajes[source][1] = getTickCount()
				end
			end
		else
			if not isPedInVehicle(source) then
				if source:getData("Agua") ~= 0 or source:getData("Comida") ~= 0  then
					if adentro[source] == nil then
						source:setHealth(source:getHealth() - 2.5*loss)
					end
				end
			end
		end
	end
end

addEventHandler("onPlayerDamage", getRootElement(), PlayerDamageText)

local pick = Pickup(1395.2529296875, 6.2666015625, 1000.9158935547,3,1239)
setElementInterior(pick,1)
setElementDimension(pick,4)
local pick2 = Marker(1402.6123046875, 4.25, 1000.9077758789-1,"cylinder",4,255,255,255,50)
setElementInterior(pick2,1)
setElementDimension(pick2,4)

local num = 0
local car = {}

function crearveh(source)
	if isElementWithinPickup(source,pick) then
		if source:getData("Roleplay:faccion") == "Medico" then
			local x,y,z = 1394.4287109375, -15.4970703125, 1000.9178466797
			num = num + 1
			car[num] = createVehicle(416,x,y,z,0,0,270.69354248047)
			car[num]:setInterior(1)
			car[num]:setDimension(4)
			car[num]:setPlateText("LSRD")
			car[num]:setData('Locked', 'Cerrado')
			car[num]:setData('Motor','apagado')
			car[num]:setData("vrd",num)
			car[num]:setData("VehiculoPublico", "Medico")
			car[num]:setData('Fuel',100)
			car[num]:setLocked(true)
			car[num]:setEngineState (false)
			car[num]:setFrozen(true)
		else
			source:outputChat("[ERROR] NO eres de esta faccion",255, 100, 100, true)
		end
	end
end
addCommandHandler("veh",crearveh)



function destroy(source)
	if isElementWithinMarker(source,pick2) then
		if source:isInVehicle() then
			local veh = getPedOccupiedVehicle(source)
			local nume = veh:getData("vrd")
			if isElement(car[nume]) then
				car[nume]:destroy()
				car[nume] = nil
			end
		else
			source:outputChat("[ERROR] Tienes que estar encima de tu vehiculo",255, 100, 100, true)
		end
	end
end
addCommandHandler("borrarveh",destroy)



local herido = {}

function PlayerKilled( ammo, attacker, weapon, bodypart )
if herido[source] == true or cuerpos[bodypart] == "Cabeza" then
	if ( attacker and attacker:getType() == "player" and bodypart ) then
		if ( source and source:getType() == "player" ) then
			source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
			source:outputChat("#FFFFFF".._getPlayerNameR(attacker).." #963200te acaba de dejar inconsciente.", 255, 255, 255, true)
		--	JugadorMuerto[source] = false
			source:setData("Muerto",false)
			setTimer(function(source, weapon, bodypart, attacker)
				if isElement(source) or isElement(attacker) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				source:setData("NoDamageKill", true)
				setPedAnimation(source, "ped", "KO_shot_front", -1,false, false, false)
				source:setHealth(1)
		--		JugadorMuerto[source] = true
				source:setData("Muerto",true)
				herido[source] = nil
				source:setCameraTarget(source)
				source:removeFromVehicle(source:getOccupiedVehicle())
				source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
				source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Muerto por "..getWeaponNameFromID ( weapon ).." en "..cuerpos[bodypart].."", 150, 50, 0})
				ValoresTablaAsesinato[source] = attacker
			end
			end, 1000, 1, source, weapon, bodypart, attacker)
		end
	else
		source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
		--	JugadorMuerto[source] = false
			source:setData("Muerto",false)
		setTimer(function(source, weapon, bodypart)
			if isElement(source) then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local pos2 = Vector3(source:getRotation())
			local rx, ry, rz = pos2.x, pos2.y, pos2.z
			local int = source:getInterior()
			local dim = source:getDimension()
			source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
			source:setFrozen(true)
			setPedAnimation(source, "ped", "KO_shot_front", -1,false, false, false)
			source:setHealth(1)
			source:setCameraTarget(source)
			source:setData("NoDamageKill", true)
		--	JugadorMuerto[source] = true
			source:setData("Muerto",true)
			herido[source] = nil
			source:removeFromVehicle(source:getOccupiedVehicle())
			source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
			source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)
			source:setData("Herido", {"Muerto por caida", 150, 50, 0})
			ValoresTablaAsesinato[source] = source
		end
		end, 1000, 1, source, weapon, bodypart)
	end
else
	if ( attacker and attacker:getType() == "player" and bodypart ) then
		if ( source and source:getType() == "player" ) then
			source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
			source:outputChat("#FFFFFF".._getPlayerNameR(attacker).." #963200te acaba de dejar inconsciente.", 255, 255, 255, true)
		--	JugadorMuerto[source] = false
			source:setData("Muerto",false)
			setTimer(function(source, weapon, bodypart, attacker)
				if isElement(source) or isElement(attacker) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				setPedAnimation(source, "crack", "crckidle4", -1,true, false, false)
				source:setHealth(20)
				source:setCameraTarget(source)
				herido[source] = true
		---		JugadorMuerto[source] = true
				source:setData("Muerto",true)
				source:removeFromVehicle(source:getOccupiedVehicle())
				source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
				source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Inconsciente por "..getWeaponNameFromID ( weapon ).." en "..cuerpos[bodypart].."", 150, 50, 0})
				ValoresTablaAsesinato[source] = attacker
			end
			end, 1000, 1, source, weapon, bodypart, attacker)
		end
	else
		source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
	--	JugadorMuerto[source] = false
		source:setData("Muerto",false)
		setTimer(function(source, weapon, bodypart)
			if isElement(source) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				setPedAnimation(source, "crack", "crckidle4", -1,true, false, false)
				source:setHealth(20)
				--JugadorMuerto[source] = true
				source:setData("Muerto",true)
				herido[source] = true
				source:setCameraTarget(source)
				source:removeFromVehicle(source:getOccupiedVehicle())
				source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
				source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Inconsciente por caida", 150, 50, 0})
				ValoresTablaAsesinato[source] = source
			end
		end, 1000, 1, source, weapon, bodypart)
	end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), PlayerKilled)

--ver asesino 

function VerAsesino(player, cmd, who)

	if not notIsGuest( player ) then

		if permisosTotal[getACLFromPlayer(player)] == true then

			local thePlayer = exports["Gamemode"]:getFromName( player, who )

			if (thePlayer) then

				if ValoresTablaAsesinato[thePlayer] then

					player:outputChat("* El asesino de ".._getPlayerNameR(thePlayer).." es: #FF0033".._getPlayerNameR(ValoresTablaAsesinato[thePlayer]), 255, 255, 255, true)

				end

			else

				player:outputChat("Syntax: /asesino [ID]", 255, 255, 255, true)

			end

		end

	end
end

addCommandHandler("asesino", VerAsesino)

--

function aceptarMuerte(player)

	--if not notIsGuest(player) then

		if player:getData("Muerto") == true then


			player:outputChat("En 1 minuto, serás spawneado al hospital.", 150, 50, 50, true)

			--

			JugadorMuerto[player] = nil

			setTimer(function(source)

				if isElement(source) then

				setControlState( source, "fire", true )

				local skin = source:getModel()

				source:spawn(1177.9892578125, -1323.4267578125, 14.097885131836, skin, 0, 0, nil)

				source:setModel(skin)

				source:setData("Herido", {"", 150, 50, 0})

				source:setHealth(100)

				source:setFrozen(false)

				source:setData("NoDamageKill", nil)
				
				herido[player] = nil
				
				setPedAnimation(source)

			end
			
			end, 60000, 1, player)

		end

	--end

end



addCommandHandler("aceptarmuerte", aceptarMuerte)

local aviso = {
	AntiSpamM = {},
	blips = {},
}


--avisar_muerte

function avisar_muerte(jug)
	if not notIsGuest(jug) then

		if jug:getData("Muerto") == true then
			
			if aviso.AntiSpamM[jug] and getTickCount(  ) - aviso.AntiSpamM[jug] < 2000 then

				return exports['Notificaciones']:setTextNoti(jug, 'Ya haz enviando un aviso, ¡espera unos segundos!', 255, 255, 0)

			end

			for i,who in ipairs(Element.getAllByType('player')) do
				
				if getPlayerFaction( who, "Medico" ) or getPlayerFaction( who, "Bomberos" ) then

					who:outputChat('Se ha recibido un reporte de una persona herida. ((/muerte '..jug:getData('ID')..'))',255,255,0,true)
				end

			end

			jug:outputChat('Has avisado a todas las unidades de tu ubicacion',255,255,0,true)

			aviso.AntiSpamM[jug] = getTickCount(  )

		end

	end

end
addCommandHandler("avisarmuerte", avisar_muerte)


addCommandHandler("muerte",

	function(jug, cmd, who)

		if not notIsGuest(jug) then



			if getPlayerFaction( jug, "Medico" ) or getPlayerFaction( jug, "Bomberos") then



				if tonumber(who) then

					local player = exports["Gamemode"]:getFromName( jug, who )

					

					if player and JugadorMuerto[player] == true then



						local pos = player.position

						aviso.blips[jug] = aviso.blips[jug] or {}



						if isElement( aviso.blips[jug][player] ) then

							aviso.blips[jug][player]:destroy()

						end



						aviso.blips[jug][player] = Blip(pos,0,2, 255,255,0,255,0,65535,jug)		--exports['[LS]NuevosBlips']:createNewBlip(pos.x,pos.y, pos.z, 'dead', 0, 0, 1, 255, 255, 255, 65535, player)



						exports['[LS]Notificaciones']:setTextNoti(jug, 'Se a marcado la zona con un punto en tu mapa con un cuadro/triangulo #ffff00Amarillo', 255, 255, 255, true)

					end



				end



			end



		end



	end

)



addEventHandler( "onPlayerCommand", getRootElement(), 

	function(c)



		if c == 'limpref' then

			if getPlayerFaction( source, "Medico" ) or getPlayerFaction( source, "Bomberos" ) then



				if aviso.blips[source] then



					for k,v in pairs(aviso.blips[source]) do

						v:destroy()

						aviso.blips[source][k] = nil

					end



				end

				

			end



		end



	end

)
-- curar jugadores
local antiSpamW = {}
function curar_medico( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Medico" )  or getPlayerFaction( source, "Bomberos" ) or permisosTotal[getACLFromPlayer(source)] == true then

			local tick = getTickCount()
			if (antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 3000) then
				source:outputChat("Debes esperar 3 segundos",255,0,0,true)
				return
			end

			local player = exports["Gamemode"]:getFromName( source, jugador )

			if ( player ) then

				if ( not player:getData("Muerto") == true ) then
				
					local posicion = Vector3(source:getPosition()) -- source

					local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador

					-- jugador

					local pos = Vector3(player:getPosition())

					local x, y, z = pos.x, pos.y, pos.z

					local pos2 = Vector3(player:getRotation())

					local rx, ry, rz = pos2.x, pos2.y, pos2.z

					local int = player:getInterior()

					local dim = player:getDimension()

				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

					setPedAnimation(source)

					player:setHealth(player:getHealth()+20)

					player:setFrozen(false)
					
					MensajeRoleplay(source, "le ha dado una inyección ha ".._getPlayerNameR(player))
					
				end

				else

					source:outputChat("* El jugador: ".._getPlayerNameR(player).." esta muerto, usa el comando /reanimar [Nombre_Apellido o ID].", 150, 0, 0)

				end

			else

				source:outputChat("Syntax: /curar [ID]", 255, 255, 255, true)

			end

 		else

			source:outputChat("* No puedes usar este comando", 150, 50, 50)

		end
			if (not antiSpamW[source]) then
			antiSpamW[source] = {}
		end
		antiSpamW[source][1] = getTickCount()

	end

end

addCommandHandler("curar", curar_medico)



-- revivir para administradores

function revivirJugador(player, cmd, who)

	if not notIsGuest( player ) then

		if permisosTotal[getACLFromPlayer(player)] == true then

			local thePlayer = exports["Gamemode"]:getFromName( player, who )

			if (thePlayer) then

				if thePlayer:getData("Muerto") == true then

					local pos = Vector3(thePlayer:getPosition())

					local x, y, z = pos.x, pos.y, pos.z

					local pos2 = Vector3(thePlayer:getRotation())

					local rx, ry, rz = pos2.x, pos2.y, pos2.z

					local int = thePlayer:getInterior()

					local dim = thePlayer:getDimension()

					--JugadorMuerto[player] = nil

					thePlayer:setData("Muerto",false)

					thePlayer:spawn(x, y, z, rz, thePlayer:getModel(), int, dim, nil)

					thePlayer:setFrozen(false)

					thePlayer:setData("NoDamageKill", nil)

					setPedAnimation(thePlayer)

					thePlayer:setHealth(100)

					thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

					thePlayer:setData("Herido", {"", 150, 50, 0})

					outputDebugString("* ".._getPlayerNameR(player).." revivio al jugador: ".._getPlayerNameR(thePlayer).."", 0, 0, 150, 0)

					player:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(thePlayer)..".", 50, 150, 0)

					thePlayer:outputChat("* ".._getPlayerNameR(player).." te acaba de revivir.", 50, 150, 0)
					
					herido[player] = nil

				else

					player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." no esta muerto.", 150, 0, 0)

				end

			else

				player:outputChat("Syntax: /revivir [ID]", 255, 255, 255, true)

			end

		end

	end

end

addCommandHandler("revivir", revivirJugador)


function reanimar_medico ( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Medico" ) or  getPlayerFaction( source, "Bomberos" ) then

			local player = exports["Gamemode"]:getFromName( source, jugador )

			if ( player ) then

				-- source

				local posicion = Vector3(source:getPosition()) -- source

				local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador

				-- jugador

				local pos = Vector3(player:getPosition())

				local x, y, z = pos.x, pos.y, pos.z

				local pos2 = Vector3(player:getRotation())

				local rx, ry, rz = pos2.x, pos2.y, pos2.z

				local int = player:getInterior()

				local dim = player:getDimension()

				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

					if player:getData("Muerto") == true then
					
						if player ~= source then

						setPedAnimation(source, "MEDIC", "CPR", -1,true, false, false)

						outputDebugString("* ".._getPlayerNameR(source).." revivio al jugador: ".._getPlayerNameR(player).."", 0, 0, 150, 0)

						source:outputChat("* En 5 segundos será revivido el jugador: ".._getPlayerNameR(player).."", 50, 150, 50)

						--JugadorMuerto[player] = nil

						player:setData("Muerto",false)

						setTimer(function(player, source, x, y, z, rz, int, dim) 

							if isElement(player) then

							player:spawn(x, y, z, rz, player:getModel(), int, dim, nil)

							setPedAnimation(source)

							player:setHealth(10)

							player:setData("Herido", {"", 150, 50, 0})

							player:outputChat("* ".._getPlayerNameR(source).." te acaba de revivir.", 50, 150, 50)

							source:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(player)..".", 50, 150, 50)
															
							herido[player] = nil


						end

						end, 5000, 1, player, source, x, y, z, rz, int, dim)
						end

						player:setData("NoDamageKill", false)

					else

						source:outputChat("* El jugador: ".._getPlayerNameR(player).." no esta muerto.", 150, 0, 0)

					end

				else

					source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)

				end

			else

				source:outputChat("Syntax: /reanimar [ID]", 255, 255, 255, true)

			end
		end
	end
end
addCommandHandler("reanimar", reanimar_medico)

function getPlayersWithinRange( vector, range )
	local players = {}	-- body
	for i,v in ipairs(Element.getAllByType('player')) do
		
		if getDistanceBetweenPoints3D( vector, v.positon ) <= range then

			table.insert(players, v)

		end
	end
	return players
end



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


-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Muerto")
	if (conducir) then
		local va = t:getData("Muerto")
		source:setData("Muerto", va)
	else
		source:setData("Muerto", false)
	end
	if source:getData("Muerto") == true then 
		setTimer(function(source)
			source:setHealth(0)
		end,2000,1,source)
	end
end)

function quitMedico(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Muerto")
		account:setData("Muerto", va)
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitMedico)
addEventHandler("onStopResource", getRootElement(), quitMedico)

function stopPizzero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopPizzero)
