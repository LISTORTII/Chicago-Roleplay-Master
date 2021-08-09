local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local ValoresTrabajo = {}

local PosicionAuto = {}

local MarcadoresRuta = {}

local BlipsRuta = {}

local PedsRuta = {}

local TimerK = {}

local tableN = {}


addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsCarpintero()) do

		local playerX, playerY, playerZ = v[1], v[2], v[3]

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end

addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition( 2404.55859375, -1316.384765625, 25.2601146698, 0, true )
		local dist = getDistanceBetweenPoints3D(   2404.55859375, -1316.384765625, 25.2601146698, getElementPosition(localPlayer) )

		if x and dist <= 10 then
			x = x - (dxGetTextWidth( 'click izquierdo', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('click izquierdo', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)

addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition( 2402.4873046875, -1306.521484375, 25.387882232666, 0, true )
		local dist = getDistanceBetweenPoints3D(2402.4873046875, -1306.521484375, 25.387882232666, getElementPosition(localPlayer) )

		if x and dist <= 10 then
			x = x - (dxGetTextWidth( 'click izquierdo para construir', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('click izquierdo para construir', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para construir', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para construir', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)


addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(2398.861328125, -1306.4384765625, 25.514459609985, 0, true )
		local dist = getDistanceBetweenPoints3D(2398.861328125, -1306.4384765625, 25.514459609985, getElementPosition(localPlayer) )

		if x and dist <= 10 then
			x = x - (dxGetTextWidth( 'click izquierdo para construir', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('click izquierdo para construir', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para construir', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para construir', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)

addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(2392.9853515625, -1305.6875, 25.553792953491, 0, true )
		local dist = getDistanceBetweenPoints3D(2392.9853515625, -1305.6875, 25.553792953491, getElementPosition(localPlayer) )

		if x and dist <= 10 then
			x = x - (dxGetTextWidth( 'click izquierdo para vender', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('click izquierdo para vender', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para vender', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('click izquierdo para vender', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)


