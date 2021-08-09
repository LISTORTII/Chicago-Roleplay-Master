function destruir (player, cmd, victimaName)
	if victimaName then
	local victima = getPlayerFromName (""..victimaName.."")
		if victimaName ~= getPlayerName(player) then
			if victima then
				local xp, yp, zp = getElementPosition (player)
				triggerClientEvent (getRootElement (), "onHakaiStart", victima, xp, yp, zp)
				outputChatBox ("#FFFFFF"..getPlayerName(player).." de la destrucción: #FF0000Hakai!", root, 0, 0, 0, true)
				setPedAnimation(player,'WUZI','CS_Wuzi_pt1',0,false,true,false,true)
				setTimer (setPedAnimation, 8000, 1, player,'ped','turn_180',0,false,true,false,true)
				setElementAlpha (victima, 200)
				setTimer (setElementAlpha, 3000, 1, victima, 150)
				setTimer (setElementAlpha, 6000, 1, victima, 100)
				setTimer (setElementAlpha, 8500, 1, victima, 50)
				setTimer (setElementAlpha, 10000, 1, victima, 0)
				setSkyGradient (150, 0, 180)
				setTimer (triggerEvent, 13000, 1, "onHakaiEnd", victima)
			else
			outputChatBox ("No hay nada para destruir.", player, 255, 0, 0, false)
			end
		else
		outputChatBox ("No puedes autodestruirte.", player, 255, 0, 0, false)
		end
	else
	outputChatBox ("No hay nada para destruir.", player, 255, 0, 0, false)
	end
end
addCommandHandler ("hakai", destruir)

addEvent ("onHakaiEnd", true)
function terminar ()
	resetSkyGradient ()
	setElementFrozen (source, false)
	setElementAlpha (source, 255)
end
addEventHandler ("onHakaiEnd", getRootElement (), terminar)