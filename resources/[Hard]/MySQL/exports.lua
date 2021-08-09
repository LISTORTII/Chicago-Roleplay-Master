addEventHandler("onResourceStart", resourceRoot, function ( )
	database = Connection("sqlite", "Datos.db")
	if database then
		print("Conectado a la base de datos 'Datos.db'")
	else
		print("Error al conectar con la DB")
	end
end);

function query( ... )
	if database then
		local s = database:query(...)
		local result = s:poll(-1)
		return result
	else
		return false
	end
end

function update( ... )
	if database then
		return database:exec(...)
	else
		return false
	end
end

function insert( ... )
	if database then
		return database:exec(...)
	else
		return false
	end
end

function delete( ... )
	if database then
		return database:exec(...)
	else
		return false
	end
end

function AccountName( player )
	local s = player:getAccount()
	local cuenta = s:getName()
	return cuenta
end

function notIsGuest( player )
	local ac = player:getAccount()
	local is = ac:isGuest()
	return is
end

function isPlayerInTeam(player, team)
    assert(isElement(player) and getElementType(player) == "player", "Bad argument 1 @ isPlayerInTeam [player expected, got " .. tostring(player) .. "]")
    assert((not team) or type(team) == "string" or (isElement(team) and getElementType(team) == "team"), "Bad argument 2 @ isPlayerInTeam [nil/string/team expected, got " .. tostring(team) .. "]")
    return getPlayerTeam(player) == (type(team) == "string" and getTeamFromName(team) or (type(team) == "userdata" and team or (getPlayerTeam(player) or true)))
end

function isPlayerInACL(player, acl)
	if isElement(player) and getElementType(player) == "player" and aclGetGroup(acl or "") and not isGuestAccount(getPlayerAccount(player)) then
		local account = getPlayerAccount(player)
		
		return isObjectInACLGroup( "user.".. getAccountName(account), aclGetGroup(acl) )
	end
	return false
end

local staffACLs =
{
    aclGetGroup("Admin"),
    aclGetGroup("Moderador"),
    aclGetGroup("SuperModerador"),
    aclGetGroup("Asesor"),
	aclGetGroup("Sup.Facc"),
	aclGetGroup("Sup.Grupos"),
	aclGetGroup("Sup.Asesor"),
	aclGetGroup("Sup.Staff"),
}

function isPlayerStaff(p)

	if isElement(p) and getElementType(p) == "player" and not isGuestAccount(getPlayerAccount(p)) then
		local object = getAccountName(getPlayerAccount(p))
		
		for _,group in ipairs(staffACLs) do
			if isObjectInACLGroup( "user."..object, group ) then
				return true
			end
		end
	end
	return false
end

function getACLFromPlayer(player)
	if isElement(player) and getElementType(player) == "player" then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
			return "Admin"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) then
			return "SuperMod"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Facc" ) ) then
			return "Sup.Facc"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Grupos" ) ) then
			return "Sup.Grupos"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Asesor" ) ) then
			return "Sup.Asesor"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Staff" ) ) then
			return "Sup.Staff"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then
			return "Mod"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Asesor" ) ) then
			return "Asesor"
		end
	end
	return false
end

function getPlayerLeader( thePlayer, TheFaction )
	if isElement( thePlayer ) and ( thePlayer:getType() == "player" ) then
		if thePlayer:getData("Roleplay:faccion_lider") == "Si" then
			return true
		else
			return false
		end
	end
	return false
end


function getPlayerLeaderDivision( thePlayer, TheFaction )
	if isElement( thePlayer ) and ( thePlayer:getType() == "player" ) then
		if thePlayer:getData("Roleplay:faccion_division_lider") == "Si" then
			return true
		else
			return false
		end
	end
	return false
end



function getPlayerFaction( thePlayer, TheFaction )
	if isElement( thePlayer ) and ( thePlayer:getType() == "player" ) then
		return thePlayer:getData("Roleplay:faccion") == tostring(TheFaction)
	end
	return false
end

function getPlayerDivision( thePlayer, TheFaction )
	if isElement( thePlayer ) and ( thePlayer:getType() == "player" ) then
		return thePlayer:getData("Roleplay:faccion_division") == tostring(TheFaction)
	end
	return false
end

function getACLFromPlayer(player)
	if isElement(player) and getElementType(player) == "player" then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
			return "Admin"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) then
			return "SuperMod"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Facc" ) ) then
			return "Sup.Facc"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Grupos" ) ) then
			return "Sup.Grupos"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Asesor" ) ) then
			return "Sup.Asesor"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Staff" ) ) then
			return "Sup.Staff"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then
			return "Mod"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Asesor" ) ) then
			return "Asesor"
		end
	end
	return false
end


local vehiculos_radios = { [416]=true, [433]=true, [427]=true, [490]=true, [528]=true, [407]=true, [544]=true, [523]=true, [470]=true, [596]=true, [598]=true, [599]=true, [597]=true, [432]=true, [601]=true, [497]=true, [430]=true }


function inPlayerVehiclePolice(p) 
	if isElement(p) and p:getType() == "player" then 
		if p:isInVehicle() then
			local veh = p:getOccupiedVehicle()
			if vehiculos_radios[veh:getModel()] then
				return true
			end
		end
	end
	return false
end

function MensajeRol(player, texto, tip )
	local x, y, z = getElementPosition( player )
	local chatCol = ColShape.Sphere(x, y, z, 5)
	local nearPlayers = chatCol:getElementsWithin("player")
	if tip == 1 then
		for index, v in ipairs(nearPlayers) do
			v:outputChat("* ".._getPlayerNameR(player).." "..(texto or ""), 32, 100, 32, true)
		end
	else
		for index, v in ipairs(nearPlayers) do
			v:outputChat("#FF00D8* ".._getPlayerNameR(player).." "..(texto or ""), 200, 0, 105, true)
		end
	end
	if isElement(chatCol) then
		chatCol:destroy()
	end
end
