local marcadorSalida = Marker(1821.376953125, -1537.3740234375, 13.473017692566-1, "cylinder", 3, 100, 100, 100, 0)
marcadorSalida:setInterior(0)
marcadorSalida:setDimension(0)


local marcadorEntrada = Marker(1825.2548828125, -1538.203125, 13.546875-1,"cylinder", 3, 100, 100, 100, 0)
marcadorEntrada:setInterior(0)
marcadorEntrada:setDimension(0)


addEventHandler("onResourceStart", getRootElement(), function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					if getElementDimension( player ) == 0 and getElementInterior( player ) == 0 then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
		 					veh:setPosition(1828.6416015625, -1539.341796875, 13.3828125)
							veh:setRotation(0, 0, 261.62417602539)
							veh:setInterior(0)
							veh:setDimension(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1828.6416015625, -1539.341796875, 13.3828125)
							player:setDimension(0)
							player:setInterior(0)
						end
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					if getPlayerFaction(player, "Policia") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1817.3642578125, -1536.8486328125, 13.335792541504)
							veh:setDimension(0)
							veh:setRotation(0, 0, 84.906372070312)
							veh:setInterior(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1817.3642578125, -1536.8486328125, 13.335792541504)
							player:setDimension(0)
							player:setInterior(0)
						end
					else
						exports['Notificaciones']:setTextNoti(player, "Necesitas ser CPD para poder entrar.", 150, 50, 50)
					end
				end
			end
		end)
	end
end)

addEventHandler("onPlayerLogin",getRootElement(),function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					if getElementDimension( player ) == 4 and getElementInterior( player ) == 1 then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
		 					veh:setPosition(1828.6416015625, -1539.341796875, 13.3828125)
							veh:setRotation(0, 0, 261.62417602539)
							veh:setInterior(0)
							veh:setDimension(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1828.6416015625, -1539.341796875, 13.3828125)
							player:setDimension(0)
							player:setInterior(0)
						end
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					if getPlayerFaction(player, "Policia") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1817.3642578125, -1536.8486328125, 13.335792541504)
							veh:setDimension(0)
							veh:setRotation(0, 0, 84.906372070312)
							veh:setInterior(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1817.3642578125, -1536.8486328125, 13.335792541504)
							player:setDimension(0)
							player:setInterior(0)
						end
					else
						exports['Notificaciones']:setTextNoti(player, "Necesitas ser CPD para poder entrar.", 150, 50, 50)
					end
				end
			end
		end)
	end
end)