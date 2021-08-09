loadstring(exports.dgs:dgsImportFunction())()
loadstring(exports.dgs:dgsImportOOPClass(true))()

local sx,sy = GuiElement.getScreenSize()
local sw,sh = sx*(1/1024), sy*(1/768)
local font = DxFont('files/PantonDemo-Light.otf', 15)
local font2 = DxFont('files/PantonDemo-Light.otf', 10)
local dgsY = 0.07

local pjsTemp = {
	key = 1
}
local pjDatos = { 
	name = '',
	edad = 18,
	nacionalidad = '',
	miSexo = 'Masculino',
	clave = '',
	next = false,
}

Datos = {   edit = {},   button = {},   window = {},   label = {}   }

Datos.window[1] = dgsWindow(0.55, 0.32-dgsY, 0.31, 0.26, "Creación de Personaje", true)
Datos.window[1]:setSizable(false)
Datos.window[1].visible = false
Datos.window[1]:setAlpha(0)
--
Datos.label[1] = Datos.window[1]:dgsLabel(0.09, 0.14-dgsY, 0.31, 0.08, "Nombre Apellido", true)
Datos.label[1]:setHorizontalAlign("center", false)
Datos.label[1]:setFont(font2)
Datos.edit[1] = Datos.window[1]:dgsEdit(0.04, 0.26-dgsY, 0.40, 0.12, "", true)
--
Datos.label[2] = Datos.window[1]:dgsLabel(0.60, 0.14-dgsY, 0.31, 0.08, "Edad", true)
Datos.label[2]:setHorizontalAlign("center", false)
Datos.label[2]:setFont(font2)
Datos.edit[2] = Datos.window[1]:dgsEdit(0.55, 0.26-dgsY, 0.40, 0.12, "", true)
--
Datos.label[3] = Datos.window[1]:dgsLabel(0.34, 0.44-dgsY, 0.31, 0.08, "Nacionalidad", true)
Datos.label[3]:setHorizontalAlign("center", false)
Datos.label[3]:setFont(font2)
Datos.edit[3] = Datos.window[1]:dgsEdit(0.295, 0.54-dgsY, 0.40, 0.12, "", true)
--
Datos.button[1] = Datos.window[1]:dgsButton(0.2, 0.82-dgsY*2, 0.6, 0.13, "Siguiente", true)
Datos.button[1]:setFont(font2)
--
dgsSex = {   button = {},   window = {}   }

dgsSex.window[1] = dgsWindow(0.54, 0.35-dgsY, 0.40, 0.20, "Selecciona tu Sexo", true, nil, nil, nil, nil, nil, nil, nil, true)
dgsSex.window[1]:setSizable(false)
dgsSex.window[1]:setFont(font2)
dgsSex.window[1].visible = false
--
dgsSex.button[1] = dgsSex.window[1]:dgsButton(0.05, 0.24-dgsY*2, 0.44, 0.35, "Masculino", true)
dgsSex.button[1]:setFont(font2)
dgsSex.button[1]:setProperty("textColor", tocolor(0,240,0))
--
dgsSex.button[2] = dgsSex.window[1]:dgsButton(0.51, 0.24-dgsY*2, 0.44, 0.35, "Femenino", true)
dgsSex.button[2]:setFont(font2)
dgsSex.button[2]:setProperty("textColor", tocolor(243,0,176))
--
dgsSex.button[3] = dgsSex.window[1]:dgsButton(0.28, 0.69-dgsY*2, 0.44, 0.24, "Siguiente", true)
dgsSex.button[3]:setFont(font2)
--
dgsSkin = {   }

dgsSkin[1] = dgsButton(0.495, 0.62, 0.08, 0.04, ">", true)
dgsSkin[1]:setFont(font2)
--
dgsSkin[2] = dgsButton(0.315, 0.62, 0.08, 0.04, "<", true)
dgsSkin[2]:setFont(font2)
--
dgsSkin[3] = dgsButton(0.37, 0.67, 0.15, 0.04, "Seleccionar Skin", true)
dgsSkin[3]:setFont(font2)

for i = 1,3 do
	dgsSkin[i].visible = false
end

dgsPass = { window={}, label={}, button={}, edit={} }

dgsPass.window[1] = dgsWindow(0.36, 0.42-dgsY, 0.28, 0.16, "", true, nil, nil, nil, nil, nil, nil, nil, true)
dgsPass.window[1]:setSizable(false)
dgsPass.window[1]:setVisible(false)
--
dgsPass.label[1] = dgsPass.window[1]:dgsLabel(0.29, 0.21-dgsY*2.2, 0.43, 0.14, "Ingrese su contraseña", true)
dgsPass.label[1]:setHorizontalAlign("center", false)
dgsPass.label[1]:setFont(font2)
--
dgsPass.edit[1] = dgsPass.window[1]:dgsEdit(0.17, 0.40-dgsY*2.1, 0.66, 0.21, "", true)
dgsPass.edit[1]:setMasked(true)
--
dgsPass.button[1] = dgsPass.window[1]:dgsButton(0.24, 0.70-dgsY*2.5, 0.52, 0.22, "Iniciar", true)    
dgsPass.button[1]:setFont(font2)
---
editPass = GuiEdit(sx*0.51, sy*0.82, sx*0.17, sy*0.038, '', false)
editPass.visible = false
editPass:setMasked(true)

local Skins = {
    Masculino = {0, 1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 51, 52, 57, 58, 59, 60, 62, 68, 72, 73, 78, 79, 80, 98, 102, 103, 104, 105, 106, 107, 108, 109, 110, 114, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 179, 180, 181, 182, 183, 184, 185, 186, 187, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 220, 221, 222, 223, 227, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 270, 271, 290, 291, 292, 293, 294, 295, 296, 297, 299, 301, 302, 306, 307, 308, 309, 310, 311, 312},
    Femenino = {9, 10, 11, 12, 13, 31, 38, 40, 41, 53, 55, 56, 63, 64, 69, 89, 91, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 215, 216, 218, 219, 224, 225, 226, 231, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 304},

    selected = false,
    index = false,

}

local change = {
    Masculino = 0,
    Femenino = 0,
} 

local posPed = {
	{1549.069580078125, -1349.340576171875, 329.4664001464844,tocolor(math.random(1, 255),math.random(1, 255),math.random(1, 255),255)},--tocolor(0,0,0,255)
	{1544.271484375, -1349.340576171875, 329.4694519043,tocolor(math.random(1, 255),math.random(1, 255),math.random(1, 255),255)},--tocolor(120,82,250,255)
	{1539.571484375, -1349.340576171875, 329.4694519043,tocolor(math.random(1, 255),math.random(1, 255),math.random(1, 255),255)},--tocolor(255,0,0,255)
}

--[[local pjs = {
	Ped(217,  1549.069580078125, -1349.340576171875, 329.4664001464844, 3.5129089355469),
	Ped(217,  1544.271484375, -1349.340576171875, 329.4694519043, 5.24),
	Ped(217,  1539.571484375, -1349.340576171875, 329.4694519043, 5.24),
	key = 1,
}]]


function onRender()

	if IniciarCrear then 

	else

		if timerCameraInicial and (getTickCount() - timerCameraInicial) < 8000 then
			return
		end


		dxDrawRectangle( 0, 0, sx, sy*0.06, 0xDF343434, false )
		dxDrawRectangle( 0, 0, sx, sy*0.006, 0xDF037FC6, false )
		dxDrawRecLined( sx/2 - sx*0.17, sy*0.016, sx*0.17, sy*0.038, tocolor(255,255,255,180), 0xDF037FC6, 1.8, false, true)
		dxDrawText2('Crear Personaje', sx/2 - sx*0.17, sy*0.016, sx*0.17, sy*0.038, 0xFF037FC6, tocolor(0,0,0,255), 0.7, font, 'center', 'center')

		dxDrawRecLined( sx/2 + sx*0.01, sy*0.016, sx*0.17, sy*0.038, tocolor(255,255,255,180), 0xDF037FC6, 1.8, false, true)
		dxDrawText2('Salir del Servidor', sx/2 + sx*0.01, sy*0.016, sx*0.17, sy*0.038, 0xFF037FC6, tocolor(0,0,0,255), 0.7, font, 'center', 'center')

		if #pjsTemp > 0 then
			dxDrawRectangle( sx/2 - sx*0.4/2, sy*0.7, sx*0.4, sy*0.18, 0xDF343434, false )
			dxDrawRectangle( sx/2 - sx*0.4/2, sy*0.7, sx*0.4, sy*0.008, 0xDF037FC6, false )
			dxDrawRectangle( sx/2 - sx*0.4/2, sy*0.7+(sy*0.18-sy*0.008), sx*0.4, sy*0.008, 0xDF037FC6, false )

			local nombr = pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][2]:gsub('_', ' ') or ''
			local eda = pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][3] or ''
			local salu = pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][4] or ''
			local zon = pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][5] or {0,0,0}
			local zon = getZoneName(zon[1], zon[2], zon[3], false )
			local mone = pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][6] or ''

			dxDrawText2('Nombre: '..nombr..'\n\nEdad: '..eda..' años\n\nSalud: '..salu..'\n\nUbicación: '..zon..'\n\nDinero: $'..mone, (sx/2 - sx*0.4/2), sy*0.7+sy*0.008, sx*0.2, sy*0.18-(sy*0.008*2), nil, tocolor(255,255,255,255), 0.55, font, 'left', 'center')

			dxDrawRecLined( sx*0.51, sy*0.72, sx*0.08, sy*0.038, tocolor(255,255,255,180), 0xDF037FC6, 1.8, false, true)
			dxDrawText2('<', sx*0.51, sy*0.72, sx*0.08, sy*0.038, 0xDF037FC6, tocolor(255,255,255,255), 0.8, font, 'center', 'center')

			dxDrawRecLined( sx*0.6, sy*0.72, sx*0.08, sy*0.038, tocolor(255,255,255,180), 0xDF037FC6, 1.8, false, true)
			dxDrawText2('>', sx*0.6, sy*0.72, sx*0.08, sy*0.038, 0xDF037FC6, tocolor(255,255,255,255), 0.8, font, 'center', 'center')

			dxDrawRecLined( sx*0.51, sy*0.77, sx*0.17, sy*0.038, tocolor(255,255,255,180), 0xDF037FC6, 1.9, false, true)
			dxDrawText2('Jugar', sx*0.51, sy*0.77, sx*0.17, sy*0.038, 0xDF037FC6, 0xFF000000, 0.8, font, 'center', 'center')

			editPass.visible = true
		end

		if getKeyState'mouse1' and not click then

			if #pjsTemp > 0 then
				if isCursorOver(sx*0.51, sy*0.72, sx*0.08, sy*0.038) then

					local sum = math.max(1, pjsTemp.key-1)
					if pjsTemp.key >= 1 and pjsTemp.key ~= sum then
						pjsTemp.key = sum
						if isElement(pjsTemp[pjsTemp.key][1]) then
							changeCameraPed(pjsTemp[pjsTemp.key][1])
						end
					end
					
				elseif isCursorOver(sx*0.6, sy*0.72, sx*0.08, sy*0.038) then

					local sum = math.min(#pjsTemp, pjsTemp.key+1)
					if pjsTemp.key ~= sum then
						pjsTemp.key = sum
						if isElement(pjsTemp[pjsTemp.key][1]) then
							changeCameraPed(pjsTemp[pjsTemp.key][1])
						end
					end

				elseif isCursorOver(sx*0.51, sy*0.77, sx*0.17, sy*0.038) then-- jugar

					if #editPass:getText() > 0 then
						if pjsTemp[pjsTemp.key] and pjsTemp[pjsTemp.key][2] then
							triggerServerEvent( "Roleplay:LoginPlay", localPlayer, pjsTemp[pjsTemp.key][2]:gsub(' ','_'), editPass:getText())
						end
					else
						triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)
					end
				end

			end
			if isCursorOver(sx/2 - sx*0.17, sy*0.016, sx*0.17, sy*0.038) and #pjsTemp < 3 then-- crear
				if Datos.window[1]:getVisible() == false then

					Datos.window[1]:setVisible(true)
					Datos.window[1]:alphaTo(1,false,"OutQuad",5000)
					editPass:setVisible(false)

					if not isElement(pedCreation) then
			        	pedCreation = Ped(0, -66.086921691895, -4255.1689453125, 3261.4587402344, 270.29251098633)
			        	displayCinematic(1, 50000,nil)
			        	showPedRoling()
			        end
					
					IniciarCrear = true
				end
			elseif isCursorOver(sx/2 + sx*0.01, sy*0.016, sx*0.17, sy*0.038) then -- salir
				triggerServerEvent( "Login:kickPlayer", localPlayer)
			end

		end

	end
	click = getKeyState'mouse1'


end



--addEventHandler( "onClientRender", getRootElement(), onRender)

addEventHandler("onDgsWindowClose", Datos.window[1].dgsElement,
	function ()
		cancelEvent()
		Datos.window[1]:alphaTo(0,false,"OutQuad",1000)
		if not timerV or not timerV:isValid() then
			timerV = Timer(function() Datos.window[1]:setVisible(false)  sourceTimer:destroy() end, 1111, 1)
		end
		--
		removePedRoling()
		displayCinematic(nil)
        --
        if isElement(pedCreation) then
        	pedCreation:destroy()
        end
        --
        onCameraInicial(true)
		timerCameraInicial = getTickCount(  )
        IniciarCrear = false
	end
)


addEventHandler('onDgsMouseClick', root, 
	function(b,s)
		if b == 'left' and s == 'down' then
			if source == Datos.button[1].dgsElement then

				local nombre = Datos.edit[1]:getText()
				local match = nombre:match("(%u%l* %u%l*)")
				if nombre ~="" and nombre ~="Nombre_Apellido" and match then

					local nacion = Datos.edit[3]:getText()
					if #nacion > 0 then

						local edad = tonumber(Datos.edit[2]:getText())
						if edad then
							if edad > 17 and edad < 71 then
								triggerServerEvent('requestInfoLogin', localPlayer, nombre:gsub(' ', '_'))
							else
								triggerEvent("callNotification", localPlayer, "error", "Permitido edades de 18 a 70", true)
							end

						else
							triggerEvent("callNotification", localPlayer, "error", "Por favor, inserte su edad", true)
						end

					else
						triggerEvent("callNotification", localPlayer, "error", "Por favor, inserte su Nacionalidad", true)
					end

				else
					triggerEvent("callNotification", localPlayer, "error", "Por favor, la cuenta debe llevar un Nombre Apellido", true)
				end

			elseif source == dgsSex.button[1].dgsElement then
				pjDatos.miSexo = "Masculino"
				pedCreation.model = 0
			elseif source == dgsSex.button[2].dgsElement then
				pjDatos.miSexo = "Femenino"
				pedCreation.model = 9
			elseif source == dgsSex.button[3].dgsElement then

				Skins.selected = Skins[pjDatos.miSexo][1]
				dgsSex.window[1].visible = false
				--
				forwardPed(2, pedCreation, 1)
				displayCinematic(3, 40000*2)
				--
				Timer(
					function()
						for i = 1,3 do
							dgsSkin[i].visible = true
						end
					end,
				8500,1)
			
			elseif source == dgsSkin[1].dgsElement then -->
				if change[pjDatos.miSexo] < #Skins[pjDatos.miSexo] then
					change[pjDatos.miSexo] = change[pjDatos.miSexo] + 1
					Skins.selected = Skins[pjDatos.miSexo][change[pjDatos.miSexo]]
					pedCreation.model = Skins.selected
				end
				setElementRotation(pedCreation, 0,0, 269.01806640625)
			elseif source == dgsSkin[2].dgsElement then --<
				if change[pjDatos.miSexo] > 1 then
					change[pjDatos.miSexo] = change[pjDatos.miSexo] - 1
					Skins.selected = Skins[pjDatos.miSexo][change[pjDatos.miSexo]]
					pedCreation.model = Skins.selected
				end
				setElementRotation(pedCreation, 0,0,269.01806640625)
			elseif source == dgsSkin[3].dgsElement then --sele
				for i = 1,3 do
					dgsSkin[i].visible = false
				end
				dgsPass.window[1].visible = true
			elseif source == dgsPass.button[1].dgsElement then
				local clave = dgsPass.edit[1]:getText()
				if ( clave ~="" ) then
					if isElement(pedCreation) then
						--
						dgsPass.window[1].visible = false
						setElementRotation(pedCreation, 0,0,-269.01806640625)
						--
						forwardPed(3, pedCreation, 1)
						displayCinematic(4, 100000)
						--
						Timer(
							function()
								if isElement(pedCreation) then
									pedCreation:destroy()
								end
								fadeCamera(false)
								displayCinematic(nil)
								triggerServerEvent("Roleplay:RegisterPlay",localPlayer, pjDatos.name:gsub(' ', '_', 1), clave, Skins.selected, pjDatos.nacionalidad, pjDatos.edad, pjDatos.miSexo)
							end,
						7000,1)
					end
				else
					triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)
				end
			end
		end
	end
)

addEvent('requestInfoLogin', true)
addEventHandler('requestInfoLogin', localPlayer,
	function(tip, bool)
		if tip == 1 then
			if bool then
				pjDatos.name = Datos.edit[1]:getText():match("(%u%l* %u%l*)")
				pjDatos.nacionalidad = Datos.edit[3]:getText()
				pjDatos.edad = tonumber(Datos.edit[2]:getText())
				--
				forwardPed(1, pedCreation, 1)
				displayCinematic(2, 50000*2)
				--
				Datos.window[1]:setAlpha(0)
				Datos.window[1]:setVisible(false)
				--
				Timer(function()
					dgsSex.window[1]:setVisible(true)
				end,14000,1)
			else
				triggerEvent("callNotification", localPlayer, "error", "El nombre del personaje ya existe.", true)
			end
		end
	end
)

addEvent('displayPjOnGround', true)
addEventHandler('displayPjOnGround', localPlayer,
    function(t)
 		for _, v in ipairs(t) do
	    	createPersonajeTemp(unpack(v))
	    end
    end
)

addEvent("Roleplay:DestroyLog", true)
addEventHandler("Roleplay:DestroyLog", root, function(u,d)

	removeEventHandler( "onClientRender", getRootElement(), onRender)
	onCamFinal(pjsTemp[pjsTemp.key][5][1], pjsTemp[pjsTemp.key][5][2], pjsTemp[pjsTemp.key][5][3])

	if isElement(Sonido) then
		stopSound(Sonido)
	end
	if isElement( marker ) then
        marker:destroy()
    end

    setWeather(d[1],d[2])
	setTime(u[1],u[2])
	--triggerEvent("detenerTransicion",localPlayer)
	editPass:setVisible(false)
	IniciarCrear = true
	removePedRoling()
	
	showCursor(false)
	showChat(true)

	guiSetInputEnabled( false )
	destroyAllPersonajeTemp()

end)

addEvent("Roleplay:finishRegister", true)
addEventHandler("Roleplay:finishRegister", root,
	function()
		timerCameraInicial = getTickCount(  )
		onCameraInicial(true)
        IniciarCrear = nil
		fadeCamera(true, 0.5)
		removePedRoling()
	end
)

addEvent('VerifiedTestRol', true)
addEventHandler('VerifiedTestRol', root,
    function(bool)
    	if bool then
		--	iniciarTransicion()
	    	Sonido = Sound("files/music.mp3", true)
			Sonido:setVolume(0.60)

			triggerServerEvent( 'getAccountsSave', resourceRoot)
	        addEventHandler( "onClientRender", getRootElement(), onRender)
	        
	    else
	    	triggerEvent("setVisibleTestRol", root)
	    end

    end
)
addEventHandler('onClientResourceStart', resourceRoot,
    function()
    	triggerServerEvent( "removeTextP", localPlayer )
    	triggerEvent('VerifiedTestRol',root, true)
    	guiSetInputEnabled( true )
        showChat  (false)
        showCursor(true)
        setTime(00,00)
        fadeCamera(true, 0.5)
        setCloudsEnabled ( false )
    	onCameraInicial(true)
    	timerCameraInicial = getTickCount(  )
    end
)


function destroyAllPersonajeTemp()
	local tt = #pjsTemp
	if tt > 0 then
		for i = 1, tt do
			local v = pjsTemp[i]
			if v then
				destroyPersonajeTemp(i, v[1])
			end
		end
	end
end

function destroyPersonajeTemp(i, ped)
	ped:destroy()
	--text:destroy()
	pjsTemp[i] = nil
end

function createPersonajeTemp(name, skin, ...)
	local index = #pjsTemp + 1
	pjsTemp[index] = {Ped(skin,posPed[index][1],posPed[index][2],posPed[index][3], 5.24), name, ...}

end



function table.find(t,c,f)
	for k,v in pairs(t) do
		if f then
			if v[c] == f then
				return k
			end
		else
			if v == c then
				return k
			end
		end
	end
	return false
end