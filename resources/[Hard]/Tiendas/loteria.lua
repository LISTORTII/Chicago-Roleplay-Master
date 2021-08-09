function loteria()
	for index, player in ipairs(Element.getAllByType("player")) do
		local number = math.random(1000,9999)
		print(number)
		if player:getData("loteria") == number then
			outputChatBox("El Ganador de la loteria es "..player:getName():gsub("_"," "),getRootElement(),255,255,255,true)
			outputChatBox("Ha ganado $"..math.random(50000,100000),getRootElement(),255,255,255,true)
		end
	end
end
setTimer(function()
	loteria()
end, 24000*60*60,0) --




local pickup = Pickup(1009.908203125, 2156.919921875, 1011.932800293, 3, 1274, 1)
setElementInterior( pickup, 1)

local Marcador = Marker(1009.908203125, 2156.919921875, 1011.932800293-1, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 1)

addCommandHandler("loteria", function(player, cmd, numero)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				if tonumber(numero) then
					local numero = tonumber(numero)
					if numero >= 1000 and numero <= 9999 then
						player:setData("loteria",numero)
					end
				end
			end
		end
	end
end)