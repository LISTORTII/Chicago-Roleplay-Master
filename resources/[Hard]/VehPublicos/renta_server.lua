local vehrentable = {}


local numerent = {}
local rentadio = {}
local rentadio2 = {}

addEvent("setrespawn",true)
addEventHandler("setrespawn",root,function(pos,veh)
	for i,v in ipairs(pos) do
		local id,x,y,z,rx,ry,rz,precio = unpack(v)
		veh:setRespawnPosition(x,y,z,rx,ry,rz)
	end
end)


addCommandHandler("rentar",function(player,cmd,timer)
	local vehicle = getVehicleCercano(player)
	if vehicle:getData("rentable") == true and numerent[player] ~= 1 then
		if player:getMoney() >= (vehicle:getData('Rentable:Precio') * timer) then
			if timer then
				if (tonumber(timer) >= 1) and (tonumber(timer) <= 10)then
					numerent[player] = 1
					vehicle.frozen = false
					vehicle:setLocked(false)
					vehicle:setData("rentable",false)
					vehicle:setData("rentado",player)
				 	vehicle:setData('Vehiculo:Rentable:Duracion',timer*60)
				 	rentadio[player] = 0
				 	setTimer(function(player)
				 		if rentadio[player] == 1 then
				 			return
				 		else
								local dura = vehicle:getData("Vehiculo:Rentable:Duracion")
							if dura > 0 then
								setTimer(function(player)
									if rentadio2[player] == nil then
										rentadio2[player] = true
										player:giveMoney(- vehicle:getData('Rentable:Precio'))
									end
								end,60000,0,player)
								vehicle:setData("Vehiculo:Rentable:Duracion",dura-1)
							else
								for i,v in ipairs(rentas) do
									vehicle:setData('Rentable:Precio',v[8])
									if player:isInVehicle() then
										player:removeFromVehicle(player:getOccupiedVehicle())
									end
									vehicle:respawn()
									vehicle:setData("Vehiculo:Rentable:Duracion",0)
									vehicle:setData("fuel",100)
									vehicle:setData("rentado",false)
									vehicle:setData("rentable",true)
									vehicle.frozen = true
									vehicle:setLocked( true ) 
									rentadio[player] = 1
									numerent[player] = 0
								end
							end
						end
					end,1000,0,player)
				else
					player:outputChat("[ERROR] Debes poner un numero del 1 a 10",255,100,100,true)
				end
			else
				player:outputChat("Syntax: /rentar [1-10]",255,100,100,true)
			end
		else
			player:outputChat("[ERROR] No tienes suficente dinero",255,100,100,true)
		end
	end
end)




function getVehicleCercano(player)
	for k,v in pairs(Element.getAllByType('vehicle')) do
		if getDistanceBetweenPoints3D( player.position, v.position ) <= 3 then
			return v
		end
	end
	return false
end