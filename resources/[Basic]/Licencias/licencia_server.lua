loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local tabla = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs(pickups_infos) do
		tabla[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 255, 255, 255, 0)
		tabla[i]:setInterior(v.int)
		tabla[i]:setDimension(v.dim)
	end
end)

addCommandHandler("licencias", function(p)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			for i, v in ipairs(tabla) do
				if p:isWithinMarker(v) then
					p:triggerEvent("setPanelLicencieros", p)
				end
			end
		end
	end
end)

local veh = {}

-- mision
addEvent("startMisionsLicenses", true)
function startMisionsLicenses(t, money)
	if source:getMoney() >= tonumber(money) then
		if t == "Conducir" then
			if source:getData("Roleplay:Licencia_Conducir") == true then
				source:outputChat("* Ya tienes una licencia de conducir", 150, 50, 50, true)
			else
				veh[source] = Vehicle(410,2058.89453125, -1911.19921875, 13.546875,1.1123962402344)
				veh[source]:setData('Fuel',100)
				veh[source]:setPlateText("Enseñanza")
				source:setInterior(0)
				source:warpIntoVehicle(veh[source])
				source:setData("Roleplay:Mision", "Licencia")
				source:triggerEvent("IniciarRutaLicencia", source, "Conducir")
				source:takeMoney( tonumber(money))
			end
		elseif t == "Navegar" then
			if source:getData("Roleplay:Licencia_Navegar") == true then
				source:outputChat("* Ya tienes una licencia de navegar", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Navegar", true)
			end
		elseif t == "Piloto" then
			if source:getData("Roleplay:Licencia_Piloto") == true then
				source:outputChat("* Ya tienes una licencia de piloto", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Piloto", true)
			end
		elseif t == "Pesca" then
			if source:getData("Roleplay:Licencia_Pesca") == true then
				source:outputChat("* Ya tienes una licencia de pesca", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Pesca", true)
			end
		end
	else
		source:outputChat("No tienes el dinero suficiente para comprar esta Licencia.", 150, 50, 50, true)
	end
end
addEventHandler("startMisionsLicenses", root, startMisionsLicenses)

function ObtenerLicencia()
	source:setData("Roleplay:Mision", "")
	source:setData("Roleplay:Licencia_Conducir", true)
	if isElement(veh[source]) then
		veh[source]:destroy()
	end
	source:outputChat("* Acabas de obtener tu licencia de conducir.", 50, 150, 50, true)
end
addEvent("ObtenerLicencia", true)
addEventHandler("ObtenerLicencia", root, ObtenerLicencia)

addEvent("remo", true)
addEventHandler("remo", root, function()
	if isElement(veh[source]) then
		veh[source]:destroy()
	end
end)