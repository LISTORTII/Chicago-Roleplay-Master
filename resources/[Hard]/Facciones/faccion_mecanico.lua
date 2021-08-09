local pick = Pickup(2209.8232421875, -2272.12109375, 13.554685592651,3,1239)
local pick2 = Marker(2208.205078125, -2277.529296875, 13.554685592651-1,"cylinder",4,255,255,255,50)


local car = {}
local num = 0

function crearveh(source)
	if isElementWithinPickup(source,pick) then
		if source:getData("Roleplay:faccion") == "Mecanico" then
			local x,y,z =  2215.826171875, -2270.498046875, 13.554685592651
			num = num + 1
			car[num] = createVehicle(525,x,y,z,0, 0, 45.942779541016)
			car[num]:setPlateText("Mecanico")
			car[num]:setData('Locked', 'Cerrado')
			car[num]:setData('Motor','apagado')
			car[num]:setData("vrd",num)
			car[num]:setData("VehiculoPublico", "Mecanico")
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

addCommandHandler("rveh", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			local cuenta = player:getAccount():getName()
			if getPlayerFaction(player, "Mecanico") or isObjectInACLGroup("user."..cuenta,aclGetGroup("Admin")) then
				local veh = player:getOccupiedVehicle()
				local seat = player:getOccupiedVehicleSeat()
				if player:isInVehicle() then
					if veh and seat == 0 then
						local owner = veh:getData("Owner")
						if owner then
							local thePlayer = getPlayerFromName(owner)
							if (thePlayer) then
								local costoTotal = math.ceil(0.5*veh:getHealth())
								veh:fix()
								--
								player:outputChat("Acabas de reparar el vehículo de ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
								thePlayer:outputChat("El mecanico: ".._getPlayerNameR(player).." acaba de reparar tu vehículo por el costo de: #004500$"..convertNumber(costoTotal).." dólares", 50, 150, 50, true)
								--
								thePlayer:takeMoney(tonumber(costoTotal))
							end
						else
							if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
								veh:fix()
							end
						end
					end
				end
			end
		end
	end
end)

function changeCarLightsColor ( thePlayer, cmd, red, green, blue )
	local cuenta = thePlayer:getAccount():getName()
	if thePlayer:getData("Roleplay:faccion") == "Mecanico" or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
		local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if ( theVehicle ) then
			red = tonumber ( red )
			green = tonumber ( green )
			blue = tonumber ( blue )
			if red and green and blue then
				local color = setVehicleHeadLightColor ( theVehicle, red, green, blue )
				if(color) then
					outputChatBox ( "Has cambiado las luces del vehiculo",thePlayer,50,255,50,true )
				else
					outputChatBox( "No se ha podido cambiar las luces",thePlayer,255,50,50,true )
				end
			else
				outputChatBox( "No se ha podido cambiar las luces",thePlayer,255,50,50,true )
			end
		else
			outputChatBox( "No estas en ningun vehiculo!",thePlayer,255,50,50)
		end
	end
end
addCommandHandler ( "luz", changeCarLightsColor )


--puerta

addEventHandler("onResourceStart",getResourceRootElement(),function()
    myGate1 = createObject ( 971, 2234.3999023438,-2215.6000976563, 16.10000038147 , 0, 0, 315.25 )
end)

addCommandHandler("abrirmek",function(source)
	if source:getData("Roleplay:faccion") == "Mecanico" then
		moveObject ( myGate1, 2500, 2240.6000976563,-2222, 16.10000038147 )
	end
end)

addCommandHandler("cerrarmek",function(source)
	if source:getData("Roleplay:faccion") == "Mecanico" then
 		moveObject ( myGate1, 2500, 2234.3999023438,-2215.6000976563, 16.10000038147 )
	end
end)



local function createBlip2(x, y, z, icon)
	createBlip( x, y, z, icon, 2, 255, 255, 255, 255, 0, 50 )
end


createBlip2(2205.81640625, -2230.94921875, 13.546875, 27) -- Mecanico
createBlip2(2945.2880859375, -1559.068359375, 1.5546875, 56) -- Pescador


