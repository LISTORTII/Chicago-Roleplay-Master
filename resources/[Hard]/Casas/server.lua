loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

permisos = {
["Administrador"]=true,
["Sup.Staff"]=true,
}

local houseid = 0 
local house = {}
local houseData = {}
local houseInt = {}
local houseIntData = {}
local envisita = {}
local envisitain = {}

local saveableValues = {
	["ID"] = "ID",
	["X"] = "X",	
	["Y"] = "Y",
	["Z"] = "Z",
	["INTX"] = "INTX",
	["INTY"] = "INTY",
	["INTZ"] = "INTZ",
	["MONEY"] = "MONEY",
	["LOCKED"] = "LOCKED",
	["PRICE"] = "PRICE",
	["OWNER"] = "OWNER",
	--["Password"] = "Password"
}



addCommandHandler("entrar", function(thePlayer)
	if envisita[thePlayer] == nil then
		return
	else
		local house = envisita[thePlayer]
		if(house) then
			local id = tonumber(house)
			if(tonumber(houseData[id]["LOCKED"]) == 0) then
				local int, intx, inty, intz, dim = houseIntData[id]["INT"], houseIntData[id]["X"], houseIntData[id]["Y"], houseIntData[id]["Z"], id
				setInPosition(thePlayer, intx, inty, intz, int, false, dim)
				envisitain[thePlayer] = id
			else
				outputChatBox("¡Casa cerrada! No se le permite entrar!", thePlayer, 255, 0, 0)
			end
		end
	end
end)

addCommandHandler("salir", function(thePlayer)
	if envisitain[thePlayer] == nil then
		return
	else
		local house = envisitain[thePlayer]
		if(house) then
			local id = tonumber(house)
			local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
			--setElementData(thePlayer, "house:in", false)
			setInPosition(thePlayer, x, y, z, 0, false, 0)
		end
	end
end)

addCommandHandler("comprarcasa", function(thePlayer)
	if envisita[thePlayer] == nil then
		return
	else
		local house = envisita[thePlayer]
		if(house) then
			local id = house
			local owner = houseData[id]["OWNER"]
			local pick = houseData[id]["PICKUP"]
			local price = houseData[id]["PRICE"]
			if(owner == "") then
				local ids = tonumber(getLastID(thePlayer))
				if (not getPlayerVIP(source) and ids-1 < 1) or (getPlayerVIP(source) == "VIPNormal" and ids-1 < 2) or (getPlayerVIP(source) == "VIPPro" and ids-1 < 3 )then
					local money = getPlayerMoney(thePlayer)
					if(money < price) then outputChatBox("No tienes dinero suficiente para comprar la casa te faltan $"..(price-money).."!", thePlayer, 255, 0, 0) return end
					setHouseData(id, "OWNER", AccountName(thePlayer))				
					givePlayerMoney(thePlayer, -price)
					outputChatBox("¡Felicitaciones! ¡Compraste la casa!", thePlayer, 0, 255, 0)
				
		    		destroyElement(houseData[id]["PICKUP"])
					x = houseData[id]["X"]
					y = houseData[id]["Y"]
					z = houseData[id]["Z"]
					houseData[id]["PICKUP"] = createPickup(x, y, z-0.5, 3, 1272, 100)	
				else
					outputChatBox("¡No puedes comprar mas Casas, compra un Vip para poder comprar mas Casas!", thePlayer, 255, 0, 0)			
				end
			else
			outputChatBox("¡No puedes comprar esta casa ya tiene dueño!", thePlayer, 255, 0, 0)			
			end
		end
	end
end)

addCommandHandler("vendercasa", function(thePlayer)
	if envisita[thePlayer] == nil then
		return
	else
		local house = envisita[thePlayer]
		if(house) then
			local id = house
			local owner = houseData[id]["OWNER"]
			if(owner ~= getAccountName( getPlayerAccount(thePlayer))) then
				outputChatBox("¡No puedes vender esta casa!", thePlayer, 255, 0, 0)
			else
				local price = houseData[id]["PRICE"]
				setHouseData(id, "OWNER", "")
				givePlayerMoney(thePlayer, math.floor(price/100*40))
				outputChatBox("Acabas de vender tu casa por $"..math.floor(price/100*40), thePlayer, 0, 255, 0)				
		    	destroyElement(houseData[id]["PICKUP"])
				x = houseData[id]["X"]
				y = houseData[id]["Y"]
				z = houseData[id]["Z"]
				houseData[id]["PICKUP"] = createPickup(x, y, z-0.5, 3, 1273, 100)		
			end
		end
	end
end)


addCommandHandler("borrarcasa", function(thePlayer, cmd, id)
	if permisos[getACLFromPlayer(thePlayer)] == true then
		id = tonumber(id)
		if not(id) then return end
		if not(house[id]) then
			outputChatBox("No existe la casa #"..id.."!", thePlayer, 255, 0, 0)
			return
		end
		local query = databaseDelete("DELETE FROM houses WHERE ID = '"..id.."';")
		if(query) then
			--destroyElement(houseData[id]["BLIP"])
			destroyElement(houseData[id]["PICKUP"])
			destroyElement(houseIntData[id]["PICKUP"])
			houseData[id] = nil
			houseIntData[id] = nil
			destroyElement(house[id])
			destroyElement(houseInt[id])
			outputChatBox("Casa #"..id.." destruída correctamente!", thePlayer, 0, 255, 0)
			house[id] = false
		end
    else
		outputChatBox("¡No se te permite hacer este comando!", thePlayer, 255, 0, 0)
	end
end)




addEvent("crearcasa",true)
addEventHandler("crearcasa",root,function(x, y, z, int, intx, inty, intz, price)
	local query = databaseInsert("INSERT INTO houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, PRICE) values ('"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..price.."');")
	local newid = houseid+1
	if(query) then
		outputChatBox("Casa #"..newid.." creada correctamente!", source, 0, 255, 0)
		buildHouse(newid, x, y, z, int, intx, inty, intz, 0, 0, price, "")
	else
		error("Casa #"..newid.." Error de creacion!")
	end
end)

function buildHouse(id,x,y,z,int,intx, inty, intz,dinero,locked,price,owner)
	if(id) and (x) and(y) and (z) and (int) and (intx) and (inty) and (intz) then
		houseid = id
		house[id] = createColSphere(x, y, z, 1.5)
		houseData[id] = {} 
		local house = house[id] -- I'm too lazy...
		setElementData(house, "house", true)

		local houseIntPickup = createPickup(intx, inty, intz, 3, 1318, 100)
		setElementInterior(houseIntPickup, int)
		setElementDimension(houseIntPickup, id)

		houseInt[id] = createColSphere(intx, inty, intz, 1.5) -- And this is the Exit
		setElementInterior(houseInt[id], int)
		setElementDimension(houseInt[id], id) -- The House Dimension is the house ID
		setElementData(houseInt[id], "house", false)
		--

		houseData[id]["HOUSE"] = house
		houseData[id]["DIM"] = id
		houseData[id]["MONEY"] = dinero
		houseData[id]["INTHOUSE"] = houseInt[id]
		houseData[id]["LOCKED"] = locked
		houseData[id]["PRICE"] = price
		houseData[id]["OWNER"] = owner
		houseData[id]["X"] = x
		houseData[id]["Y"] = y
		houseData[id]["Z"] = z

		local housePickup
		if(owner ~= "") then
			housePickup = createPickup(x, y, z-0.5, 3, 1272, 100)
		else
			housePickup = createPickup(x, y, z-0.5, 3, 1273, 100)
		end

		houseData[id]["PICKUP"] = housePickup
		setElementData(house, "PRICE", price)
		setElementData(house, "OWNER", owner)
		setElementData(house, "LOCKED", locked)
		setElementData(house, "ID", id)

		houseIntData[id] = {}
		houseIntData[id]["OUTHOUSE"] = houseData[id]["HOUSE"]
		houseIntData[id]["INT"] = int
		houseIntData[id]["X"] = intx
		houseIntData[id]["Y"] = inty
		houseIntData[id]["Z"] = intz
		houseIntData[id]["PICKUP"] = houseIntPickup
		outputServerLog("Casa #"..id.." creada correctamente!")

		addEventHandler("onColShapeHit", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				envisita[hitElement] = id
				bindKey(hitElement, "F", "down", togglePlayerInfomenue, id)
				outputChatBox("Presione F para abrir el panel de la casa.", hitElement, 0, 255, 255)
			end
		end)
		
		addEventHandler("onColShapeLeave", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				unbindKey(hitElement, "F", "down", togglePlayerInfomenue, id)
			end
		end)
	else
		error("Casa #"..id.." no se pudo crear")
	end
end

function togglePlayerInfomenue(thePlayer, key, state, id)
	if (id) then
		local locked = houseData[id]["LOCKED"]
		local owner = houseData[id]["OWNER"]
		local price = houseData[id]["PRICE"]
		local x, y, z = getElementPosition(house[id])
		triggerClientEvent(thePlayer, "wincasainfo", thePlayer,owner, x, y, z, price, locked, id)
	end
end

function housesys_startup()
	local query = databaseQuery("SELECT * FROM houses;" )
	for index, row in pairs(query) do
		local id = row['ID']
		local x, y, z = row['X'], row['Y'], row['Z']
		local int, intx, inty, intz = row['INTERIOR'], row['INTX'], row['INTY'], row['INTZ']
		local locked = row['LOCKED'] or 0
		local price = row['PRICE'] or 0
		local owner = row['OWNER'] or ""
		buildHouse(id, x, y, z, int, intx, inty, intz, money,locked, price, owner)
	end
end
addEventHandler("onResourceStart",root,housesys_startup)



function setHouseData(ID, typ, value)
	-- Security array -- 
	houseData[ID][typ] = value
	setElementData(house[ID], typ, value)
	if(saveableValues[typ]) then
		local query = databaseQuery("UPDATE houses SET "..saveableValues[typ].." = '"..value.."' WHERE ID = '"..ID.."';" )
	end
end


local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ, dim)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	setElementFrozen(thePlayer, true)
	fadeP[thePlayer] = 0
	setElementPosition(thePlayer, x, y, z)
	setElementInterior(thePlayer, interior)
	if(dim) then setElementDimension(thePlayer, dim) end
	if not(typ) then
		setElementFrozen(thePlayer, false)
	else
		if(typ == true)  then
			setTimer(setElementFrozen, 100, 1, thePlayer, false)
		end
	end
end

function getLastID(player)
    if isElement( player ) then
        local result = databaseQuery("SELECT * FROM houses WHERE OWNER=?", AccountName(player))
        return (#result or 0) + 1
    end
end


function getPlayerVIP(player)
	if isElement(player) then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPPro" ) ) then
			return "VIPPro"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPNormal" ) ) then
			return "VIPNormal"
		else
			return false
		end
	end
	return false
end

