loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

function cargardatos()
	for _, source in ipairs(Element.getAllByType("player")) do
		local cuenta = AccountName(source)
		local s = query("SELECT * From `Facciones` where Nombre =?", tostring(cuenta))
		if not ( type( s ) == "table" and #s == 0 ) or not s then
			local lider = s[1]["Lider"]
			if lider == "Si" then
				source:setData("Roleplay:faccion_lider", "Si")
			else
				source:setData("Roleplay:faccion_lider", "No")
			end
			local liderdivision = s[1]["Division_Lider"]
			if liderdivision == "Si" then
				source:setData("Roleplay:faccion_division_lider", "Si")
			else
				source:setData("Roleplay:faccion_division_lider", "No")
			end
			--
			source:setData("Roleplay:faccion", tostring(s[1]["Faccion"]))
			source:setData("Roleplay:faccion_rango", tostring(s[1]["Rango"]))
			source:setData("Roleplay:faccion_sueldo", tonumber(s[1]["Sueldo"]))
			source:setData("Roleplay:faccion_division", tostring(s[1]["Division"]))
		else
			source:setData("Roleplay:faccion", "")
			source:setData("Roleplay:faccion_lider", "No")
			source:setData("Roleplay:faccion_division_lider", "No")
			source:setData("Roleplay:faccion_rango", "")
			source:setData("Roleplay:faccion_division", "")
			source:setData("Roleplay:faccion_sueldo", 0)
		end
	end
end

addEventHandler("onPlayerLogin", getRootElement(),cargardatos)


local faccionesText = {
["Policia"] = "Policia",
["Medico"] = "Medico",
["Bomberos"] = "Bomberos",
["Mecanico"] = "Mecanico",
}


addCommandHandler("limpiarfacc", function(player, cmd, faccion)
	if not notIsGuest( player ) then
		if getACLFromPlayer(player) == "Admin" or "Sup.Facc" then
			local fac = table.concat({faccion}, "")
			if fac ~="" and fac ~=" " then
				local s = trunklateText(fac)
				if s:find(tostring(faccionesText[s])) then					--
					delete("DELETE FROM Facciones WHERE Faccion=?", tostring(faccionesText[s]))
					player:outputChat("Acabas de limpiar la facción: "..tostring(faccionesText[s]), 50, 150, 50, true)
					for _, player in ipairs(Element.getAllByType("player")) do
						if player:getData("Roleplay:faccion") == tostring(faccionesText[s]) then
							player:setData("Roleplay:faccion", "")
							player:setData("Roleplay:faccion_lider", "No")
							player:setData("Roleplay:faccion_division_lider", "No")
							player:setData("Roleplay:faccion_rango", "")
							player:setData("Roleplay:faccion_division", "")
							player:setData("Roleplay:faccion_sueldo", 0)
						end
					end
				else
					player:outputChat("* Solamente puedes limpiar estas facciones: ", 150, 50, 50, true)
					for i, v in pairs(faccionesText) do
						player:outputChat(faccionesText[i], 20, 50, 20, true)
					end
				end
			end
		end
	end
end)

addCommandHandler("facbug",function(source,cmd)
	source:setData("Roleplay:faccion", "")
	source:setData("Roleplay:faccion_lider", "No")
	source:setData("Roleplay:faccion_division_lider", "No")
	source:setData("Roleplay:faccion_rango", "")
	source:setData("Roleplay:faccion_division", "")
	source:setData("Roleplay:faccion_sueldo", 0)
end)

local rank2

addCommandHandler("liderfacc", function(player, cmd, who, facc)
	if not notIsGuest( player ) then
		if getACLFromPlayer(player) == "Admin" or "Sup.Facc" then
			if (who) then
				local thePlayer = exports["Gamemode"]:getFromName( player, who )
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion") ~= "" then
						player:outputChat(thePlayer:getName().." se encuentra en una facción debe dejar su facción para que le puedas dar el lider.", 150, 50, 50, true)
					else
						local fac = table.concat({facc}, "")
						if fac ~="" and fac ~=" " then
							local sa = trunklateText(fac)
							if sa:find(tostring(faccionesText[sa])) then
								local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", tostring(faccionesText[sa]), 'Si')
								if ( type( s ) == "table" and #s == 0 ) or not s then
									if sa == "Policia" then
										rank2 = "Comandante"
									elseif sa == "Medico" then
										rank2 = "Director"
									elseif sa == "Bomberos" then
										rank2 = "Jefe de Bomberos"
									elseif sa == "Mecanico" then
										rank2 = "Empresario"
									end
									player:outputChat("* Le acabas de entregar el lider a #FFFFFF"..thePlayer:getName().."", 50, 100, 50, true)
									thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de "..tostring(faccionesText[sa]), 50, 150, 50, true)
									insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", tostring(faccionesText[sa]), AccountName(thePlayer), rank2, '0', 'Si', '', 'No')
									thePlayer:setData("Roleplay:faccion", tostring(faccionesText[sa]))
									thePlayer:setData("Roleplay:faccion_lider", "Si")
									thePlayer:setData("Roleplay:faccion_rango", rank2)
									thePlayer:setData("Roleplay:faccion_sueldo", 0)
									thePlayer:setData("Roleplay:faccion_division", "")
									thePlayer:setData("Roleplay:faccion_division_lider", "No")
								else
									player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
								end
							end
						end
					end
				else
					player:outputChat("Syntax: /liderfacc [ID] [FACC]", 255, 255, 255, true)
				end
			end
		end
	end
end)


addCommandHandler("data", function(player, cmd, who)
	if not notIsGuest( player ) then
		if getACLFromPlayer(player) == "Admin"  or "Sup.Facc" then
			if who then
				local thePlayer = exports["Gamemode"]:getFromName( player, who )
				if (thePlayer) then
					print("Faccion: "..(thePlayer:getData("Roleplay:faccion") or ""))
					print("Lider: "..(thePlayer:getData("Roleplay:faccion_lider") or ""))
					print("Rango: "..(thePlayer:getData("Roleplay:faccion_rango") or ""))
					print("Sueldo: "..(thePlayer:getData("Roleplay:faccion_sueldo") or ""))
					print("Division: "..(thePlayer:getData("Roleplay:faccion_division") or ""))
					print("Lider de Division: "..(thePlayer:getData("Roleplay:faccion_division_lider") or ""))
				end
			end
		end
	end
end)

local mie = 0

addCommandHandler("miembros", function(player, cmd, faccion)
--
	if not notIsGuest( player ) then
		local fac = table.concat({faccion}, "")
		if fac ~="" and fac ~=" " then
			local s = trunklateText(fac)
			if s:find(tostring(faccionesText[s])) then
				player:outputChat("#00B3FF* Miembros de la facción "..tostring(faccionesText[s]).."", 115, 115, 115, true)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if getPlayerFaction(v, tostring(faccionesText[s])) then
						player:outputChat("#FF900E* ".._getPlayerNameR(v).." | "..v:getData("Roleplay:faccion_rango").."", 50, 150, 50, true)
					end
				end
			else
				player:outputChat("* Solamente puedes ver miembros de estas facciones: ", 150, 50, 50, true)
				for i, v in pairs(faccionesText) do
					player:outputChat("#FFD200"..faccionesText[i], 20, 50, 20, true)
				end
			end
		end
	end
end)

local solicitud_contrato = {}
local tabla_contratos = {}
local datos_jugador = {}
local timerContrato = {}


addCommandHandler("contratar", function(player, cmd, who)
	if not notIsGuest( player ) then
		local ra = player:getData("Roleplay:faccion_rango")
		if ra == "Capitan" or ra == "Comandante" or ra == "Director" or ra == "Sub Director" or ra == "Empresario" or ra == "Sub Empresario" then
			if solicitud_contrato[player] == nil and solicitud_contrato[player] == false then
				player:outputChat("* Ya has enviado una solicitud de contrato a un jugador.", 150, 0, 0, true)
			else
				local thePlayer = exports["Gamemode"]:getFromName( player, who )
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion") == "" then
						local posicion = Vector3(player:getPosition()) -- player
						local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
						local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
						local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
						if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
							if tabla_contratos[thePlayer] == true then
								player:outputChat("* Ya hay otra persona mandandole una solicitud.", 150, 50, 50, true)
							else
								solicitud_contrato[player] = true
								tabla_contratos[thePlayer] = true
								--
								datos_jugador[thePlayer] = player:getName()
								--
								timerContrato[player] = setTimer( function(player, thePlayer) if isElement(player) or isElement(thePlayer) then solicitud_contrato[player] = nil tabla_contratos[thePlayer] = nil datos_jugador[thePlayer] = {}  end end, 60000, 1, player, thePlayer)
								--
								player:outputChat("Le has mando una solicitud al jugador: "..thePlayer:getName().." ", 50, 255, 50)
								if getPlayerFaction(player, "Policia") then
									mensajeText = "#003F74LSPD (Policias)."
								elseif getPlayerFaction(player, "Medico") then
									mensajeText = "##004E50LSPD (Medicos)."
								elseif getPlayerFaction(player, "Mecanico") then
									mensajeText = "#9B9A00Mecanicos."
								elseif getPlayerFaction(player, "Gobierno") then
									mensajeText = "#9B9A9BGobiernos."
								end
								thePlayer:outputChat("#FFFF00"..player:getName().." #ffffffte invito a unirte a "..mensajeText, 50, 255, 50,true)
								thePlayer:outputChat("/aceptarcontrato", 50, 150, 50)
								thePlayer:outputChat("/cancelarcontrato", 150, 50, 50)
								--
							end
						end
					else
						player:outputChat("* Se encuentra en una facción ahora mismo.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /contratar [ID]", 255, 255, 255, true)
				end
			end
		end
	end
end)


addCommandHandler("aceptarcontrato", function(source, cmd)
	if not notIsGuest( source ) then
		if tabla_contratos[source] == true then
			local thePlayer = getPlayerFromName(datos_jugador[source])
			if ( thePlayer ) then
				MensajeRoleplay( source, "firmo un contrato.", 215, 122, 8 )
				--
				if thePlayer:getData("Roleplay:faccion") == "Policia" then
					rank = "Cadete"
				elseif thePlayer:getData("Roleplay:faccion") == "Medico" then
					rank = "Aspirante"
				elseif thePlayer:getData("Roleplay:faccion") == "Gobierno" then
					rank = "Seguridad"
				elseif thePlayer:getData("Roleplay:faccion") == "Bomberos" then
					rank = "Candidato"
				elseif thePlayer:getData("Roleplay:faccion") == "Mecanico" then
					rank = "Aprendiz"
				else
					rank ="N/A"
				end
				--
				insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", tostring(thePlayer:getData("Roleplay:faccion")), AccountName(source), rank, '0', 'No', '', 'No')
				--
				source:setData("Roleplay:faccion", tostring(thePlayer:getData("Roleplay:faccion")))
				source:setData("Roleplay:faccion_lider", "No")
				source:setData("Roleplay:faccion_rango", rank)
				source:setData("Roleplay:faccion_sueldo", 0)
				source:setData("Roleplay:faccion_division", "")
				source:setData("Roleplay:faccion_division_lider", "No")
				--
				solicitud_contrato[thePlayer] = nil
				tabla_contratos[source] = nil
				datos_jugador[source] = nil
				if isTimer(timerContrato[source]) then
					killTimer(timerContrato[source])
					timerContrato[source] = nil
				end
				if isTimer(timerContrato[thePlayer]) then
					killTimer(timerContrato[thePlayer])
					timerContrato[thePlayer] = nil
				end
			end
		end
	end
end)

addCommandHandler("cancelarcontrato", function(source, cmd)
	if not notIsGuest( source ) then
		if tabla_contratos[source] == true then
			local thePlayer = getPlayerFromName(datos_jugador[source])
			if ( thePlayer ) then
				MensajeRoleplay( source, " cancelo el contrato de ".._getPlayerNameR(thePlayer).."", 215, 122, 8 )
				solicitud_contrato[thePlayer] = nil
				tabla_contratos[source] = nil
				datos_jugador[source] = nil
				if isTimer(timerContrato[source]) then
					killTimer(timerContrato[source])
					timerContrato[source] = nil
				end
				if isTimer(timerContrato[thePlayer]) then
					killTimer(timerContrato[thePlayer])
					timerContrato[thePlayer] = nil
				end
			end
		end
	end
end)

addCommandHandler("dejarfaccion", function(player)
	if not notIsGuest( player ) then
		if player:getData("Roleplay:faccion") ~="" then
			player:outputChat("* Acabas de abandar tu facción: #FF0033"..player:getData("Roleplay:faccion"), 50, 150, 50, true)
			for i , v in ipairs(Element.getAllByType("player")) do
				if getPlayerFaction(v, player:getData("Roleplay:faccion")) then
					v:outputChat("* ".._getPlayerNameR(player).." abandono el trabajo", 150, 50, 50, true)
				end
			end
			delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))
			player:setData("Roleplay:faccion", "")
			player:setData("Roleplay:faccion_lider", "No")
			player:setData("Roleplay:faccion_rango", "")
			player:setData("Roleplay:faccion_sueldo", 0)
			player:setData("Roleplay:faccion_division", "")
			player:setData("Roleplay:faccion_division_lider", "No")

		end
	end
end)


addCommandHandler("despedir", function(source, cmd, who)
	if not notIsGuest( source ) then
		if source:getData( "Roleplay:faccion" ) ~="" then
			if source:getData("Roleplay:faccion_rango") == "Capitan" or source:getData("Roleplay:faccion_rango") == "Comandante" or source:getData("Roleplay:faccion_rango") == "Director" or source:getData("Roleplay:faccion_rango") == "Sub Director" or source:getData("Roleplay:faccion_rango") == "Empresario" or source:getData("Roleplay:faccion_rango") == "Sub Empresario" then
				local player = exports["Gamemode"]:getFromName( soruce, who )
				if (player) then
					local s = query("SELECT * From `Facciones` where Nombre = ?", tostring(AccountName(player)))
					if ( type( s ) == "table" and #s == 0 ) or not s then
						source:outputChat("* El jugador: "..player:getName().." no se encuentra en la facción", 150, 50, 50, true)
					else
						source:outputChat("* El jugador: "..player:getName().." ha sido despedido", 50, 150, 50, true)
						delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))
						player:setData("Roleplay:faccion", "")
						player:setData("Roleplay:faccion_lider", "No")
						player:setData("Roleplay:faccion_rango", "")
						player:setData("Roleplay:faccion_sueldo", 0)
						for i ,v in ipairs(Element.getAllByType("player")) do
							if v:getData("Roleplay:faccion") == source:getData("Roleplay:faccion") then
								v:outputChat("* El jugador: "..player:getName().." ha sido despedido por "..source:getName(), 50, 150, 50, true)
							end
						end
					end
				else
					source:outputChat("Syntax: /despedir [ID]", 255, 255, 255, true)
				end
			end
		end
	end
end)




local _Rangos = {

	["Policia"]={

    'Cadete'

    ,'Oficial I'

    ,'Oficial II'

    ,'Oficial III'

    ,'Oficial III+'

    ,'Detective I'

    ,'Detective II'

    ,'Sargento'

    ,'Teniente'

    ,'Capitan'

	},

	["Medico"]={

     'Aspirante'

    ,'Paramedico'

    ,'Medico'

    ,'Rescatista'

    ,'Sargento'

    ,'Director'

	},
	
	["Bomberos"]={
	
    'Candidato'


    ,'Paramedico'




    ,'Bombero l '






    ,'Bombero ll'







    ,'Bombero lll'





    

     ,'Teniente'







     ,'Capitán'




	

    ,'Jefe adjunto'







    ,'Vicejefe de bomberos'
	},

	["Mecanico"]={

    'Aprendiz'

    ,'Junior'

    ,'Mecanico'

    ,'Mecanico Experto'	

    ,"Sub Empresario"	

	},

	["Gobierno"]={

    'Seguridad'

    ,'Estudiante'

    ,'Asistente Legal'

    ,'Abogado'

    ,'Fiscal'

    ,'Juez'

    ,'Juez General'

	},

}



function _Cmd_Rangos(jug, cmd, name)
	if not notIsGuest( jug ) then
		if jug:getData("Roleplay:faccion") ~= "" then
			if jug:getData("Roleplay:faccion_rango") == "Capitan" or jug:getData("Roleplay:faccion_rango") == "Comandante" or jug:getData("Roleplay:faccion_rango") == "Director" or jug:getData("Roleplay:faccion_rango") == "Sub Director" or jug:getData("Roleplay:faccion_rango") == "Empresario" or jug:getData("Roleplay:faccion_rango") == "Sub Empresario"  or jug:getData("Roleplay:faccion_rango") == "Jefe de Bomberos" then
		        local who = exports["Gamemode"]:getFromName( jug, name )
		        if who then
		            local old_rank = who:getData("Roleplay:faccion_rango") or false
		            if old_rank then
		                local ID = table.find(_Rangos[jug:getData("Roleplay:faccion")], old_rank)
		                if ID then
		                    if cmd == 'subirrango' then
		                        ID = ID + 1
		                    elseif cmd == 'bajarrango' then
		                        ID = ID - 1
		                    end
		                    if _Rangos[jug:getData("Roleplay:faccion")][ID] then
		                        if who then
		                        	update("UPDATE Facciones SET Rango = ?  WHERE Nombre = ?", _Rangos[who:getData("Roleplay:faccion")][ID], AccountName(who))
		                            who:setData("Roleplay:faccion_rango", _Rangos[jug:getData("Roleplay:faccion")][ID])

		                            who_sms = (cmd == 'subirrango' and jug.name..' te ascendió a '.._Rangos[jug:getData("Roleplay:faccion")][ID]) or (cmd == 'bajarrango' and jug.name..' te a bajado de puesto a '.._Rangos[jug:getData("Roleplay:faccion")][ID])
		                            who:outputChat(who_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)

		                            jug_sms = (cmd == 'subirrango' and "Ascendiste a "..who:getName().." al rango ".._Rangos[jug:getData("Roleplay:faccion")][ID]) or (cmd == 'bajarrango' and who:getName().." Bajo al rango ".._Rangos[jug:getData("Roleplay:faccion")][ID])
		                            jug:outputChat(jug_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)
		                        end
		                    end
		                end
		            end
		        else
		        	jug:outputChat("Syntax: /subirrango [ID]", 255, 255, 255)
		        	jug:outputChat("Syntax: /bajarrango [ID]", 255, 255, 255)
		        end
			end
		end
	end
end

addCommandHandler('subirrango',_Cmd_Rangos)
addCommandHandler('bajarrango',_Cmd_Rangos)








function table.find(t, value)

    for k,v in ipairs(t) do

      	  if v == value then

            return k,v

      	end

    end

    return false

end


local TaserCables = {}

addEvent("setAnimAndCable", true)
function setAnimAndCable( p )
	TaserCables[p] = true
	p:setAnimation("ped", "FLOOR_hit_f", -1,true, false, false)
	p:setFrozen(true)
end
addEventHandler("setAnimAndCable", root, setAnimAndCable)

addCommandHandler("quitarcables", function(player, cmd, who)
	if not notIsGuest(player) then
		if player:getData("Roleplay:faccion") ~="" then
			if getPlayerFaction(player, "Policia") or getPlayerDivision(player, "S.W.A.T.") or getPlayerDivision(player, "DIC") then
				local thePlayer = exports["Gamemode"]:getFromName( player, who )
				if (thePlayer) then
					local posicion = Vector3(player:getPosition()) -- player
					local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
					local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
					local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
					if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 2 then -- 5
						if TaserCables[thePlayer] == true then
							player:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)
							--
							setTimer(function(player, p)
								if isElement(player) or isElement(p) then
								setPedAnimation(p)
								setPedAnimation(player)
								p:setFrozen(false)
								player:setFrozen(false)
								TaserCables[p] = nil
--									MensajeRoleplay(player, "le quito los cables a ".._getPlayerNameR(p), 215, 122, 8)
							end
							end, 1000, 1, player, thePlayer)
						else
							player:outputChat("El ".._getPlayerNameR(thePlayer).." no esta paralizado.", 150, 50, 50, true)
						end
					else
						player:outputChat("* Te encuentras muy alejado del jugador ".._getPlayerNameR(thePlayer).."", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /quitarcables [ID]", 255, 255, 255, true)
				end
			end
		end
	end
end)



local GuardarPistola = {}
addCommandHandler('taser',
	function(p)
		if getPlayerFaction( p, 'Policia' ) then
			local cuenta = p.account.name;
			local oldWep = p:getWeapon(2) or false
			if oldWep ~= 23 or not oldWep then
				if oldWep == 22 or oldWep == 24 then
					GuardarPistola[cuenta] = {oldWep, p:getTotalAmmo(2)}
				end
				giveWeapon(p, 23, 5, true)
				setWeaponAmmo(p,23,5)
			else
				if GuardarPistola[cuenta] then
					local id,ammo = unpack(GuardarPistola[cuenta])
					giveWeapon(p, id,ammo, true )
				else
					takeWeapon( p, 23 )
				end
			end
		end
	end
)
local valoresRefuerzos = {}

local antiSpamRef = {}

addCommandHandler("ref", function(p)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "Medico" ) or getPlayerFaction( p, "Bomberos" ) then

		--	if inPlayerVehiclePolice(p) then

				local tick = getTickCount()

				if (antiSpamRef[p] and antiSpamRef[p][1] and tick - antiSpamRef[p][1] < 2000) then

					return

				end

					local nick = _getPlayerNameR( p )

					if valoresRefuerzos[p] == true then

						valoresRefuerzos[p] = nil

						for i, v in ipairs(Element.getAllByType("player")) do

							if getPlayerFaction(v, "Policia") or getPlayerFaction( v, "Medico" ) or getPlayerFaction( p, "Bomberos" ) then

								v:triggerEvent("Police:destroy_blip", v,(p:getOccupiedVehicle() or p))

								v:outputChat("#FF6C6C* ".. nick.." ya no pide refuerzos.", 255, 255, 255, true)

							end

						end

					else

						--

						valoresRefuerzos[p] = true

						--

						for i, v in ipairs(Element.getAllByType("player")) do

							if getPlayerFaction(v, "Policia") or getPlayerFaction( v, "Medico" ) or getPlayerFaction( p, "Bomberos" ) then

								--

								v:triggerEvent("Police:create_blip", v, (p:getOccupiedVehicle() or p))

								--

								v:outputChat("#FF6C6C* ".. nick.." pide refuerzos utilizando su radio.", 255, 255, 255, true)

								v:outputChat("#A50101El "..(p:getData("Roleplay:faccion_rango") or "Cadete").." ".. nick.." necesita refuerzos, se le ha indicado su posición.", 255, 255, 255, true)

							end

						end

					end

				if (not antiSpamRef[p]) then

					antiSpamRef[p] = {}

				end

				antiSpamRef[p][1] = getTickCount()

			end

	--	end

	end

end)

addCommandHandler("limpref", function(p)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "Medico" ) or getPlayerFaction( p, "Bomberos" ) then
			p:outputChat("* Has eliminado todo los blips", 50, 150, 50, true)
			for _, vehs in ipairs(Element.getAllByType("vehicle")) do
				p:triggerEvent("Police:destroy_blip", p, (vehs or Element.getAllByType("player")))
				if valoresRefuerzos[p] == true then
					valoresRefuerzos[p] = nil
				end
			end
		end
	end
end)

function getTaserCables( player )
	if isElement(player) and player:getType() == "player" then
		if TaserCables[player] == true then
			return true
		else
			return false
		end
	end
	return false
end


-- taser function
setWeaponProperty("silenced", "pro", "weapon_range", 5)
setWeaponProperty("silenced", "pro", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "pro", "damage", 100)

setWeaponProperty("silenced", "std", "weapon_range", 5)
setWeaponProperty("silenced", "std", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "std", "damage", 100)

setWeaponProperty("silenced", "poor", "weapon_range", 5)
setWeaponProperty("silenced", "poor", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "poor", "damage", 100)


function trunklateText(text)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end

function inPlayerVehiclePolice(player)
	local veh = getPedOccupiedVehicle ( player )
	if player:isInVehicle() then
		if veh:getModel() == 598 or veh:getModel() == 596 or veh:getModel() == 597 or veh:getModel() == 490 then
			return true
		end
	end
	return false
end

local pickup2 = Marker(1601.171875, -1704.0966796875, 5.890625-1,"cylinder",4,255,255,255,50)

local auto_Creado = {}


function borraveh(source)
	local veh = getPedOccupiedVehicle (source)
	if veh then
		if getElementData(source,"Roleplay:faccion") == "Policia" then
			if isElementWithinMarker(source,pickup2) then
				if getElementData(veh,"VehiculoPublico") == "Policia" then
					veh:destroy()
				end
			end 
		end
	end
end
addCommandHandler("borrarveh",borraveh)

addEvent("spawnpd",true)
addEventHandler("spawnpd",root,function(id,key)
	local x,y,z,rx,ry,rz = getFreePosition("posicion_PD") 
	local maletero = {Slots=10,Items={}}
	for pi = 1,10 do
		maletero.Items[tostring(pi)] = {'Vacio'}
	end
	auto_Creado[key] = createVehicle(id,x,y,z,rx,ry,rz)	
	auto_Creado[key]:setLocked(true)
	auto_Creado[key]:setEngineState(false)
	auto_Creado[key]:setData('Maletero', maletero)
	auto_Creado[key]:setData('Locked', 'Cerrado')
	auto_Creado[key]:setData('Motor','apagado')
	auto_Creado[key]:setData("VehiculoPublico", "Policia")
	auto_Creado[key]:setData("Fuel", 100)
	auto_Creado[key]:setLocked(true)
	auto_Creado[key]:setEngineState (false)
	auto_Creado[key]:setFrozen(true)
	if tonumber(id) == 468 then
		auto_Creado[key]:setColor(0,0,0)
	end
end)


local antiSpamCommnd = {}

function abrirMyVehicle(p,cmd)
	local veh = getPlayerNearbyVehicle(p)
	if veh then
		local ID = getElementData(veh, 'VehiculoPublico') or false
		if ID then
			local tick = getTickCount()
			if (antiSpamCommnd[p] and antiSpamCommnd[p][1] and tick - antiSpamCommnd[p][1] < 1000) then
				return
			end
			local owner = p:getData("Roleplay:faccion")
			local owner2 = p:getData("Roleplay:trabajo")
			if owner == ID or owner2 == ID then
				local state = getElementData(veh, 'Locked')
				if state == 'Abierto' then

					veh:setLocked(true)
					veh:setData('Locked', 'Cerrado')
					exports['Notificaciones']:setTextNoti(p, "> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
					
				else
					
					veh:setLocked(false)
					veh:setData('Locked', 'Abierto')
					exports['Notificaciones']:setTextNoti(p, "> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
				
				end
			end
			if (not antiSpamCommnd[p]) then
				antiSpamCommnd[p] = {}
			end
			antiSpamCommnd[p][1] = getTickCount()
		end
	end
end
addCommandHandler("abrir",abrirMyVehicle)
addCommandHandler("cerrar",abrirMyVehicle)
addCommandHandler("bloqueo",abrirMyVehicle)


local posiciones_c = {

	posicion_PD = {
		{1595.2216796875, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-4, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-8, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-12, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-16, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-20, -1710.638671875, 5.890625,0, 0, 357.03091430664},
		{1595.2216796875-24, -1710.638671875, 5.890625,0, 0, 357.03091430664},
	},

}

function getFreePosition(key)
	local x,y,z,rx,ry,rz = 0,0,0,0,0,0
	for i,v in ipairs(posiciones_c[key]) do
		local col = createColSphere( v[1],v[2],v[3], 2 )
		local _counts = col:getElementsWithin('vehicle')
		if #_counts == 0 then
			x,y,z,rx,ry,rz = v[1],v[2],v[3],v[4],v[5],v[6]
			if isElement(col) then
				col:destroy()
			end
			return x,y,z,rx,ry,rz
		else
			if isElement(col) then
				col:destroy()
			end
		end
	end
	x,y,z,rx,ry,rz = unpack(posiciones_c[key][math.random(1,#posiciones_c[key])])
	return x,y,z,rx,ry,rz
end

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

function MensajeRoleplay( player, texto, r, g, b )
	local pos = Vector3(player:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	local chatCol = ColShape.Sphere(x, y, z, 10)
	local nearPlayers = chatCol:getElementsWithin("player")
	for index, v in ipairs(nearPlayers) do
		v:outputChat("#FF00D8* ".._getPlayerNameR(player).." "..(texto or ""), 255, 255, 255, true)
	end
	if isElement(chatCol) then
		destroyElement(chatCol)
	end
end
