loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local pickup = createPickup(268.4697265625, 119.4306640625, 1004.6171875, 3, 348, 1)
setElementInterior( pickup, 10)

local Marcador = Marker(268.4697265625, 119.4306640625, 1004.6171875-1, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 10)

addCommandHandler("armas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				if getPlayerFaction(player, "Policia") then
					player:triggerEvent("Openarm", player)
				end
			end
		end
	end
end)

addEvent("buyarma", true)
addEventHandler("buyarma", root, function(id, itemName)
	if itemName == "Chaleco" then
		exports["Notificaciones"]:setTextNoti(source, "Usted ha tomado un chaleco anti balas de la armeria", 50, 150, 50)
		source:setArmor(100)
	elseif itemName == "Taser" then
		exports["Notificaciones"]:setTextNoti(source, "Usted ha tomado un "..itemName.." de la armeria", 50, 150, 50)
		giveWeapon(source, id, 5, true)
	else
		exports["Notificaciones"]:setTextNoti(source, "Usted ha tomado un "..itemName.." de la armeria", 50, 150, 50)
		giveWeapon(source, id, 50, true)
	end

end)