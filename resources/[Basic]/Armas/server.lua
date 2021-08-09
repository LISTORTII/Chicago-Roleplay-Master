loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

mysql = exports.MySQL

local Weapons = {}
Weapons.ID = {
	[1] = 331,
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	[9] = 341,
	[16] = 342,
	[17] = 343,
	[18] = 344,
	[22] = 346,
	[23] = 347,
	[24] = 348,
	[25] = 349,
	[26] = 350,
	[27] = 351,
	[28] = 352,
	[29] = 353,
	[32] = 372,
	[30] = 355,
	[31] = 356,
	[33] = 357,
	[34] = 358,
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
	[39] = 363,
	[41] = 365,
	[42] = 366,
	[43] = 367,
}

local antiSpamW  = {} 
addEvent('onGiveWeapon', true)


function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=2,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end

function WastedP( totalAmmo, killer, killerWeapon, bodypart, stealth )
	if not(mysql:notIsGuest(source)) then 
		if source:getData("Roleplay:faccion") ~= "Policia" then
			local weapons = ""
			local x, y, z = getElementPosition(source)
			local int = getElementInterior( source )
			local dim = getElementDimension( source )
			local nick = source:getName()
			for index=0,12 do
				local weapon = source:getWeapon(index)
				local ammo = source:getTotalAmmo(index)
				createWeaponGround(weapon, ammo, x - math.random(0, 2.3), y - math.random(0,2.1), z, int, dim, nick)
			end
			mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", '', mysql:AccountName(source))
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), WastedP)

function update(source)
	guardarma(source)
	local weapons = ""
	for index=0,12 do
		local weapon = source:getWeapon(index)
		local ammo = source:getTotalAmmo(index)
		weapons = weapons..tostring(index).."="..tostring(weapon)..","..tostring(ammo)..";"
	end
		mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", weapons, AccountName(source))
end


function createWeaponGround(wep_id, ammo, x, y, z, int, dim, huellas)
	if wep_id ~= 0 then
		if wep_id >= 22 then
			local ID = Weapons.ID[wep_id]
			z = z - 1
			local weapon = Object(ID, x, y, z)
			local col = ColShape.Sphere(x , y, z +.5,1)
			setElementInterior(weapon, int)
			setElementDimension(weapon, dim)
			weapon:setRotation(86,270,180)
			--
			col:setData('weapon_data',{weapon,wep_id, ammo,col, corona, huellas})

		end
	end
end


function guardarma(ped)
	for i=0, 12 do 
		local v = getPedWeapon( ped, i )
		local muni = getPedTotalAmmo(ped,i)
		if v and v ~= 0 then
			if muni and muni ~= 0 then
				if getPedWeapon( ped, i ) then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
				end	
			end
		end
	end
end

function armaslot(id)
	if id == 30 or id == 31 then
		return 5
	elseif id == 25 then
		return 3
	end
	return false
end

function armas(player,cmd,carga)
	local tick = getTickCount()
	if (antiSpamW[player] and antiSpamW[player][1] and tick - antiSpamW[player][1] < 2000) then
		return
	end
	local wep_id = player:getWeapon()
	local ammo = player:getTotalAmmo()
	if wep_id ~= 0 then
		if ammo > 1 then
			if tonumber(carga) then
				if tonumber(carga) >= 1 and quecarga(wep_id,carga) <= ammo then
					Weapons[player] = Weapons[player] or {}
					local ID = Weapons.ID[wep_id]		
					local pos = player.position
					pos.z = pos.z - 1
					local weapon = Object(ID, pos)
					local col = ColShape.Sphere(pos.x,pos.y,pos.z +.5,1)

					setElementInterior(weapon,getElementInterior( player ))
					setElementDimension(weapon,getElementDimension( player ))

					weapon:setRotation(86,270,180)
					local nick = _getPlayerNameR(player)
					col:setData('weapon_data',{weapon,wep_id, quecarga(wep_id,carga),col, corona, nick})
					if armaslot(wep_id) then
						triggerClientEvent(player,"destruirarma",player,player,armaslot(wep_id))
					end
					takeWeapon(player, wep_id, quecarga(wep_id,carga))
					guardarma(player)
					update(player)
					takeAllWeapons(player)
					backup(player)
				else
					outputChatBox("No tienes suficientes cargadores",player,255,50,50,true)
				end
			else
				outputChatBox("Syntax: /dejar [cargador]",player,255,50,50,true)
			end
		end
	end

	if (not antiSpamW[player]) then
		antiSpamW[player] = {}
	end
	antiSpamW[player][1] = getTickCount()
end
addCommandHandler("dejar",armas)
addCommandHandler("soltar",armas)


local listamr = {
{30,30},
{22,17},
{24,7},
{31,30},
{28,35},
{32,30},
{25,1},
}

function quecarga(id,carga)
	for i,v in ipairs(listamr) do
		if v[1] == id then
			local car = v[2] * carga
			return car
		end
	end
end


local antiSpamW  = {} 

function dararma(source,cmd,who,carga)
	if (source) then
		local player = exports["Gamemode"]:getFromName( source, who )
		if (player) then
			local tick = getTickCount()
			if (antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 2000) then
				return
			end
			local x, y, z = getElementPosition(source)
			if getDistanceBetweenPoints3D( x, y, z, unpack( { getElementPosition( player ) } ) ) < 5 and getElementDimension( player ) == getElementDimension( source ) and getElementInterior(player) == getElementInterior(source) then
				if player ~= source then
					local a = getPlayerName(source)
					local wep_id = source:getWeapon()
					if wep_id ~= 0 then
						if tonumber(carga) then
						 	local total = getPedTotalAmmo(source)
							Weapons[player] = Weapons[source] or {}
							local ID = Weapons.ID[wep_id]
							if tonumber(carga) >= 1 and quecarga(wep_id,carga) <= total  then 
								if armaslot(wep_id) then
									triggerClientEvent(source,"destruirarma",source,source,armaslot(wep_id))
								end
								giveWeapon(player, wep_id, quecarga(wep_id,carga), true )
								takeWeapon(source, wep_id, quecarga(wep_id,carga))
								outputDebugString("El jugador ".._getPlayerNameR(source).." le dio un arma a ".._getPlayerNameR(player).." con "..quecarga(wep_id,carga).." balas", 0, 165, 242, 255)
								outputChatBox("#FA0707Le has dado un arma a #FFFFFF".._getPlayerNameR(player).."#FA0707 con #FFFFFF"..quecarga(wep_id,carga).." #FA0707 balas",source,255,255,255,true)
								outputChatBox("#26F716El jugador #FFFFFF".._getPlayerNameR(source).." #26F716te ha dado un arma con #FFFFFF"..quecarga(wep_id,carga).."#26F716 balas",player,255,255,255,true)
								guardarma(source)
								update(source)
								takeAllWeapons(source)
								backup(source)
							else
								outputChatBox("#FA0707No tienes suficientes balas solo tienes #FFFFFF"..total.."#FA0707 balas",player,255,255,255,true)
							end
						end
					if (not antiSpamW[source]) then
						antiSpamW[source] = {}
					end
					antiSpamW[source][1] = getTickCount()
					end
				end
			end
		end
	end	
end

addCommandHandler("dararma",dararma)

function darchaleco(source,cmd,who,ammo)
	if (source) then
	local player = getPlayerFromName(who)
	if (player) then
		local tick = getTickCount()
		if (antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 10000) then
			return
		end
		if player ~= source then
		local a = getPlayerName(source)
		local x, y, z = getElementPosition(source)
		if tonumber(ammo) then
			local total = getPedArmor(source)
			local total1 = getPedArmor(player)
				if tonumber(ammo) >= 1 and tonumber(total) >= tonumber(ammo) then 
						local aa = total1 + ammo
						source:setArmor(-ammo)
						player:setArmor(aa)
						outputDebugString("El jugador ".._getPlayerNameR(source).." le dio un chaleco a ".._getPlayerNameR(player).." con "..ammo.." de chaleco", 0, 165, 242, 255)
						outputChatBox("#FA0707Le has dado un chaleco a #FFFFFF".._getPlayerNameR(player).."#FA0707 con #FFFFFF"..ammo.." #FA0707 de chaleco",source,255,255,255,true)
						outputChatBox("#26F716El jugador #FFFFFF".._getPlayerNameR(source).." #26F716te ha dado un chaleco con #FFFFFF"..ammo.."#26F716 de chaleco",player,255,255,255,true)
					else
						outputChatBox("#FA0707No tienes suficiente de chaleco solo tienes #FFFFFF"..total.."#FA0707 de chaleco",player,255,255,255,true)

				end
			end
		end
		if (not antiSpamW[source]) then
			antiSpamW[source] = {}
		end
		antiSpamW[source][1] = getTickCount()
		end	
	end	
end

addCommandHandler("darchaleco",darchaleco)
--dañoarmas


local armasda = {
	{22,50},
	{31,76},
	{30,80},
	{29,50},
	{24,100},
	{32,50},
	{28,50},
}

addEventHandler("onResourceStart", root, function()
	for i,v in ipairs(armasda) do
		for _,skill in ipairs( { "poor", "std", "pro" } ) do

		setWeaponProperty(v[1], skill,"damage",v[2])

		setWeaponProperty(22, skill,"accuracy",1.5) 
		--
		setWeaponProperty(28, skill,"accuracy",1.5) 
		setWeaponProperty(28, skill, "maximum_clip_ammo", 35)
		setWeaponProperty(28, skill, "weapon_range",45)
		--
		setWeaponProperty(32, skill, "maximum_clip_ammo", 30)
		setWeaponProperty(32, skill,"accuracy",1.2) 
		setWeaponProperty(32, skill, "weapon_range",42)
		--
		setWeaponProperty(31, skill, "accuracy",1.2) 
		setWeaponProperty(31, skill, "maximum_clip_ammo", 30)
		setWeaponProperty(31, skill, "weapon_range",100)
		--
		setWeaponProperty(30, skill, "weapon_range",100)
		setWeaponProperty(30, skill, "accuracy",0.8) 
		--
		setWeaponProperty(24, skill,"weapon_range",90)
		setWeaponProperty(24, skill,"accuracy",0.7) 
		end
	end
end)


addCommandHandler("huellas", function(p)
	if not notIsGuest( p ) then
		if getPlayerDivision(p, "S.W.A.T.") or getPlayerDivision(p, "INTELIGENCIA") then
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			for i, v in ipairs(Element.getAllByType("colshape")) do
				if v:getData("weapon_data") then
					if isElementInRange(v, x, y, z, 2) then
						p:outputChat("* Esta arma tiene las huellas de "..v:getData("weapon_data")[6].."", 150, 50, 50, true)
					end
				end
			end
		end
	end
end)

function isElementInRange(ele, x, y, z, range)
   if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
      return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.
   end
   return false
end

addEventHandler('onGiveWeapon', root,
	function(t)
		client:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)
		--
		setTimer(function(client)
			setPedAnimation(client)
		end, 500, 1, client)
		giveWeapon(client, t[2], t[3], true )
		if isElement(t[4]) then
			t[4]:destroy()
		end
		if isElement(t[5]) then
			t[5]:destroy()
		end
		if isElement(t[1]) then
			t[1]:destroy()
		end
	end
)
addEventHandler("onPlayerQuit",root,function(t)

	if isElement(t[4]) then
			t[4]:destroy()
		end
		if isElement(t[5]) then
			t[5]:destroy()
		end
		if isElement(t[1]) then
			t[1]:destroy()
		end
	end
)




function backup(source)

	if not(mysql:notIsGuest(source)) then 

		local cuenta = mysql:AccountName(source)

		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")

		if not ( type ( save ) == "table" and #save == 0 ) or not save then

			local weapons = save[1]["Weapons"]

			if weapons and type(weapons) == "string" and string.len(weapons) > 0 then

				for index=0,12 do

					local coded_string = string.match(weapons, tostring(index).."=%d+,%d+")

					if coded_string then

						local weapon_start , weapon_end = string.find(coded_string, tostring(index).."=")

						local ammo_start, ammo_end = string.find(coded_string, tostring(index).."=%d+,")

						local decoded_weapon = string.match(coded_string, "%d+", weapon_end)

						local decoded_ammo = string.match(coded_string, "%d+", ammo_end)

						local wep = tonumber(decoded_weapon)

						local ammu = tonumber(decoded_ammo)

						if wep ~= 0 then

							if ammu > 1 then

								giveWeapon(source, wep, ammu)

							end
						end
					else
						print("ERROR: Imposible recobrar arma en Slot: ".. tostring(index).."")
					end
				end
			end
		end
	end
end


addEventHandler ("onPlayerWeaponFire", root, 
   function (weapons)
   	     if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Everyone" ) ) then 
         if not (getElementData(source, "Fire")) then
		 setElementData(source, "Fire", true)
		 x,y,z = getElementPosition(source)
		 local weaponName = getWeaponNameFromID(weapons)
		 local localidade = getZoneName(x, y, z)
		 if (weaponName == "Silenced") then
		     local weaponName = "Teaser"
		 end
		 outputChatBox("#cd3737[ENTORNO]: #ffffffCuidado hay disparos en "..localidade.."",root,255,255,255,true)	
		 setTimer(setElementData, 25000, 1, source, "Fire", false)
		 end
   end 
end
)


function addRednessOnDamage ( )
      fadeCamera ( source, false, 1.0, 255, 0, 0 )        
      setTimer ( fadeCameraDelayed, 500, 1, source )   
end
addEventHandler ( "onPlayerDamage", root, addRednessOnDamage )
 
function fadeCameraDelayed(player)
      if (isElement(player)) then
            fadeCamera(player, true, 0.5)
      end
end