skinsTable = {}

skinsTable.all = {}

skinsTable.categories = {}

shops = {

	--x, y, z, dimension, interior

	{ x = 207.60717773438, y = -100.33073425293, z = 1004.2578125, dim = 0, int = 15},

	{ x = 161.3233795166, y = -83.255378723145, z = 1000.8046875, dim = 0, int = 18},

	{ x = 207.02481079102, y = -129.17749023438, z = 1002.5078125, dim = 0, int = 3},

	{ x = 204.39889526367, y = -159.35827636719, z = 999.5234375, dim = 0, int = 14},

	{ x = 206.37413024902, y = -8.2102794647217, z = 1000.2109375, dim = 0, int = 5},

	{ x = 207.55685424805, y = -100.3268737793, z = 1004.2578125, dim = 1, int = 15},

	{ x = 161.33987426758, y = -83.251647949219, z = 1000.8046875, dim = 1, int = 18},

	{ x = 206.37982177734, y = -8.0149660110474, z = 1000.2109375, dim = 1, int = 5},

	{ x = 207.58236694336, y = -100.33797454834, z = 1004.2578125, dim = 2, int = 15},

	{ x = 161.47146606445, y = -83.262077331543, z = 1000.8046875, dim = 2, int = 18},

	{ x = 161.37335205078, y = -83.253326416016, z = 1000.8046875, dim = 3, int = 18},

	{ x = 207.55435180664, y = -100.32672119141, z = 1004.2578125, dim = 3, int = 15},

	{ x = 206.95558166504, y = -129.18096923828, z = 1002.5078125, dim = 1, int = 3},

	{ x = 206.37959289551, y = -7.8779788017273, z = 1000.2109375, dim = 2, int = 5},

}






function loadSkins()

	local xml = xmlLoadFile("files/skins.xml")

	for index, category in pairs(xmlNodeGetChildren(xml)) do

		local cName = xmlNodeGetAttribute(category, "name")

		skinsTable.categories[cName] = {}

		for index, skin in pairs(xmlNodeGetChildren(category)) do

			local id, name = xmlNodeGetAttribute(skin, "model"), xmlNodeGetAttribute(skin, "name")

			skinsTable.categories[cName][id] = name

			skinsTable.all[id] = name

		end

	end

	xmlUnloadFile(xml)

end

addEventHandler("onResourceStart", resourceRoot, loadSkins)



function getSkinsTable(category)

	if not category then

		return  skinsTable.categories or false

	elseif category == "all" then

		return skinsTable.all or false

	else

		return skinsTable[category] or false

	end

	return false

end



function createSkinShops()

	for index, shop in pairs(shops) do

		local x, y, z, int, dim = shop.x, shop.y, shop.z, shop.int, shop.dim

		marker = createMarker(x, y, z, "cylinder", 1.5, 255, 255, 0, 170)

		setElementInterior(marker, int)

		setElementDimension(marker, dim)

		setElementAlpha( marker, 0 )

		addEventHandler("onMarkerHit", marker, enteredShop)

	end



	for i, v in ipairs( peds ) do

		local dataDim, dataInt = shops[i].dim, shops[i].int



		local x,y,z = v[1], v[2], v[3]

		local rot = v[4]



		local skin = {169, 223}

		local random = skin[math.random(1,2)]

		local ped = createPed( random, x, y, z, rot )

		setElementDimension( ped, dataDim )

		setElementInterior( ped, dataInt )

	end

end

addEventHandler("onResourceStart", resourceRoot, createSkinShops)



function enteredShop(player, matchingDim)

	if (player and getElementType(player) == "player" and matchingDim) then

		local skins = getSkinsTable()

		triggerClientEvent(player, "clothes.showSkin", player, skins)

		triggerClientEvent(player, "clothes.showSkin", player, skins)

	end

end



function buySkin(model)

	if (getPlayerMoney(client) >= 100) then

		takePlayerMoney(client, 100)

		outputChatBox("Has comprado una skin correctamente!", client, 0, 255, 0)

		setAccountData(getPlayerAccount(client), "clothes.boughtSkin", model)

		setElementModel(client, model)

	end

end

addEvent("clothes.buySkin", true)

addEventHandler("clothes.buySkin", root, buySkin)



function getBoughtSkin(player)

	if (not isElement(player)) then return end

	return tonumber(getAccountData(getPlayerAccount(player), "clothes.boughtSkin")) or 0

end

--[[

function goToSkin( player, _, number )

	if tonumber(number) then

		local number = tonumber( number )

		if number <= #shops then

			local data = shops[number]



			setElementPosition( player, data.x, data.y, data.z )

			setElementDimension( player, data.dim )

			setElementInterior( player, data.int )

		end

	end

end

addCommandHandler( "goto", goToSkin )

]]--