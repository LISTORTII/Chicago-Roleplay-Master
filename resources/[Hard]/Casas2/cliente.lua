
wincasa = guiCreateWindow(0.11, 0.31, 0.76, 0.34, "Crear Casas ", true)
guiWindowSetSizable(wincasa, false)

img = guiCreateStaticImage(0.66, 0.19, 0.33, 0.66, "data/images/choose.jpg", true, wincasa)
listacasas = guiCreateGridList(0.43, 0.09, 0.22, 0.87, true, wincasa)
guiGridListAddColumn(listacasas, "ID", 0.2)
guiGridListAddColumn(listacasas, "Interior", 0.6)
Edit5 = guiCreateEdit(0.02, 0.32, 0.04, 0.12, "", true, wincasa)
Edit6 = guiCreateEdit(0.07, 0.32, 0.04, 0.12, "", true, wincasa)
Edit7 = guiCreateEdit(0.12, 0.32, 0.04, 0.12, "", true, wincasa)
Edit1 = guiCreateEdit(0.22, 0.32, 0.04, 0.12, "", true, wincasa)
Edit2 = guiCreateEdit(0.27, 0.32, 0.04, 0.12, "", true, wincasa)
	Edit3 = guiCreateEdit(0.32, 0.32, 0.04, 0.12, "", true, wincasa)
Edit4 = guiCreateEdit(0.37, 0.32, 0.04, 0.12, "", true, wincasa)
mip = guiCreateButton(0.02, 0.47, 0.14, 0.13, "Mi Posicion", true, wincasa)
guiSetFont(mip, "default-bold-small")
guiSetProperty(mip, "NormalTextColour", "FFFFFFFF")
set = guiCreateButton(0.22, 0.47, 0.14, 0.13, "Set --->", true, wincasa)
guiSetFont(set, "default-bold-small")
guiSetProperty(set, "NormalTextColour", "FFFFFFFF")
precio = guiCreateEdit(0.02, 0.82, 0.12, 0.11, "", true, wincasa)
crearcasa = guiCreateButton(0.19, 0.82, 0.15, 0.14, "Crear Casa", true, wincasa)
guiSetFont(crearcasa, "default-bold-small")
guiSetProperty(crearcasa, "NormalTextColour", "FFFFFFFF")
cerrar = guiCreateButton(0.37, 0.82, 0.05, 0.14, "X", true, wincasa)
guiSetFont(cerrar, "default-bold-small")
guiSetProperty(cerrar, "NormalTextColour", "FFD50000")
labelpos = guiCreateLabel(0.03, 0.12, 0.12, 0.08, "Mi posicion", true, wincasa)
guiSetFont(labelpos, "default-bold-small")
guiLabelSetHorizontalAlign(labelpos, "center", false)
guiLabelSetVerticalAlign(labelpos, "center")
labelint = guiCreateLabel(0.24, 0.13, 0.12, 0.08, "Interior", true, wincasa)
guiSetFont(labelint, "default-bold-small")
guiLabelSetHorizontalAlign(labelint, "center", false)
guiLabelSetVerticalAlign(labelint, "center")
labelcash = guiCreateLabel(0.02, 0.72, 0.12, 0.08, "Precio", true, wincasa)
guiSetFont(labelcash, "default-bold-small")
guiLabelSetHorizontalAlign(labelcash, "center", false)
guiLabelSetVerticalAlign(labelcash, "center") 
guiSetVisible(wincasa,false)

local houseInteriors = {
	[1] = "223.0538482666, 1287.3552246094, 1082.140625, 1, Shitty house 1",
	[2] = "2233.6594238281, -1114.9837646484, 1050.8828125, 5, Hotel room 1",
	[3] = "2365.22265625, -1135.5612792969, 1050.8825683594, 8, Modern house 1",
	[4] = "2282.9401855469, -1140.1246337891, 1050.8984375, 11, Hotel room 2",
	[5] = "2196.7075195313, -1204.3569335938, 1049.0234375, 6, Modern house 2",
	[6] = "2270.0834960938, -1210.4854736328, 1047.5625, 10, Modern house 3",
	[7] = "2308.755859375, -1212.5498046875, 1049.0234375, 6, Shitty house 2",
	[8] = "2217.7729492188, -1076.2110595703, 1050.484375, 1, Hotel room 3",
	[9] = "2237.5009765625, -1080.9367675781, 1049.0234375, 2, Good house 1",
	[10] = "2317.7609863281, -1026.4268798828, 1050.2177734375, 9, Good Stair house 1",
	[11] = "261.05038452148, 1284.7646484375, 1080.2578125, 4, Goood house 2",
	[12] = "140.18000793457, 1366.7183837891, 1083.859375, 5, Modern house 4(Rich)",
	[13] = "83.037002563477, 1322.6156005859, 1083.8662109375, 9, Good Stair house 2",
	[14] = "-283.92623901367, 1471.0096435547, 1084.375, 15, Good Stair house 3",
	[15] = "-261.03778076172, 1456.6539306641, 1084.3671875, 4, Good Stair house 4",
	[16] = "-42.609268188477, 1405.8033447266, 1084.4296875, 8, Shitty house 3",
	[17] = "-68.839866638184, 1351.4775390625, 1080.2109375, 6, Shitty house 4",
	[18] = "2333.068359375, -1077.0648193359, 1049.0234375, 6, Shitty house 5",
	[19] = "1261.1168212891, -785.38037109375, 1091.90625, 5, Mad Doggs Mansion",
	[20] = "2215.1145019531, -1150.4993896484, 1025.796875, 15, Jefferson Motel",
	[21] = "2352.4575195313, -1180.9454345703, 1027.9765625, 5, Burning desire house(Buggy)",
	[22] = "421.94845581055, 2536.5021972656, 10, 10, Abandoned Tower",
	[23] = "2495.9753417969, -1692.4174804688, 1014.7421875, 3, Johnson house",
	[24] = "-2158.7209472656, 642.83074951172, 1052.375, 1, Bet Interior",
	[25] = "1701.1682128906, -1667.759765625, 20.21875, 18, Atrium lobby",
	[26] = "2324.499, -1147.071, 1050.71, 12, Modern House 5(Rich)",
	[27] = "244.411987,305.032989,999.148437, 1, 1 Room house",
	[28] = "271.884979,306.631988,999.148437, 2, 1 Room house",
	[29] = "302.180999,300.722991,999.148437, 4, 1 Room house",
}


addEvent("vercasa",true)
addEventHandler("vercasa",root,function()
	guiSetVisible(wincasa,true)
	showCursor(true)
	for i = 1, #houseInteriors, 1 do
		local row = guiGridListAddRow(listacasas)
		guiGridListSetItemText(listacasas, row, 1, i, false, false)
		guiGridListSetItemText(listacasas, row, 2, gettok(houseInteriors[i], 5, string.byte(",")), false, false)
	end
end)

addEventHandler("onClientGUIClick",getRootElement(),function()
	if source == cerrar then
		guiSetVisible(wincasa,false)
		showCursor(false)
	elseif source == listacasas then
		local text = guiGridListGetItemText(listacasas, guiGridListGetSelectedItem(listacasas), 1)
		if(text == "") or (text == " ") then
			guiStaticImageLoadImage(img, "data/images/choose.jpg")
		else
			guiStaticImageLoadImage(img, "data/images/"..text..".jpg")
		end
	elseif source == set then
		local id = tonumber(guiGridListGetItemText(listacasas, guiGridListGetSelectedItem(listacasas), 1))
		if(id ~= nil) then 
			local text = houseInteriors[id]
			local x, y, z, int = gettok(text, 1, string.byte(",")), gettok(text, 2, string.byte(",")), gettok(text, 3, string.byte(",")), gettok(text, 4, string.byte(","))
			guiSetText(Edit1, x)
			guiSetText(Edit2, y)
			guiSetText(Edit3, z)
			guiSetText(Edit4, int)
		else
			outputChatBox("[ERROR] Elije un interior primero",255,50,50,true)
		end
	elseif source == mip then
		local x1, y1, z1 = getElementPosition(localPlayer)
		guiSetText(Edit5, x1)
		guiSetText(Edit6, y1)
		guiSetText(Edit7, z1)
	elseif source == crearcasa then
		local x, y, z, intx, inty, intz, int, price = guiGetText(Edit5), guiGetText(Edit6), guiGetText(Edit7), guiGetText(Edit1), guiGetText(Edit2), guiGetText(Edit3), guiGetText(Edit4), guiGetText(precio)
		if(x ~= "") or (y ~= "") or (z ~= "") or (intx ~= "") or (inty ~= "") or (intz ~= "") then
			if tonumber(price) >= 0 then
				triggerServerEvent("crearcasa", localPlayer, x, y, z, int, intx, inty, intz, price)
			else
				outputChatBox("[ERROR] Precio invalido",255,50,50,true)	
			end
		else
			outputChatBox("[ERROR] Rellena todos los campos primero",255,50,50,true)
		end
	end
end)