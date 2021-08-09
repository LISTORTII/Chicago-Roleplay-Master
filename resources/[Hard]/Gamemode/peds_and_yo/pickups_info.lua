local pickups_infos = {



					  { info = "(( #FF9000Importante: Ve al ayuntamiento si eres nuevo en la ciudad\n ahi­ conseguiras tarjeta de credito/debito #FFFFFF))", 1738.861328125, -1860.8427734375, 13.578242301941, r = 255, g = 255, b = 255, font = "default-bold" },



					  { info = "(( #FF9000Chicago Roleplay 1.0 [Beta] #FFFFFF))", 1748.123046875, -1860.3330078125, 13.578864097595, r = 255, g = 255, b = 255, font = "default-bold" },
					  
					  
					  { info = "/veh ", 1395.21484375, 6.1240234375, 1000.9159545898, r = 255, g = 255, b = 255, font = "default-bold" },
					  
					  { info = "#FF9000/borrarveh", 1402.365234375, 4.26953125, 1000.9075927734, r = 255, g = 255, b = 255, font = "default-bold" },


                      --{ info = "(( ¡Renta tu vehículo, recuerda mantenerlo en buen estado! ))", 1552.7998046875, -2317.5673828125, 13.542904853821, r = 255, g = 255, b = 255, font = "arial" },


					  { info = "#FF9000Para contactar con un taxista, llame al\n#FFFFFF/555",  1740.6474609375, -1849.7041015625, 13.581506729126, r = 255, g = 255, b = 255, font = "default-bold"  },



					  { info = "#FF9000Si aún no entiendes nada del servidor\n#FFFFFF/ayuda", 1744.6435546875, -1849.3154296875, 13.581127166748, r = 255, g= 255, b = 255, font= 'default-bold'},

					  }



addEventHandler("onClientResourceStart", resourceRoot, function()

	for i, v in pairs( pickups_infos ) do


		Pickup( v[1], v[2], v[3], 3, 1239, 0 )

	end

end)


addEventHandler("onClientRender", getRootElement(), function()



	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )



	for k, v in pairs(pickups_infos) do



		local playerX, playerY, playerZ = v[1], v[2], v[3]



		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)



		if sx and sy then



			local cx, cy, cz = getCameraMatrix()



			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)



			if distance < 20 then



				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 



			end



		end



	end



end)







function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )



	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)



	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)



end







local posxD = {



			  {359.03103637695, 168.09060668945, 1008.3828125, "#FFA600/obtenerdni\n#FFFFFFSaca un documento de identificacion"},



			  {361.82989501953, 173.6374206543, 1008.3828125, "#FFA600/obtenertarjeta\n#FFFFFFSaca una tarjeta de credito para guardar tu dinero"},



			  }







addEventHandler("onClientRender", getRootElement(), function()


	if localPlayer:getInterior() == 3 and localPlayer:getDimension() == 0 then

	for k, v in ipairs(posxD) do



		tx, ty, tz = v[1], v[2], v[3]



		local px, py, pz = getElementPosition(localPlayer)



		dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )



		if dist < 10 then



			if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then



				local sx, sy, sz = v[1], v[2], v[3]



				local x, y = getScreenFromWorldPosition( sx, sy, sz)



				if x and y then



					BorderedText ( tostring(v[4]), x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 253, 206, 97, 255 ),1, "default-bold","center", "center", false, false, false, true, false )



				end



			end



		end



	end

	end

end)







function BorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )



	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)



	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)



	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)



end