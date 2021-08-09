loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



--- setTimers

local globalMoney = 38

local enTrabajoMoney = 70

local faccionMoney = 2350




local rangosMoney = {



["Policia"]={


["Comandante"]=20000,


["Capitan"]=18000,


["Teniente"]=18000,


["Sargento"]=13000,


["Detective II"]=7850,


["Detective I"]=6000,


["Oficial III+"]=6000,


["Oficial III"]=3350,


["Oficial II"]=2250,


["Oficial I"]=1500,


["Cadete"]=1000,

},


--



["Medico"]={


["Director General"]=18000,


["Director"]=14200,


["Sargento"]=10550,


["Rescatista"]=7500,


["Medico"]=4000,



["Paramedico"]=2000,



["Aspirante"]=1020,


},


["Bomberos"]={


["Jefe de Bomberos"]=18000,


["Vicejefe de bomberos"]=14200,


["Jefe adjunto"]=10550,


["Capitán"]=7500,


["Teniente"]=4000,



["Bombero III"]=2000,



["Bombero I"]=1020,


["Candidato"]=1000,


},


--



["Mecanico"]={



["Empresario"]=15000,



["Sub Empresario"]=12000,



["Mecanico Experto"]=10000,



["Mecanico"]=8000,



["Junior"]=3000,



["Aprendiz"]=1000,



},



["Gobierno"]={



["Magistrado"]=25000,



["Juez General"]=20000,



["Juez"]=15000,



["Fiscal"]=12000,



["Abogado"]=10000,



["Asistente Legal"]=7000,



["Estudiante"]=5000,



["Seguridad"]=3000,


},

}

--



Levels = {

{500, 1},

{1000, 2},

{1500, 3},

{2000, 4},

{2500, 5},

{3000, 6},

{3500, 7},

{4000, 8},

{4500, 9},

{5000, 10},

{5500, 11},

{6000, 12},

{6500, 13},

{7000, 14},

{7500, 15},

{8000, 16},

{8500, 17},

{9000, 18},

{9500, 19},

{10000, 20},

{10500, 21},

{11000, 22},

{11500, 23},

{12000, 24},

{12500, 25},

}


function payday()

	for index, player in ipairs(Element.getAllByType("player")) do

		if not notIsGuest( player ) then


			if player:getData("AFK") == false then

				local vehs = exports["VehPriv"]:getLastID(player) or 0
				
				local name = getPlayerName(player)

				local vehs = vehs - 1
				local paga = 100 + 50 * vehs
				dinero = "100"
			if getPlayerVIP(player) == "VIPNormal" then
				paga = 125 + 35 * vehs
				dinero = "125"
			elseif getPlayerVIP(player) == "VIPPro" then
				paga = 125 + 35 * vehs
				dinero = "125"
			end

				local faccion = player:getData("Roleplay:faccion") or ""

				local rango = player:getData("Roleplay:faccion_rango") or ""
				
				outputDebugString("El Administrador "..name.. " Acaba de Lanzar el Payday")

				player:outputChat("------ #DB50FFPAYDAY#FFFFFF ------", 255, 255, 255, true)

				player:outputChat("#F6FF00Gobierno: #11FF00+ #0BBA00$"..dinero, 255, 255, 255, true)

				playSoundFrontEnd (player, 7)


				if player:getData("Roleplay:faccion") ~="" then

					player:outputChat("#F6FF00Facción: #11FF00+ #0BBA00$"..rangosMoney[tostring(faccion)][tostring(rango)], 255, 255, 255, true)

				end

				player:outputChat("#FF0000Impuestos: \n#FF0000- $"..convertNumber(math.round(vehs * 50)).." #FCFF08Vehículos\n#FF0000- $0 #FCFF08Casas\n", 255, 255, 255, true)

				if player:getData("Roleplay:faccion") ~="" then

					player:outputChat("#11FF00Total: #0BBA00$"..convertNumber(50 + rangosMoney[tostring(faccion)][tostring(rango)] - (vehs * 30) ), 255, 255, 255, true)

					if player:getData("Roleplay:tarjeta_credito") == true then

						player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(math.ceil( rangosMoney[tostring(faccion)][tostring(rango)] + paga)))

					else

						player:setMoney(player:getMoney() + rangosMoney[tostring(faccion)][tostring(rango)] + paga )
						
					end

				else

					player:outputChat("#11FF00Total: #0BBA00$"..convertNumber( paga ), 255, 255, 255, true)

					if player:getData("Roleplay:tarjeta_credito") == true then

						player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(paga))

					else
						player:setMoney(player:getMoney() + paga)

					end

				end

				setNivel(player)

			end

		end

	end

end

addCommandHandler("darpayday",payday)

setTimer(function()
	payday()
end, 1000*60*60,0)



function setNivel( player )
	if isElement(player) then
		local nivel = tonumber(player:getData("Nivel")) or 1
		local actualExp = player:getData("PlayerExp") or 0

		if nivel == #Levels then

			exports['Notificaciones']:setTextNoti(player, '¡Estas en tu nivel maximo ', 0,255,0, true)

		elseif nivel < #Levels then
			local nuevaExp = 100
			if getPlayerVIP(player) == "VIPNormal" then
				nuevaExp = 200
			elseif getPlayerVIP(player) == "VIPPro" then
				nuevaExp = 300
			end
			if actualExp+nuevaExp >= Levels[nivel][1] then

				player:setData("Nivel",nivel+1)
				player:setData('PlayerExp',Levels[nivel][1]-(actualExp+nuevaExp))
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)

			elseif actualExp+nuevaExp < Levels[nivel][1] then

				player:setData('PlayerExp', actualExp+nuevaExp)
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)
			end
		end

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



function getExp( player )

	if isElement( player ) and player:getType() == "player" then

		return tonumber(player:getData("PlayerExp") or 0)

	else

		return false

	end

	return false

end



function getNivel( player )

	if isElement( player ) and player:getType() == "player" then

		return tonumber(player:getData("PlayerNivel") or 1)

	else

		return false

	end

	return false

end

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
