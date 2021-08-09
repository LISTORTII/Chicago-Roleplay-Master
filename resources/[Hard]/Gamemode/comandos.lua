local antiSpamPagarDinero  = {} 

addCommandHandler("setdni",function(source,cmd,nacionalidad,edad,sexo,nombre,serial)
	insert("insert into `datos_personajes` VALUES (?,?,?,?,?,?)", nacionalidad, edad, sexo, 0, nombre,serial)
end)



function pagar_jugador (source, cmd, jugador, monto )
	if not notIsGuest(source) then
		local tick = getTickCount()
		if (antiSpamPagarDinero[source] and antiSpamPagarDinero[source][1] and tick - antiSpamPagarDinero[source][1] < 5000) then
			source:outputChat("No puedes usar este comando después de 5 segundos", 150, 0, 0)
			return
		end
		local player = getFromName( source, jugador )
		if (player) then
			local x, y, z = getElementPosition(source)
			if getDistanceBetweenPoints3D(x,y,z,unpack({getElementPosition(player)})) < 5 and getElementDimension(player) == getElementDimension(source) and getElementInterior(player) == getElementInterior(source) then
				if player ~= source then
					monto = math.floor(monto)
					if tonumber(monto) >= 1 and tonumber(monto) <= source:getMoney() then
						local money = source:getMoney()
						if tonumber(money) >= tonumber(monto) then
							--
							source:outputChat("Le entregaste #329632$"..convertNumber(monto).." dolares #FFFFFFa #FF9000".._getPlayerNameR(player), 255, 255, 255, true)
							player:outputChat("Recibiste #329632$"..convertNumber(monto).." dolares #FFFFFF de parte de #FF9000".._getPlayerNameR(source), 255, 255, 255, true)
							--
							player:giveMoney((monto))
							source:takeMoney((monto))
						else
							source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)
						end
					else
						source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)
					end
				end
			else
				source:outputChat("[ERROR] No estas suficientemente serca de la otra persona", 255, 50, 50, true)
			end
			if (not antiSpamPagarDinero[source]) then
				antiSpamPagarDinero[source] = {}
			end
			antiSpamPagarDinero[source][1] = getTickCount()
		end
	end
end
addCommandHandler({"dardinero", "pagar"}, pagar_jugador)


local caminatas = {
["Hombre"] = {"Hombre", 118},
["Mujer"] = {"Mujer", 129},
["Mujer2"] = {"Mujer2", 131},
["Mujer3"] = {"Mujer3", 132},
["Borracho"] = {"Borracho", 126},
["Prostituta"] = {"Prostituta", 133},
["Gang"] = {"Gang", 121},
["Gang2"] = {"Gang2", 122},
["Gordo"] = {"Gordo", 55},
["Viejo"] = {"Viejo", 120},
}
addCommandHandler({"caminar", "walk", "caminata"}, function(p, cmd, ...)
	if not notIsGuest(p) then
		local walk = table.concat({...}, " ")
		if walk ~="" and walk ~=" " then
			local s = trunklateText( p, walk )
			if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or s:find("Gang2") or s:find("gang2") or s:find("Gordo") or s:find("Mujer2") or s:find("Mujer3") or s:find("Viejo") then
				p:outputChat("Estilo de caminar: #FF0033"..tostring(caminatas[s][1]), 30, 150, 30, true)
				p:setWalkingStyle(caminatas[s][2])
			else
				p:outputChat("Solamente puedes poner estos estilos: ", 255, 100, 100, true)
				for i, v in pairs(caminatas) do
					p:outputChat("#FF9000"..caminatas[i][1], 60, 30, 100, true)
				end
			end
		else 
			p:outputChat("Syntax: /caminar [texto]", 255, 50, 50, true)

		end
	end
end)

addEventHandler("onPlayerLogin",getRootElement(),function()
	source:setWalkingStyle(118)
	source:setData("Agua",100)
	source:setData("Comida",100)
end)

local antiSpamChat  = {} 
function limpiar_chat( source )
	local tick = getTickCount()
	if (antiSpamChat[source] and antiSpamChat[source][1] and tick - antiSpamChat[source][1] < 2000) then
		return
	end
	clearChatBox(source)
	if (not antiSpamChat[source]) then
		antiSpamChat[source] = {}
	end
	antiSpamChat[source][1] = getTickCount()
end
addCommandHandler({"cc", "limpiarchat", "chatlimpio"}, limpiar_chat)

local MP = {}
local antiSpamPM = {}
local vermps = {}

function mensaje(sourcePlayer, command, who, ...)
	if not notIsGuest(sourcePlayer) then
		local targetPlayer = getFromName( sourcePlayer, who )
		if ( targetPlayer ) then 
			if targetPlayer ~= sourcePlayer then
				if MP[targetPlayer] == nil then
					local msg = table.concat({...}, " ")
					if msg ~= "" and msg ~= " " then
					local tick = getTickCount()
						if (antiSpamPM[sourcePlayer] and antiSpamPM[sourcePlayer][1] and tick - antiSpamPM[sourcePlayer][1] < 2000) then
							return
						end
						if MP[sourcePlayer] == true then
							sourcePlayer:outputChat("#FF0033[ADVERTENCIA] #FFFFFFTienes los mensajes desahabilitados, activalos para que te pueda responder.", 255, 255, 255, true)
						end
						sourcePlayer:outputChat("#FFFFFF[#F26E03MP#FFFFFF]#14F019 => ".._getPlayerNameR(targetPlayer)..": #FFFFFF".. msg.."", 203, 129, 0, true)
						targetPlayer:outputChat("#FFFFFF[#F26E03MP#FFFFFF]#F02F34 <= ".. _getPlayerNameR(sourcePlayer)..": #FFFFFF".. msg.."", 203, 129, 0, true)					
						outputDebugString("".. _getPlayerNameR(sourcePlayer).." > ".. _getPlayerNameR(targetPlayer)..": ".. msg.."", 0, 111, 183, 255)
						for i, v in ipairs(getElementsByType("player")) do
							if vermps[v] == true then
								if v ~= targetPlayer and v ~= sourcePlayer then
									v:outputChat("#14F019".. _getPlayerNameR(sourcePlayer).." > #F02F34".. _getPlayerNameR(targetPlayer)..": #FFFFFF".. msg.."",255,255,255,true)
								end
							end
						end
					end
					if (not antiSpamPM[sourcePlayer]) then
						antiSpamPM[sourcePlayer] = {}
					end
					antiSpamPM[sourcePlayer][1] = getTickCount()
				else 
					sourcePlayer:outputChat("* El jugador ".._getPlayerNameR(targetPlayer).." tiene desahabilitado los mensajes", 150, 50, 50, true)
				end
			else 
				sourcePlayer:outputChat("[#F26E03MP#FFFFFF] #F26E03>>#FFFFFF No tienes amigos para enviar mps? #F26E03<<",255,255,255,true)
			end
		else
			sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)
		end
	end
end
addCommandHandler({"mp", "mensaje", "pm"}, mensaje)

addCommandHandler("vermp",function(player)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperMod" ) ) then
		if vermps[player] == nil then
			vermps[player] = true
			player:outputChat("Ahora puedes ver los mps",0,255,0,true)
		else
			player:outputChat("Ya no puedes ver los mps",255,0,0,true)
			vermps[player] = nil
		end
	end
end)


addEventHandler("onPlayerQuit", getRootElement(), function()
	if MP[source] == true then
		MP[source] = nil
	end
end)

function no_mp( player )
	if not notIsGuest( player ) then
		if MP[player] == true then
			MP[player] = nil--
			player:outputChat("Los mensajes mediante MP han sido #00FF00Activados.", 255, 255, 255, true)
		else
			MP[player] = true
			player:outputChat("Los mensajes mediante MP han sido #FF0033Desactivados.", 255, 255, 255, true)
		end
	end
end
addCommandHandler("nomp", no_mp)

local antiSpamIdioma = {}
addCommandHandler({"idioma", "lenguaje"}, function(p, cmd, ...)
	if not notIsGuest(p) then
		local tick = getTickCount()
		if (antiSpamIdioma[p] and antiSpamIdioma[p][1] and tick - antiSpamIdioma[p][1] < 2000) then
			return
		end
		local id = table.concat({...}, " ")
		if id ~="" and id ~=" " then
			local tick = getTickCount()
			local s = trunklateText( p, id )
			p:outputChat("Acabas de cambiar el idioma a:#F26E03 "..s, 255, 255, 255, true)
			p:setData("Roleplay:Idioma", s)
		else
			p:outputChat("#F26E03Syntax: /idioma [idioma]", 255, 100, 100, true)
			p:outputChat("Recuerda no poner idiomas que cause anti rol o serás sancionado.", 255, 100, 100, true)
		end
		if (not antiSpamIdioma[p]) then
			antiSpamIdioma[p] = {}
		end
		antiSpamIdioma[p][1] = getTickCount()
	end
end)

function aiudaa(source,cmd,ayuda)
	if not notIsGuest( source ) then
		if ayuda == "comandos" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#F26E03/duda /payuda /bug /bugeado /staffs",150,150,150,true)
			source:outputChat("#F26E03/caminar /dardinero /pagar /agenda /info /anti-lag",150,150,150,true)
			source:outputChat("#F26E03/idioma /caminar /limpiarchat /cc /stats /tengolag",150,150,150,true)
			source:outputChat("#F26E03/dni /darlicencia /anim /graffiti /dejar [cargador]",150,150,150,true)
			source:outputChat("#F26E03/llamar /colgar /contestar /fixcamera",150,150,150,true)
		elseif ayuda == "facciones" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#F26E03Facciones actuales:",180,180,180,true)
			source:outputChat("#F26E03CHPD - CHFD - CHMW - CHMED",180,180,180,true)
			source:outputChat("#F26E03/contratar /aceptarcontrato /despedir",150,150,150,true)
			source:outputChat("#F26E03/subirrango /bajarrango /miembros",150,150,150,true)
		elseif ayuda == "casas" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#F26E03/comprarcasa /vendercasa /infocasa",200,200,200,true)
			source:outputChat("#F26E03/rentar /unrentar /entrar /salir",200,200,200,true)
		elseif ayuda == "vehiculos" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#F26E03/abrirveh /cerrarveh /localizarveh /venderveh",200,200,200,true)
			source:outputChat("#F26E03/maletero /luces /candado /metermaletero /vermaletero",190,190,190,true)
			source:outputChat("#F26E03/cinturon /vehiculos /estadoveh /comprarveh",190,190,190,true)
		elseif ayuda == "chat" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#F26E03/yo /veryo /guardaryo /g /me /do /b ",200,200,200,true)
			source:outputChat("#F26E03/nomp /mp /s /empezar",190,190,190,true)
		else
			source:outputChat(" ",200,50,50)
			source:outputChat("Syntax: /ayuda < >",228, 207, 31,true)
			source:outputChat("#F26E03/ayuda comandos - /ayuda facciones ",200,50,50,true)
			source:outputChat("#F26E03/ayuda vehiculos - /ayuda chat /ayuda casas",200,50,50,true)--/ayuda casas
		end
	end
end
addCommandHandler("ayuda",aiudaa)