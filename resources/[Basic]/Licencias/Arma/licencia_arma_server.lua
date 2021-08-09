

addEventHandler("onResourceStart", resourceRoot, function()
	LicenciasArmas = Marker( 240.4521484375, 112.7783203125, 1003.21875-1, "cylinder", 1.5, 100, 100, 100, 0 )
	LicenciasArmas:setInterior(10)
end)



addCommandHandler("portearma", function(player, cmd)
	if not notIsGuest(player) then
		local nivel = getElementData(player,"Nivel") or 0
		local lic = player:getData("Roleplay:Licencia_Arma")
		if not player:isInVehicle() then
			if player:isWithinMarker(LicenciasArmas) then
				if lic == false then
					if (nivel >= 3) then
						if player:getMoney() >= 8500 then
							player:setData("Roleplay:Licencia_Arma", true)
							player:outputChat("Acabas de obtener la licencia de armas por: #004500$8,500 dólares", 50, 150, 50, true)
							player:takeMoney(8500)
						else
							exports["Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero nesecitas $8500", 150, 50, 50, true)
						end
					else
						exports["Notificaciones"]:setTextNoti(player, "Debes tener nivel 3 para comprarla", 150, 50, 50, true)
					end
				else
					exports["Notificaciones"]:setTextNoti(player, "Ya tienes la licencia de armas", 150, 50, 50, true)
				end
			end
		end
	end
end)



function getPlayerYear(player)

	if isElement(player) then

		local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))

		if s then

			if not ( type( s ) == "table" and #s == 0 ) or not s then

				return tonumber(s[1]["Edad"]) or 0

			end

		end

	end

end
