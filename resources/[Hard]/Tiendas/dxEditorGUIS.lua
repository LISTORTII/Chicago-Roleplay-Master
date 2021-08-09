loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

addEventHandler( "onResourceStart", resourceRoot, 
	function()
		for i,v in ipairs(getElementsByType('player', root)) do
			bindKey(v,"i","down", function(player)
				triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
			end)
		end
		query('CREATE TABLE IF NOT EXISTS Inventario (Jugador TEXT, Item TEXT, Value INTEGER)')
	end
)

addEventHandler("onPlayerLogin", getRootElement(), function()
	bindKey(source,"i","down", function(player)
		triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
	end)
end)


function setPlayerItem(player, name, valor)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh <= 0 then
		insert("INSERT INTO Inventario VALUES (?,?,?)", AccountName( player ), name, valor)
	else
		if tonumber(valor) == 0 then
			delete("DELETE FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		else
			update("UPDATE Inventario SET Value='"..valor.."' WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		end
	end
end
		
function getPlayerItem(player, name)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		return tonumber(qh[1]["Value"])
	end
	return 0
end

function getReNameItem(player, name, newname)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		databaseUpdate("UPDATE Inventario SET Item=? WHERE Jugador='"..AccountName( player ).."'", newname)
	end
end

function getPlayerItems(player)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."'")
	if #qh ~= 0 then
		return qh
	end
	return {}
end

addEvent( 'Refresh:Inventory', true)
addEventHandler( 'Refresh:Inventory', root,
	function(name, valor)
		if tonumber(valor) <= getPlayerItem(source, name) then
			if name == "Caja de Cigarros" then
				if getPlayerItem(source, "Encendedor") >= 1 then
					source:setData("TextInfo", {"> Saca un cigarro y lo enciende", 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 3000, 1, source)
					source:setAnimation("GANGS", "drnkbr_prtl", 1, false,false)
					setPlayerItem(source, name, getPlayerItem(source, name)-1)
					setPlayerItem(source, "Encendedor", getPlayerItem(source, "Encendedor")-1)
				else
					exports['[LS]Notificaciones']:setTextNoti(source,"Para fumar 1 cigarro debes tener un encendedor en tu inventario", 150, 50, 50, true)
				end
			end
			if name == "Kit Herramientas" then
					if isPedInVehicle (source) then
        					local v = getPedOccupiedVehicle(source)
                				fixVehicle (v)
                				outputChatBox("reparado exitosamente",source, 46, 254, 0, true)
						source:setData("TextInfo", {"> Abre el Kit y arregla el coche", 255, 0, 216})
						setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
						end, 3000, 1, source)

						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else 
						outputChatBox("Debes estar en un vehiculos",source, 46, 254, 0, true)
  					 end
			end

			if name == "Bidon de Gasolina" then
				local veh = getPlayerNearbyVehicle(source)
				if veh then
					local gas = getElementData(veh, "Fuel")
					if gas <= 90 then
						source:setData("TextInfo", {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
						setTimer(function(p)
							p:setData("TextInfo", {"", 255, 0, 216})
						end, 2000, 1, source)
						source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1,true, false, false)
						setElementData(veh, "Fuel", 100)
						setTimer(function(p, veh)
							setPedAnimation(p)
						end, 2000, 1, source, veh)
						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else
						exports['[LS]Notificaciones']:setTextNoti(source,"Este vehículo tiene la gasolina llena.", 150, 50, 50, true)
					end
				end
			end
			if name == "Chocolate" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +5)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end 
			elseif name == "Pastel" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +25)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Agua" then
				local Agua = source:getData("Agua") or 100
				source:setData("Agua",Agua +25)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Agua") >= 100 then source:setData("Agua",100) end
			elseif name == "Agua Grande" then
				local Agua = source:getData("Agua") or 100
				source:setData("Agua",Agua +50)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Agua") >= 100 then source:setData("Agua",100) end
			elseif name == "Cerveza" then
				local Agua = source:getData("Agua") or 100
				source:setData("Agua",Agua +5)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Agua") >= 100 then source:setData("Agua",100) end
			elseif name == "Pizzeta" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +50)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Pizza Chica" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +20)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Pizza Grande" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +30)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Pata de Pollo" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +15)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Hamb. de Pollo" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +20)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Pollo Asado" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +10)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Hamburguesa" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +15)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Hamburguesa Chica" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +10)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			elseif name == "Hamburguesa Grande" then
				local comida = source:getData("Comida") 
				source:setData("Comida",comida +20)
				setPlayerItem(source, name, getPlayerItem(source, name)-1)
				if source:getData("Comida") >= 100 then source:setData("Comida",100) end
			end
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
)

addEvent( 'TiraItem:Inventory', true)
addEventHandler( 'TiraItem:Inventory', root,
	function(name, valor)
		if tonumber(valor) <= getPlayerItem(source, name) then
			setPlayerItem(source, name, getPlayerItem(source, name)-1)
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
)

function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end

Objetos = { 
	['hambre'] = {
		["Pizzeta"] = 5,
		["Pizza Chica"] = 6,
		["Pizza Grande"] = 4,
		["Hamburguesa"] = 4,
		["Hamburguesa Chica"] = 5,
		["Hamburguesa Grande"] = 6,
		["Pata de Pollo"] = 7,
		["Hamb. de Pollo"] = 8,
		["Pollo Asado"] = 10,
		["Galleta"] = 5,
	},
--
	['bebida'] = {
		["Cerveza"] = 5,
		["Agua"] = 20,
		["Lata de Spray"] = 10,
	}
}
--{"Caja de Cigarros", 50},
--{"Encendedor", 25},
--

function table.find(t, item)
	for tipo,comida in pairs(t) do
		for index,value in pairs(comida) do
			if (index == item) then
				return tipo,value
			end
		end
	end
	return false
end

local items = { 
{"Telefono"},
{"Agenda"},
{"Camara"},
{"Cuchillo de Caza (Arma)"},
{"Bidon Vacio"},
{'Bidon de Gasolina'},
{"Lata de Spray"},
{"Pizzeta"},
{"Pizza Chica"},
{"Pizza Grande"},
--
{"Pata de Pollo"},
{"Hamb. de Pollo"},
{"Pollo Asado"},
--
{"Cerveza"},
{"Agua"},
{"Caja de Cigarros"},
{"Encendedor"},
--
{"Hamburguesa"},
{"Hamburguesa Chica"},
{"Hamburguesa Grande"}
}

function isItemExist(itemName)
	for _,v in pairs(items) do
		if (v[1]:lower()) == (itemName:lower()) then
			return v[1]
		end
	end
	return false
end
