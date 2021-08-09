addEventHandler("onClientResourceStart", resourceRoot, function()
	p = Pickup(240.4521484375, 112.7783203125, 1003.21875, 3, 1239, 0 )
	p:setInterior(10)
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	local playerX, playerY, playerZ = 240.4521484375, 112.7783203125, 1003.21875
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ( "Aquí puedes comprar la licencia de armas por #00FF00$2500\n#FFFFFFUsa #00FF00/portearma", sx, sy, sx, sy , tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
end)