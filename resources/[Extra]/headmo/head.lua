local cabeza = true


addEventHandler("onClientRender", getRootElement(), function()
	if cabeza == true then
		for k,player in ipairs(getElementsByType("player")) do
			if getElementHealth(player) >= 1 then
				local width, height = guiGetScreenSize ()
				local lx, ly, lz = getWorldFromScreenPosition ( width/2, height/2, 7 )
				setPedLookAt(player, lx, ly, lz)
			end 
		end
	end
end)

addCommandHandler("cabeza",function()
	if cabeza == true then
		cabeza = false
		outputChatBox("Has desabilitado el movimiento de cabeza",255,50,50,true)
	else
		cabeza = true
		outputChatBox("Has habilitado el movimiento de cabeza",50,255,50,true)
	end
end)

