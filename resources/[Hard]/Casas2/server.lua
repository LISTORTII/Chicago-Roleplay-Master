loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local houseid = 0 
local house = {}
local houseData = {}
local houseInt = {}
local houseIntData = {}
local envisita = {}
local envisitain = {}
local fadeP = {}

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
	["PASS"] = "PASS",
	["PRICE"] = "PRICE",
	["OWNER"] = "OWNER",
}


addCommandHandler("crearcasa",function(player)
	if getACLFromPlayer(player) == "Administrador" then
		triggerClientEvent(player,"vercasa",player)
	end
end)

addCommandHandler("entrar", function(thePlayer)
	if envisita[thePlayer] ~= nil then
		local id = tonumber(envisita[thePlayer])
		local locked = houseData[id]["LOCKED"] or false
		if ( locked == 0) then
			local int, intx, inty, intz, dim = houseIntData[id]["INT"], houseIntData[id]["X"], houseIntData[id]["Y"], houseIntData[id]["Z"], id
			setInPosition(thePlayer, intx, inty, intz, int, false, dim)
			envisitain[thePlayer] = id
		else
			thePlayer:outputChat("¡Casa cerrada! No se le permite entrar!",255, 50, 50,true)
		end
	end
end)

addCommandHandler("salir", function(thePlayer)
	if envisitain[thePlayer] ~= nil then
		local id = tonumber(envisitain[thePlayer])
		local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
		envisitain[thePlayer] = false
		setInPosition(thePlayer, x, y, z, 0, false, 0)
	end
end)


addCommandHandler("comprarcasa", function(thePlayer)
	if envisita[thePlayer] ~= nil then
		local id = envisita[thePlayer]
		local owner = houseData[id]["OWNER"]
		local pick = houseData[id]["PICKUP"]
		local price = houseData[id]["PRICE"]
		if owner == "" then
			local id2 = getLastID(thePlayer)
			if (not getPlayerVIP(source) and id2-1 < 1) or (getPlayerVIP(source) == "VIPNormal" and id2-1 < 2) or (getPlayerVIP(source) == "VIPPro" and id2-1 < 3 ) then
				if tonumber(thePlayer:getMoney() >= price) then
					setHouseData(id, "OWNER", AccountName(thePlayer))				
					thePlayer:giveMoney(- price)
					thePlayer:outputChat("¡Felicitaciones! ¡Compraste la casa!", 50, 255, 50,true)
		    		houseData[id]["PICKUP"]:destroy()

					x = houseData[id]["X"]
					y = houseData[id]["Y"]
					z = houseData[id]["Z"]
					houseData[id]["PICKUP"] = Pickup(x, y, z-0.2, 3, 1272, 100)	
				else
					thePlayer:outputChat("[ERROR] No tienes dinero suficiente para comprar la casa te faltan $"..(price - thePlayer:getMoney()), 255, 50, 50,true)
				end
			else
				thePlayer:outputChat("[ERROR] No puedes comprar mas Casas, compra un Vip para poder comprar mas Casas", 255, 50, 50,true)			
			end
		else
			thePlayer:outputChat("[ERROR] Esta casa ya tiene dueño", 255, 50, 50,true)			
		end
	end
end)


addCommandHandler("vendercasa", function(thePlayer)
	if envisita[thePlayer] ~= nil then
		local id = envisita[thePlayer]
		local owner = houseData[id]["OWNER"]
		if owner == AccountName(thePlayer) then
			local price = houseData[id]["PRICE"]
			setHouseData(id, "OWNER", "")
			thePlayer:giveMoney(math.floor(price*40/100))
			thePlayer:outputChat("Acabas de vender tu casa por #00ee00$"..math.floor(price*40/100), 255, 255, 255,true)				
	    	houseData[id]["PICKUP"]:destroy()
			x = houseData[id]["X"]
			y = houseData[id]["Y"]
			z = houseData[id]["Z"]
			houseData[id]["PICKUP"] = Pickup(x, y, z-0.5, 3, 1273, 100)		
		else
			thePlayer:outputChat("[ERROR] No eres el dueño de esta casa", 255, 255, 255,true)
		end
	end
end)


addCommandHandler("borrarcasa", function(thePlayer, cmd, id)
	if getACLFromPlayer(thePlayer) == "Administrador" then
		local id = tonumber(id)
		if id then
			if house[id] ~= nil then
				local query = databaseDelete("DELETE FROM houses WHERE ID = '"..id.."';")
				if(query) then
					--destroyElement(houseData[id]["BLIP"])
					houseData[id]["PICKUP"]:destroy()
					houseIntData[id]["PICKUP"]:destroy()
					houseData[id] = nil
					houseIntData[id] = nil
					house[id]:destroy()
					houseInt[id]:destroy()
					thePlayer:outputChat("Casa #ee0000#"..id.." #FFFFFFdestruída correctamente!",255, 255, 255,true)
					house[id] = false
				end
			else
				thePlayer:outputChat("[ERROR] No existe la casa #"..id,255, 50, 50,true)
			end
		end
	end
end)

--Funciones Y Eventos

addEvent("crearcasa",true)
addEventHandler("crearcasa",root,function(x, y, z, int, intx, inty, intz, price)
	local query = databaseInsert("INSERT INTO houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, PRICE) values ('"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..price.."');")
	local newid = houseid + 1
	if(query) then
		source:outputChat("Casa #ee0000#"..newid.." #FFFFFFcreada correctamente!",255, 255, 255,true)
		buildHouse(newid, x, y, z, int, intx, inty, intz, 0, 0,0, price, "")
	else
		error("Casa #"..newid.." Error de creacion!")
	end
end)


function buildHouse(id,x,y,z,int,intx, inty, intz,dinero,locked,pass,price,owner)
	if(id) and (x) and(y) and (z) and (int) and (intx) and (inty) and (intz) then

		houseid = id
		house[id] = createColSphere(x, y, z, 1.5)
		houseData[id] = {} 
		house[id]:setData("house", true)

		local houseIntPickup = Pickup(intx, inty, intz, 3, 1318, 100)
		houseIntPickup:setInterior(int)
		houseIntPickup:setDimension(id)

		houseInt[id] = createColSphere(intx, inty, intz, 1.5)
		houseInt[id]:setInterior(int)
		houseInt[id]:setDimension(id)
		houseInt[id]:setData("house", false)
		--
		houseData[id]["HOUSE"] = house[id]
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
			housePickup = createPickup(x, y, z-0.2, 3, 1272, 100)
		else
			housePickup = createPickup(x, y, z-0.2, 3, 1273, 100)
		end

		houseData[id]["PICKUP"] = housePickup
		house[id]:setData("PRICE", price)
		house[id]:setData("OWNER", owner)
		house[id]:setData("LOCKED", locked)
		house[id]:setData("ID", id)

		houseIntData[id] = {}
		houseIntData[id]["OUTHOUSE"] = houseData[id]["HOUSE"]
		houseIntData[id]["INT"] = int
		houseIntData[id]["X"] = intx
		houseIntData[id]["Y"] = inty
		houseIntData[id]["Z"] = intz
		houseIntData[id]["PICKUP"] = houseIntPickup
		outputServerLog("Casa #"..id.." creada correctamente!")

		addEventHandler("onColShapeHit", house[id], function(hitElement)
			if(getElementType(hitElement) == "player") then
				envisita[hitElement] = id
				bindKey(hitElement, "G", "down", infohouse, id)
				hitElement:outputChat("Presione #ee0000G #FFFFFFpara abrir el panel de la casa.",255, 255, 255,true)
			end
		end)

		addEventHandler("onColShapeHit", houseInt[id], function(hitElement)
			if(getElementType(hitElement) == "player") then
				envisitain[hitElement] = id
			end
		end)

		addEventHandler("onColShapeLeave", house[id], function(hitElement)
			if(getElementType(hitElement) == "player") then
				unbindKey(hitElement, "G", "down", infohouse, id)
				envisita[hitElement] = nil
			end
		end)
	else
		error("Casa #"..id.." no se pudo crear")
	end
end


function infohouse(thePlayer, key, state, id)
	if (id) then
		local locked = houseData[id]["LOCKED"]
		local owner = houseData[id]["OWNER"]
		local price = houseData[id]["PRICE"]
		local x, y, z = house[id]:getPosition()
		triggerClientEvent(thePlayer, "wincasainfo", thePlayer,owner, x, y, z, price, locked, id)
	end
end

addEventHandler("onResourceStart",root,function()
	local query = databaseQuery("SELECT * FROM houses;" )
	for index, row in pairs(query) do
		local id = row['ID']
		local x, y, z = row['X'], row['Y'], row['Z']
		local int, intx, inty, intz = row['INTERIOR'], row['INTX'], row['INTY'], row['INTZ']
		local locked = row['LOCKED'] or 0
		local price = row['PRICE'] or 0
		local pass = row['PASS'] or 0
		local owner = row['OWNER'] or ""
		buildHouse(id, x, y, z, int, intx, inty, intz, money, locked, pass, price, owner)
	end
end)


function setHouseData(ID, typ, value)
	houseData[ID][typ] = value
	house[ID]:setData(typ, value)
	if(saveableValues[typ]) then
		local query = databaseQuery("UPDATE houses SET "..saveableValues[typ].." = '"..value.."' WHERE ID = '"..ID.."';" )
	end
end


function setInPosition(thePlayer, x, y, z, int, typ, dim)
	if not thePlayer:isInVehicle() then 
		if fadeP[thePlayer] == true then return end
			fadeP[thePlayer] = true
			thePlayer:setFrozen(true)
			fadeP[thePlayer] = false
			thePlayer:setPosition(x, y, z)
			thePlayer:setInterior(int)
			thePlayer:setDimension(dim)
			if not(typ) then
				thePlayer:setFrozen(false)
			else
			if(typ == true)  then
				setTimer(setElementFrozen, 100, 1, thePlayer, false)
			end
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

