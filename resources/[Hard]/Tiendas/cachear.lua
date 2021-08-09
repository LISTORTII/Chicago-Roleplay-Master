
local playerWeapo = false

function getPedWeapons(ped)
	for i=0, 12 do 
		if getPedWeapon( ped, i ) then
				local v = getPedWeapon( ped, i )
				local muni = getPedTotalAmmo(ped,i)
			if v and v ~= 0 then
				if muni and muni ~= 0 then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
					playerWeapo = true	
				end	
			end 
		end
	end
	if playerWeapo == true then
		playerWeapo = nil
		return true
	else
		return false
	end
end

addCommandHandler( "cachear",
	function( p, cmd, otro )
			local other = exports["Gamemode"]:getFromName( p, otro )
			if other then
				local x, y, z = getElementPosition(p)
				if getDistanceBetweenPoints3D( x, y, z, unpack( { getElementPosition( other ) } ) ) < 5 and getElementDimension( other ) == getElementDimension( p ) and getElementInterior(other) == getElementInterior(p) then
					local Dinero = getPlayerMoney ( other ) 					
					MensajeRol(p,"Empieza a palpar por el cuerpo de ".._getPlayerNameR(other),1)
					outputChatBox( "#FFFFFF* #0080FFDinero y Armas que hayas podido palpar:", p, 255, 255, 255,true )
                    outputChatBox ( "#0080FF* #FFFFFFDinero#0080FF:#00FF00 "..Dinero, p, 255, 255, 255,true )		
					triggerClientEvent(p, 'Open:Inventory', p, getPlayerItems(other))
					if getPedWeapons( other ) == true then
						outputChatBox( "#0080FF* #FFFFFFArmas: ", p, 255, 255, 0,true )
						for i=0, 12 do 
							local v = getPedWeapon( other, i )
							local muni = getPedTotalAmmo(other,i)
							if v and v ~= 0 then
								if muni and muni ~= 0 then
									if getPedWeapon( other, i ) then
										takeWeapon( other, v )
										giveWeapon( other, v , muni )
										playerWeapo = nil
										outputChatBox( "#0080FF- #00FF00"..getWeaponNameFromID( v ).." | [#FFFFFF"..muni.."#00FF00]", p, 255, 255, 0,true )
									end
								end
							end
						end
					else
						outputChatBox( "- No has palpado ningun arma.", p, 255, 255, 0  )
					end
				end
			end
	end
)

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
