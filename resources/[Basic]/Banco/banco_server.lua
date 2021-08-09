loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local colsShapes = {}
local antiSpamComando = {}



permisos = {
["Administrador"]=true,
}


addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getTableATM()) do
		if v[4] == true then
			Blip( v[1], v[2], v[3], 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		end
		colsShapes[i] = ColShape.Sphere(v[1], v[2], v[3], 2)
	end
end)

addCommandHandler("fondo", function(p, cmd, who)
	if not notIsGuest(p) then
		if permisos[getACLFromPlayer(p)] == true then
			if tonumber(who) then
				local player = exports["Gamemode"]:getFromName( p, who )
				if (player) then
					local money = p:getData("Roleplay:bank_balance")
					if money then
						p:outputChat("#FF0033"..player:getName().." tiene en el banco $ #004500"..convertNumber(money).." dólares.", 255, 255, 255, true)
					end
				end
			else
				local player = exports["Gamemode"]:getFromName( p, who )
				if (player) then
					local money = p:getData("Roleplay:bank_balance")
					if money then
						p:outputChat("#FF0033"..player:getName().." tiene en el banco $ #004500"..convertNumber(money).." dólares.", 255, 255, 255, true)
					end
				end
			end
		end
		--
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
				p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					local s = p:getData("Roleplay:tarjeta_credito")
					if s == 1 then
						local money = p:getData("Roleplay:bank_balance")
						if money then
							p:outputChat("Tu fondo en total es de: #00FF00$"..convertNumber(money), 255, 255, 255, true)
						end
					else
						p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
					end
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)


addCommandHandler("banco", function(p, cmd)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 5000) then
				p:outputChat("Debes esperar 5 segundos después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					triggerClientEvent(p,"verbancowin",p)
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)

addEvent("Banco:Depositar",true)
addEventHandler("Banco:Depositar",root, function(monto)
	if not notIsGuest(source) then
		if tonumber(monto) then
			monto = math.round(math.abs(monto))
			local s = source:getData("Roleplay:tarjeta_credito")
			--if s == true then
				if monto and tonumber(monto) ~= nil then
					if source:getMoney() >= tonumber(monto) then
						if source:getMoney() >= 1 then
							local account = source:getAccount()
							local money = source:getData("Roleplay:bank_balance") or 0
							local total = tonumber(money)+ tonumber(monto) 
							source:setData ( "Roleplay:bank_balance", tonumber(total) )
							source:takeMoney(tonumber(monto))
							outputDebugString("* "..source:getName().." ha depositado: $"..convertNumber(monto).." ", 0, 0, 150, 0)
							source:outputChat("* Has depositado la cantidad: #004500$"..convertNumber(monto).." dólares.", 0, 150, 0, true)
						else
							source:outputChat("* No tienes dinero para depositar", 150, 0, 0)
						end
					else
						source:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para depositar", 150, 0, 0)
					end
				else
					source:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para depositar", 150, 0, 0)
				end
			--else
			--	source:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
			--end
			if (not antiSpamComando[source]) then
				antiSpamComando[source] = {}
			end
			antiSpamComando[source][1] = getTickCount()
		else
			source:outputChat("* Solo puedes poner nùmeros", 150, 0, 0)
		end
	end
end)

addEvent("Banco:Retirar",true)
addEventHandler("Banco:Retirar",root, function(monto)
	if not notIsGuest(source) then
		if tonumber(monto) then
			monto = math.round(math.abs(monto))
			--local s = source:getData("Roleplay:tarjeta_credito")
			--if s == 1 then
				if monto and tonumber(monto) ~= nil then
					local money = source:getData("Roleplay:bank_balance") or 0
					if tonumber(money) >= tonumber(monto) then
						local account = source:getAccount()
						local total = tonumber(money) - monto
						source:setData ( "Roleplay:bank_balance", tonumber(total) )
						source:giveMoney (monto)
						outputDebugString("* "..source:getName().." ha retirado: $"..convertNumber(monto).." ", 0, 150, 0, 0)
						source:outputChat("* Has retirado la cantidad: #004500$"..convertNumber(monto).." dólares.", 150, 0, 0, true)

					else
						source:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para retirar", 150, 0, 0)
					end
				else
					source:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para retirar", 150, 0, 0)
				end
			--else
			--	source:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
			--end
			if (not antiSpamComando[source]) then
				antiSpamComando[source] = {}
			end
			antiSpamComando[source][1] = getTickCount()
		end
	end
end)

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
