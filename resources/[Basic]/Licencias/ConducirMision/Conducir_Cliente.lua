local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}

local RutaConducir1 = {
[1]={1108.5035400391, -1740.6964111328, 13.407667160034,1164.666015625, -1740.958984375, 13.066601753235},
[2]={1164.666015625, -1740.958984375, 13.066601753235,1173.3564453125, -1841.9267578125, 13.057124137878},
[3]={1173.3564453125, -1841.9267578125, 13.057124137878,1325.3720703125, -1855.103515625, 13.038510322571},
[4]={1325.3720703125, -1855.103515625, 13.038510322571,1410.5986328125, -1874.546875, 13.03588104248},
[5]={1410.5986328125, -1874.546875, 13.03588104248,1673.474609375, -1870.853515625, 13.038702011108},
[6]={1673.474609375, -1870.853515625, 13.038702011108,1691.9716796875, -1831.5673828125, 13.030759811401},
[7]={1691.9716796875, -1831.5673828125, 13.030759811401,1691.328125, -1745.0693359375, 13.043862342834},
[8]={1691.328125, -1745.0693359375, 13.043862342834,1587.591796875, -1729.9638671875, 13.03394317627},
[9]={1587.591796875, -1729.9638671875, 13.03394317627,1536.3828125, -1729.517578125, 13.03510093689},
[10]={1536.3828125, -1729.517578125, 13.03510093689,1531.84375, -1604.884765625, 13.03352355957},
[11]={1531.84375, -1604.884765625, 13.03352355957,1445.2197265625, -1589.3779296875, 13.035620689392},
[12]={1445.2197265625, -1589.3779296875, 13.035620689392,1427.3701171875, -1721.166015625, 13.035376548767},
[13]={1427.3701171875, -1721.166015625, 13.035376548767,1323.59375, -1729.853515625, 13.029813766479},
[14]={1323.59375, -1729.853515625, 13.029813766479,1316.2138671875, -1558.2216796875, 13.043326377869},
[15]={1316.2138671875, -1558.2216796875, 13.043326377869,1359.0341796875, -1421.220703125, 13.032114982605},
[16]={1359.0341796875, -1421.220703125, 13.032114982605,1326.9775390625, -1393.244140625, 13.018159866333},
[17]={1326.9775390625, -1393.244140625, 13.018159866333,1215.1923828125, -1398.5947265625, 12.877768516541},
[18]={1215.1923828125, -1398.5947265625, 12.877768516541,1194.17578125, -1416.9814453125, 12.86231136322},
[19]={1194.17578125, -1416.9814453125, 12.86231136322,1194.15625, -1560.9052734375, 13.034896850586},
[20]={1194.15625, -1560.9052734375, 13.034896850586,1283.9482421875, -1574.919921875, 13.036152839661},
[21]={1283.9482421875, -1574.919921875, 13.036152839661,1295.0400390625, -1701.9619140625, 13.033772468567},
[22]={1295.0400390625, -1701.9619140625, 13.033772468567,1177.62890625, -1709.5029296875, 13.200180053711},
[23]={1177.62890625, -1709.5029296875, 13.200180053711,1172.8994140625, -1736.267578125, 13.121531486511},
[24]={1172.8994140625, -1736.267578125, 13.121531486511,1102.3330078125, -1739.107421875, 13.169894218445},
[25]={1102.3330078125, -1739.107421875, 13.169894218445},
}
function startMision(tip, ruta)
	for i, v in ipairs(RutaConducir1) do
		local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
		local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
		mark = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
		createBlipAttachedTo(mark, 0, 2, 200, 200, 0, 255)
		if i <= 37 then
			setMarkerTarget(mark, x2, y2, z2)
			setMarkerIcon ( mark, "arrow" )
		else
			setMarkerIcon ( mark, "finish" )
		end
	end
end
function startMision(tip, ruta)
	if localPlayer:getData("Roleplay:Mision") == "Licencia" then
		if tip == "Conducir" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#RutaConducir1)
				--
				for i=1, #RutaConducir1 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
						local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 200, 200, 0, 255)
						--
						if i <= 24 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onMarkerRutHit)
					end
				end
			end
		end
	end
end

function onMarkerRutHit( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 410 and seat == 0 then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						ValoresTrabajo[hitElement] = nil
						if isElement(MarcadoresRuta) then
							destroyElement(MarcadoresRuta)
						end
						if isElement(BlipsRuta) then
							destroyElement(BlipsRuta)
						end
						triggerServerEvent("ObtenerLicencia", hitElement)
						table.remove(PosicionAuto, 1)
					else
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startMision, 50, 1, "Conducir", 1)
					end
					for i=1, #RutaConducir1 do
						if i <= ValoresTrabajo[hitElement][2] then
							if isElement(MarcadoresRuta[i]) then
								destroyElement(MarcadoresRuta[i])
							end
								if isElement(BlipsRuta[i]) then
								destroyElement(BlipsRuta[i])
							end
						end
					end
				end
			end
		end
	end
end

addEvent("IniciarRutaLicencia", true)
function IniciarRutaLicencia(tip)
	if tip == "Conducir" then
		for i=1, #RutaConducir1 do
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
			end
		end
		ValoresTrabajo[localPlayer] = {nil, 1, true}
		startMision("Conducir", 1)
		failedMision("Conducir", localPlayer, nil, 20)
	end
end
addEventHandler("IniciarRutaLicencia", root, IniciarRutaLicencia)

local TableFailed = {}
local TimerK = {}
local tableN = {}


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" then
				if thePlayer:getData("Roleplay:Mision") == "Licencia" then

        				if ValoresTrabajo[thePlayer] then

        					if ValoresTrabajo[thePlayer][3] == true then

        				outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        				failedMision("Conducir", thePlayer, source, 30)
						end        			
					end
				end
        		end
        	end
        end
end
end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if ValoresTrabajo[thePlayer][3] == true then
        				if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
        				end
        				if not TableFailed[thePlayer] then
        					TableFailed[thePlayer] = not TableFailed[thePlayer]
	        				local x, y, z = getElementPosition(thePlayer)
	        				local x2, y2, z2 = getElementRotation(thePlayer)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", localPlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rapido ni chocarte", 20000, "No")
	        			end
        			end
        		end
        	end
        end
    end
)

function failedMision(tip, thePlayer, vehiculo, timer)
	if tip == "Conducir" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:Mision", "")
				for i=1, #RutaConducir1 do
					if isElement(MarcadoresRuta[i]) then
						destroyElement(MarcadoresRuta[i])
					end
					if isElement(BlipsRuta[i]) then
						destroyElement(BlipsRuta[i])
					end
				end
				ValoresTrabajo[p] = {nil, 1, false}
				triggerServerEvent("remo",thePlayer)
				--
				TableFailed[p] = nil;
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end