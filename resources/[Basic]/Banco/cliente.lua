
local BancoWin = false
local Bancodepos = false
local Bancoreti = false


    depos = guiCreateButton(0.29, 0.44, 0.19, 0.10, "depositar", true)
    guiSetAlpha(depos, 0.00)
    reti = guiCreateButton(0.53, 0.44, 0.19, 0.10, "Retirar", true)
    guiSetAlpha(reti, 0.00)
    envia = guiCreateButton(0.29, 0.58, 0.19, 0.08, "enviar dinero", true)
    guiSetAlpha(envia, 0.00)
    cerrar = guiCreateButton(0.53, 0.58, 0.19, 0.08, "cerrar", true)
    guiSetAlpha(cerrar, 0.00)
    depos2 = guiCreateButton(0.09, 0.53, 0.08, 0.04, "Depositar", true)
    guiSetFont(depos2, "default-bold-small")
    guiSetProperty(depos2, "NormalTextColour", "F8FEFEFE")
    reti2 = guiCreateButton(0.84, 0.52, 0.08, 0.04, "Retirar", true)
    guiSetFont(reti2, "default-bold-small")
    guiSetProperty(reti2, "NormalTextColour", "F8FEFEFE")
    Cantidad2 = guiCreateEdit(0.07, 0.45, 0.12, 0.04, "Cantidad", true)
    Cantidad3 = guiCreateEdit(0.82, 0.45, 0.12, 0.04, "Cantidad", true)    
 

    guiSetVisible(depos,false)
    guiSetVisible(reti,false)
    guiSetVisible(envia,false)
    guiSetVisible(cerrar,false)
    guiSetVisible(depos2,false)
    guiSetVisible(reti2,false)
    guiSetVisible(Cantidad2,false)
    guiSetVisible(Cantidad3,false)


local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
    	if (BancoWin == true) then
	        dxDrawRectangle(screenW * 0.2797, screenH * 0.2889, screenW * 0.4578, screenH * 0.4083, tocolor(28, 28, 28, 248), false)
	        dxDrawText("Banco de Los Santos", screenW * 0.3594, screenH * 0.3028, (screenW * 0.3594) + 383, ( screenH * 0.3028) + 30, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	        dxDrawLine(screenW * 0.2789,  screenH * 0.3583, (screenW * 0.2789) + 585, ( screenH * 0.3583) + 0, tocolor(255, 255, 255, 255), 2, false)
	        dxDrawRectangle(screenW * 0.2938, screenH * 0.4361, screenW * 0.1898, screenH * 0.1028, tocolor(79, 76, 76, 248), false)
	        dxDrawRectangle(screenW * 0.5344, screenH * 0.4361, 243, 74, tocolor(79, 76, 76, 248), false)
	        dxDrawRectangle(screenW * 0.2938, screenH * 0.5806, 243, 55, tocolor(79, 76, 76, 248), false)
	        dxDrawRectangle(screenW * 0.5344, screenH * 0.5806, 243, 55, tocolor(79, 76, 76, 248), false)
	        dxDrawText("Depositar", screenW * 0.2938, screenH * 0.4500, screenW * 0.4836, screenH * 0.5194, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
	        dxDrawText("Retirar", screenW * 0.5344, screenH * 0.4500, (screenW * 0.5344) + 243, ( screenH * 0.4500) + 50, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
	        dxDrawText("Enviar Dinero", screenW * 0.2938, screenH * 0.5944, (screenW * 0.2938) + 243, ( screenH * 0.5944) + 32, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	        dxDrawText("Cerrar", screenW * 0.5344, screenH * 0.5944, (screenW * 0.5344) + 243, ( screenH * 0.5944) + 32, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	    end
	    if (Bancodepos == true) then
	        dxDrawRectangle(screenW * 0.0320, screenH * 0.3583, screenW * 0.2047, screenH * 0.2319, tocolor(28, 28, 28, 248), false)
	        dxDrawLine(screenW * 0.2797, screenH * 0.4750, screenW * 0.2375, screenH * 0.4750, tocolor(255, 255, 255, 255), 3, false)       
	        dxDrawText("Depositar", screenW * 0.0742, screenH * 0.3722, screenW * 0.1930, screenH * 0.4111, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	    end
	    if (Bancoreti == true) then    
	        dxDrawRectangle(screenW * 0.7797, screenH * 0.3583, screenW * 0.2047, screenH * 0.2319, tocolor(28, 28, 28, 248), false)
	        dxDrawLine(screenW * 0.7797, screenH * 0.4736, screenW * 0.7375, screenH * 0.4736, tocolor(255, 255, 255, 255), 3, false)
	        dxDrawText("Retirar", screenW * 0.8227, screenH * 0.3722, screenW * 0.9414, screenH * 0.4111, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
   		end
    end
)

addEventHandler("onClientGUIClick",resourceRoot,function()
	if source == cerrar then
		triggerEvent("verbancowin",localPlayer)
	elseif source == depos then
		Bancodepos = true
		guiSetVisible(depos2,true)
 		guiSetVisible(Cantidad2,true)
 		--
 		Bancoreti = false
		guiSetVisible(reti2,false)
 		guiSetVisible(Cantidad3,false)

 	elseif source == reti then
 		Bancoreti = true
		guiSetVisible(reti2,true)
 		guiSetVisible(Cantidad3,true)
 		--
 		Bancodepos = false
		guiSetVisible(depos2,false)
 		guiSetVisible(Cantidad2,false)
 	elseif source == depos2 then 
 		if (guiGetText(Cantidad2) ~= "") then
 			setEnabled(depos2, 2000)
 			triggerServerEvent("Banco:Depositar",localPlayer,guiGetText(Cantidad2))
 		else
 			outputChatBox("Pon una cantidad primero para depositar",255,0,0,true)
 		end
 	elseif source == reti2 then
 		if (guiGetText(Cantidad3) ~= "") then
 			setEnabled(reti2, 2000)
 			triggerServerEvent("Banco:Retirar",localPlayer,guiGetText(Cantidad3))
 		else
 			outputChatBox("Pon una cantidad primero para retirar",255,0,0,true)
 		end
	end
end)



addEvent("verbancowin",true)
addEventHandler("verbancowin",root,function()
	if (BancoWin == false) then
		BancoWin = true
		showCursor(true)
		guiSetVisible(depos,true)
    	guiSetVisible(reti,true)
    	guiSetVisible(envia,true)
   	 	guiSetVisible(cerrar,true)
   	else
   		BancoWin = false
   		Bancodepos = false
   		Bancoreti = false
		showCursor(false)
	   	guiSetVisible(depos,false)
	    guiSetVisible(reti,false)
	    guiSetVisible(envia,false)
	    guiSetVisible(cerrar,false)
	    guiSetVisible(depos2,false)
	    guiSetVisible(reti2,false)
	    guiSetVisible(Cantidad2,false)
	    guiSetVisible(Cantidad3,false)
   	end
end)




addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in ipairs(getTableATM()) do
		atmobject = Object( 2942, v[1], v[2], v[3]-0.9 )
		setObjectBreakable(atmobject, false)
		atmobject:setRotation( 0, 0, (360-v.rot) )
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getTableATM()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 10 then
				dxDrawBorderedText3 ( "Cajero Automatico\n#FF4800/fondo\n/banco", sx, sy, sx, sy , tocolor (0, 255, 0, 255/distance ),2/distance*1, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end