loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



local MarkersCarpintero = {}

local hola = createPed(309,2395.6748046875, -1304.1376953125, 25.623565673828)
setPedRotation(hola,135)

addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(getJobsCarpintero()) do

		--

		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

		--

		Pickup(v[1], v[2], v[3], 3, 1210, 0)

		MarkersCarpintero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)

		MarkersCarpintero[i]:setInterior(v.int)

		MarkersCarpintero[i]:setDimension(v.dim)

		MarkersCarpintero[i]:setData("MarkerJob", "Carpintero")

	end

end)

local Pickup = Pickup( 2404.55859375, -1316.384765625, 25.2601146698, 3, 1463, 0)
setElementInterior(Pickup, 0)
setElementDimension(Pickup, 0)

local Marcador = Marker( 2404.55859375, -1316.384765625, 25.2601146698-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Marcador, 0)
setElementDimension(Marcador, 0)

local Construmark1 = Marker( 2403.4375, -1307.8857421875, 25.355991363525-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark1, 0)
setElementDimension(Construmark1, 0)

local Construmark2= Marker(2403.3720703125, -1305.3564453125, 25.355823516846-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark2, 0)
setElementDimension(Construmark2, 0)

local Construmark3= Marker(2401.58203125, -1305.0615234375, 25.418085098267-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark3,0)
setElementDimension(Construmark3,0)

local Construmark4= Marker(2401.6865234375, -1307.7353515625, 25.41704750061-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark4,0)
setElementDimension(Construmark4,0)

local Construmark5= Marker(2399.6640625, -1305.267578125, 25.485294342041-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark5,0)
setElementDimension(Construmark5,0)

local Construmark6= Marker(2399.7744140625, -1307.78515625, 25.483892440796-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark6,0)
setElementDimension(Construmark6,0)

local Construmark7= Marker(2398.2724609375, -1307.53125, 25.536109924316-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark7,0)
setElementDimension(Construmark7,0)

local Construmark8= Marker(2398.1796875, -1305.2275390625, 25.537090301514-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark8,0)
setElementDimension(Construmark8,0)

local vender = Marker(2392.8349609375, -1305.537109375, 25.547071456909-1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(vender, 0)
setElementDimension(vender, 0)


local stateWindow = false
local boat
local gruz
local stateJob = false
local markerGruz
local markerSkad
local text = "Comezar"
local zp = 0
local gruzHand = false
local objeto = {}
--recojer
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Marcador) then
				print(1)
				local job = player:getData("Roleplay:trabajo")
				if job == "Carpintero" then
					print(2)
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then
					print(3)
					player:outputChat("Ya tienes madera",255,0,0,true)
					else
					print(4)
					setPedAnimation( player, "CARRY", "liftup", 1.0, false )
					 setTimer( function()
					print(5)
					setPedAnimation( player, nil )
					setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
					local x,y,z = getElementPosition(player)
					gruz = createObject ( 1463, x, y, z )
					local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." recoje madera",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					print(6)
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
					attachElements ( gruz, player, 0,0.4,0.5)
					if ( gruz ) then -- if it was created
					print(7)
					setObjectScale ( gruz, 0.5)
       					setElementCollisionsEnabled (gruz, false)
					end
					  setPedAnimation(player, nil )
					--toggleControl( "jump", true )
					--toggleControl(player, "fire", true )
					--toggleControl( "sprint", true )
					end,700,1)
					setElementData(player,"objeto",1)
					end
					 else
					print(8)
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					
					end
				end
			end
		end)
	end
end
)

local sillas = {
{1720},
{1805},
{1811},
{2096},
{2079},
{2120},
{2124},
{1739},

}

--construir
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark1) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1720, x, y, z )
						local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--con2
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark2) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1805, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.2)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons3
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark3) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1811, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 0000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons4
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark4) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 1720, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons5
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark5) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						 gruz1 = createObject ( 2096, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons6
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark6) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 2079, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons7
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark7) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 2120, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons8
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark8) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then	
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)	 
						setTimer( function(player)
            					setPedAnimation(player, "COLT45", "sawnoff_reload",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 1739, x, y, z )
							local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." fabrica una silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)

						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)

--vender
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(vender) then
				local job = player:getData("Roleplay:trabajo") 
				if job == "Carpintero" then
					local exp = player:getData("Roleplay:ExpJobCarpintero") or 1	
					local ob = getElementData(player,"silla") or 0
					if (ob >= 1) then  
					local a = getPlayerName(player)
					player:setData("TextInfo", {"> "..a.." le entraga la silla",255, 0, 216})
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
					local money = math.random(20,30)
					setPlayerMoney(player,getPlayerMoney(player)+money*exp/2)
					player:outputChat("Has ganado #00FF00$"..money.." dolares",255,255,255,true)
					player:outputChat("Por entregar la silla al transportador",255,255,255,true)
					destroyElement(gruz, nil)
					destroyElement(gruz1, nil)
					removeElementData(player,"objeto")
					removeElementData(player,"silla")
					local suerte = math.random(1,7)
					local exp2 = 1 + exp
					if (exp2 <= 10) then
					if suerte == 2 then
					text = "Acabas de obtener #E511E81 #ffffffexperiencia por trabajar."
					player:setData("Roleplay:ExpJobCarpintero",exp2)
					else
					text = ""
					end
					player:outputChat(text, 255, 255, 255, true)
					else
					player:outputChat("Has llegado a #E511E8 10 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
					end

					else
					player:outputChat("No tienes sillas para vender", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)

addCommandHandler("trabajar", function(player, cmd)

		if not player:isInVehicle() then

			if player:getData("Roleplay:trabajo") =="" then

				for i, marker in ipairs(MarkersCarpintero) do

					if player:isWithinMarker(marker) then

						local job = marker:getData("MarkerJob")

						if job == "Carpintero" then
	
							if player:getData("Roleplay:trabajo") == "Carpintero" then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)

							else	
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:setData("Roleplay:trabajo", "Carpintero")

								player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)

								--player:outputChat("Tienes 20 segundos para subir a tu vehículo o pierdas la misión.", 150, 50, 50, true)

						

						end

					end

				end

			end

		end

	end

end)



addCommandHandler("infocarpintero", function(player, cmd)



		if not player:isInVehicle() then

			for i, v in ipairs(MarkersCarpintero) do

				if player:isWithinMarker(v) then

					local job = v:getData("MarkerJob")

					if job == "Carpintero" then

						player:outputChat("¡Bienvenidos al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)
					
				

				end

			end

		end
	end

end)



addCommandHandler("renunciar", function(player, cmd)

		if not player:isInVehicle() then

			if player:getData("Roleplay:trabajo") ~="" then

				for i, v in ipairs(MarkersCarpintero) do

					if player:isWithinMarker(v) then

						local job = v:getData("MarkerJob")

						if job == "Carpintero" then

							if player:getData("Roleplay:trabajo") == "Carpintero" then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")

								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)

								player:setData("Roleplay:trabajo", "")

							else
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)

								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)

							

						end

					end

				end

			end

		end

	end

end)



