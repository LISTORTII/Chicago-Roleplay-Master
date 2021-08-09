loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')



local text = textCreateDisplay()
local screentext = textCreateTextItem("¡Bienvenido a Chicago Roleplay!\n\nEste es un servidor roleplay.\n...Por favor, espera mientras el servidor se carga...\nNo tardará mucho.\nUna vez terminado podrás disfrutar de\n cientos de horas de diversión.\nGracias por la espera,\n¡Esperamos que la pases genial!\n",0.5,0.2,"medium",255,255,255,255, 2.5, "center", "top", 255)
textDisplayAddText(text,screentext)



addEventHandler("onPlayerJoin", getRootElement(), function()
	textDisplayAddObserver(text, source)
end);

addEvent("removeTextP", true)
addEventHandler("removeTextP", root, 
	function ()
		textDisplayRemoveObserver(text,source)
	end
)


addEvent("getAccountsSave", true)
addEventHandler("getAccountsSave", root, 
	function ()
		local cuentas = query("SELECT * FROM save_system where Serial = ?", client:getSerial())
		local cache = {}
		if #cuentas > 0 then
			for i,v in ipairs(cuentas) do
				local qh = query("SELECT Edad FROM Datos_Personajes where Cuenta = ?", v.Cuenta)
				if qh and #qh > 0 then
					local pos = fromJSON( v.Posiciones )
					cache[i] = {v.Cuenta, tonumber(v.Skin), qh[1].Edad, v.Vida, {pos.x, pos.y, pos.z}, v.Money}
				end
			end
		end
		client:triggerEvent('displayPjOnGround', client, cache)
	end
)

addEvent('requestInfoLogin', true)
addEventHandler('requestInfoLogin', root,
	function(accountname)

		local bool = true
		if Account(accountname) then
			bool = false
		end

		source:triggerEvent('requestInfoLogin', source, 1, bool)
	end
)

function LoginPlayer( user, pass )

	local acc = Account(user, pass)
	if acc ~= false then

		source:setName(user)
		setTimer(logIn, 500, 1, source, acc, pass)
		--source:logIn(acc, pass)

		setTimer(function(source)
			if isElement(source) then
				clearChatBox(source)
				source:outputChat("#DDFFDDSi eres nuevo en el servidor te recomendamos usar #00DD00/empezar", 255, 255, 255, true)
			end
		end, 1000, 1, source)
		--
		setTimer(function(source)
			if isElement(source) then
				clearChatBox(source)
				source:outputChat("#DDFFDD=== Chicago Roleplay V:1.0 ===", 255, 255, 255, true)
				source:outputChat("#DDFFDDFacebook: #0116FCChicago Roleplay", 255, 255, 255, true)			
				source:outputChat("#DDFFDDForo: #0116FCProximamente", 255, 255, 255, true)
				source:outputChat("#DDFFDDDiscord: #4756F9https://discord.gg/yMWrTgagBh", 255, 255, 255, true)
				source:outputChat("#DDFFDDYoutube: #FF0033Chicago Roleplay", 255, 255, 255, true)
				source:outputChat("#DDFFDDSi ves que no tienes Comida ni Agua #00DD00Reconecta y se te dara automaticamente", 255, 255, 255, true)
			end
		end, 15000, 1, source)



	--	triggerClientEvent(source, "detenerTransicion", source)
		setTimer(triggerClientEvent, 500, 1, source, "Roleplay:DestroyLog", source, {getTime()}, {getWeather(  )})
		showCursor( source, false)

		local s = query("SELECT * FROM datos_personajes where Cuenta = ?", user)
		if not ( type( s ) == "table" and #s == 0 ) or not s then

			local sexo = s[1]["Sexo"]
			if sexo == "Femenino" then
				source:setWalkingStyle(132)
				source:setData("Agua",100)
				source:setData("Comida",100)
			else
				source:setWalkingStyle(128)
				source:setData("Agua",100)
				source:setData("Comida",100)
			end

		else
			source:setWalkingStyle(128)
		end

	else
	--	source:triggerEvent("Roleplay:ErrorLogin", source)
		source:triggerEvent("callNotification", source, "error", "Por favor, escriba bien sus datos.", true)
	end

end
addEvent("Roleplay:LoginPlay", true)
addEventHandler("Roleplay:LoginPlay", root, LoginPlayer)


function RegisterPlayer(user, pass, skin, nacion, edad, miSexo)

	local maximo = query("SELECT * FROM save_system where Serial = ?", source:getSerial())
	if not Account(user) then
		if #maximo < 3 then
			local accc = Account.add (user, pass)
			if accc then

				local ip = source:getIP()
				local serial = source:getSerial()
				local f = getRealTime()

				insert("insert into `registros` VALUES (?,?,?,?,?)", user, pass, serial, ip, f.monthday.."/"..f.month+1 .."/"..f.year-100)
				insert("INSERT INTO save_system VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", toJSON ( { x = 1743.0068359375, y = -1860.7158203125, z = 13.578397750854} ), toJSON ( { rx = 0, ry = 0, rz = 359.72808837891} ), 100, 0, 0, 0, skin, 0, '2000', '', source:getSerial(), user, 100, 100, '')
				insert('insert into datos_personajes values(?,?,?,?,?,?)', nacion, edad, miSexo, 0, user, source:getSerial())

				source:triggerEvent("callNotification", source, "info", "Personaje creado, selecciona e inicia.", true)
				source:triggerEvent('displayPjOnGround',source, {{user, skin, edad, 100, {1743.0068359375, -1860.7158203125, 13.578397750854}, 2000}})
				source:triggerEvent('Roleplay:finishRegister',source)
				--{v.Cuenta, tonumber(v.Skin), qh[1].Edad, v.Vida, {pos.x, pos.y, pos.z}, v.Money} 

			else
				source:triggerEvent("callNotification", source, "error", "Por favor, intruce bien tus datos.", true)
			end
		else
			source:triggerEvent("callNotification", source, "error", "Solo puedes tener 3 personajes.", true)
		end
	else
		source:triggerEvent("callNotification", source, "error", "La cuenta ya existe.", true)
	end
end
addEvent("Roleplay:RegisterPlay", true)
addEventHandler("Roleplay:RegisterPlay", root, RegisterPlayer)



addEvent("Login:kickPlayer", true)
addEventHandler("Login:kickPlayer", root, function()
	setTimer(kickPlayer, 1500, 1, source, "Console", "Saliste del Servidor, Vuelve pronto.")
end)



function _nombre(jugador,comando,argumento)
	if jugador.type == 'console' or aclGetGroup( 'Desarrollador' ):doesContainObject('user.'..jugador.account.name ) or aclGetGroup( 'Admin' ):doesContainObject('user.'..jugador.account.name ) then
		
		local msg = false
		local acc = getAccount(argumento)
		if acc then
			removeAccount( acc )
			msg = true
		end

		if #(query('select * from datos_personajes where Cuenta=?', argumento) or {}) > 0 then
			query('delete from datos_personajes where Cuenta=?', argumento)
			msg = true
		end
		if #(query('select * from registros where Cuenta=?', argumento) or {}) > 0 then
			query('delete from registros where Cuenta=?', argumento)
			msg = true
		end
		if #(query('select * from save_system where Cuenta=?', argumento) or {}) > 0 then
			query('delete from save_system where Cuenta=?', argumento)
			msg = true
		end

		if msg then
			if jugador.type == 'console' then
				outputServerLog( '* Se a eliminado todos los reciduos de la cuenta '..argumento )
			else
				jugador:outputChat('* Se a eliminado todos los reciduos de la cuenta '..argumento, 0, 255, 0)
			end
		else
			if jugador.type == 'console' then
				outputServerLog('* La cuenta '..argumento..' no existe.')
			else
				jugador:outputChat('* La cuenta '..argumento..' no existe.', 255, 0, 0)
			end
		end
		
	end
end
addCommandHandler("delacc", _nombre)