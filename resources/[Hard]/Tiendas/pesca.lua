
function pescar(thePlayer)
	local tick = getTickCount()
	
	local can = getPlayerItem(thePlayer, "Caña de pescar") or 0
	if thePlayer:getData("Caña de pescar") == "Si" then	
	exports['[LS]Notificaciones']:setTextNoti(thePlayer,"*Necesitas una caña.", 150, 0, 0)
	else
	local item = "Cebo"
	local ce = getPlayerItem(thePlayer, item)
	if (ce <= 1) then
		outputChatBox("Nesecitas un cebo para poder pescar" ,thePlayer,255,255,255,true)
	else
	
	setElementFrozen( thePlayer, true )
		setTimer(function(thePlayer)
		outputChatBox("#EEE60DLanzas un cebo en busca de peces",thePlayer,255,255,255,true)	
			setPedAnimation(thePlayer, "KISSING", "GF_CarSpot",-1, true, false, false, false)
	end,1000,1,thePlayer)

	setTimer(function(thePlayer)	
		setPedAnimation(thePlayer, "GRENADE", "WEAPON_throw", -1, false, false, false, false)
	end,100,1,thePlayer)

	setTimer(function(thePlayer)
		local suerte = math.random(1,9)
		local ra = math.random(30000,40000)
		local e = math.random(10,50)
		local pe = math.random(1,7)	
		local suerte1 = math.random(1,4)
		local exp = thePlayer:getData("Roleplay:ExpJobPescador") or 1
		local exp1 = math.random(1,3)
		local exp2 = exp1 + exp

	if suerte == 1 then
	 outputChatBox("Has encontrado #FF00FF"..pe.." sombreros #FFFFFFvendelos para ganar dinero",thePlayer,255,255,255,true)
	  outputChatBox("#FF0000-1 cebo,#FF00FF+"..pe.." sombreros",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Sombrero", getPlayerItem(thePlayer,  "Sombrero")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)

	elseif suerte == 2 then
	 outputChatBox("Has encontrado #FF00FF"..pe.." botas #FFFFFFvendelas para ganar dinero",thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#FF00FF+"..pe.." botas",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Bota", getPlayerItem(thePlayer,  "Bota")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)

	elseif suerte == 4 then
	 outputChatBox("Has encontrado #FF00FF"..pe.." condones #FFFFFFvendelos para ganar dinero",thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#FF00FF+"..pe.." condones",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Condon", getPlayerItem(thePlayer,  "Condon")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)

	elseif suerte == 5 then
	 outputChatBox("Has encontrado #00FFFF"..pe.." pescados #FFFFFFvendelos para ganar dinero",thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#00FFFF+"..pe.." pescados",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Pescado", getPlayerItem(thePlayer, "Pescado")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)
	
	if (exp2 <= 20) then
	if suerte1 == 2 then
		text = "Acabas de obtener #E511E8"..exp1.." #ffffffexperiencia por trabajar."
		thePlayer:setData("Roleplay:ExpJobPescador",exp2)
	else
		text = ""
	end
	thePlayer:outputChat(text, 255, 255, 255, true)
	else
	thePlayer:outputChat("Has llegado a #E511E8 20 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
	end

	elseif suerte == 7 then
	 outputChatBox("Has encontrado #00FFFF"..pe.." pescados #FFFFFFvendelos para ganar dinero",thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#00FFFF+"..pe.." pescados",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Pescado", getPlayerItem(thePlayer, "Pescado")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)
	if (exp2 <= 20) then
	if suerte1 == 2 then
		text = "Acabas de obtener #E511E8"..exp1.." #ffffffexperiencia por trabajar."
		thePlayer:setData("Roleplay:ExpJobPescador",exp2)
	else
		text = ""
	end
	thePlayer:outputChat(text, 255, 255, 255, true)
	else
	thePlayer:outputChat("Has llegado a #E511E8 20 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
	end
	elseif suerte1 == 2 then
	 outputChatBox("Has encontrado #00FFFF+"..pe.." pescados #FFFFFFvendelos para ganar dinero",thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#00FFFF+"..pe.." pescados",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerItem(thePlayer, "Pescado", getPlayerItem(thePlayer,  "Pescado")+pe)
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)
	if (exp2 <= 20) then
	if suerte1 == 2 then
		text = "Acabas de obtener #E511E8"..exp1.." #ffffffexperiencia por trabajar."
		thePlayer:setData("Roleplay:ExpJobPescador",exp2)
	else
		text = ""
	end
	thePlayer:outputChat(text, 255, 255, 255, true)
	else
	thePlayer:outputChat("Has llegado a #E511E8 20 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
	end



	elseif suerte == 3 then
	 outputChatBox("Has encontrado #00FF00"..e.." dolares" ,thePlayer,255,255,255,true)
	outputChatBox("#FF0000-1 cebo,#00FF00+"..e.." dolares",thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	setPlayerMoney(thePlayer, getPlayerMoney(thePlayer)+e) 
	setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)

	else 
	 outputChatBox("#0DF2C4No has encontrado nada" ,thePlayer,255,255,255,true)
	setPlayerItem(thePlayer, "Cebo", getPlayerItem(thePlayer,  "Cebo")-1)
	outputChatBox("#FF0000-1 sebo",thePlayer,255,255,255,true)

	
		     setElementFrozen( thePlayer, false )
			setPedAnimation (thePlayer)
	end
	end,40000, 1,thePlayer )

		end
	end
end
addCommandHandler("pescar", pescar)
local objetos = {

["Bota"] = "Bota",

["Pescado"] = "Pescado",

["Condon"] = "Condon",

["Sombrero"] = "Sombrero",
}

local pickup2 = Marker(2947.2841796875, -1524.806640625, 1.5488405227661-1,"cylinder",4,255,255,255,50)

function vender(p,cmd,msg,cant)
local id = table.concat({msg}, " ")
    if isElementWithinMarker(p,pickup2) then
	if tonumber(cant) then
		if id ~="" and id ~=" " then
			local tick = getTickCount()
				p:outputChat("Espera 10 segundos para vender", 150, 0, 0, true)
			end
			local s = trunklateText( p, id )
			local sse = getPlayerItem(p,s) or 0
			local exp = p:getData("Roleplay:ExpJobPescador") or 1
			if s:find(tostring(objetos[s])) then
			local ss = getPlayerItem(p,s) or 0
			if tonumber(cant) >= 1 and tonumber(cant) <= tonumber(ss) then
			p:outputChat("#FFFFFFAcabas de vender #FF0033"..cant.." "..s, 0, 150, 0, true)
			setPlayerItem(p,s, getPlayerItem(p,s)-cant)
				if s == "Pescado" then
				local money = cant * "30" 
				setPlayerMoney(p,getPlayerMoney(p)+money*exp/2)
				p:outputChat("#FFFFFFAcabas de optener #00FF00"..money.." dolares", 0, 150, 0, true)
				elseif s == "Bota" then
				local money1 = cant * "5"
				setPlayerMoney(p,getPlayerMoney(p)+money1)
				p:outputChat("#FFFFFFAcabas de optener #00FF00"..money1.." dolares", 0, 150, 0, true)
				elseif s == "Condon" then
				local money1 = cant * "5"
				setPlayerMoney(p,getPlayerMoney(p)+money1)
				p:outputChat("#FFFFFFAcabas de optener #00FF00"..money1.." dolares", 0, 150, 0, true)
				elseif s == "Sombrero" then
				local money1 = cant * "5"
				setPlayerMoney(p,getPlayerMoney(p)+money1)
				p:outputChat("#FFFFFFAcabas de optener #00FF00"..money1.." dolares", 0, 150, 0, true)

				end
			else
			p:outputChat("No tienes esa cantidad de objetos", 255, 0, 255, true)
			end
			else
				p:outputChat("Solamente puedes vender estos objetos: ", 150, 50, 50, true)
				for i, v in pairs(objetos) do
					p:outputChat(objetos[i], 20, 50, 20, true)
				print(vender)
			
			end	
		end
	end
end
end
addCommandHandler("vender",vender)



