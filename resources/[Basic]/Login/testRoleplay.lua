local PuntosRolepaly = 0
local PuntosTotal = 0
local PasosRoleplay = 1
local RoleplayPreguntas = {
-- Pregunta número 1
{
{Pregunta="Elige el significado de Death Match (DM) según tus conocimientos:"},
{Repuesta={"Death Man, una persona que esta muerta en el piso sin ninguna atención médica.", "Death match es referido hacia cualquier acción violenta realizada hacia otro jugador teniendo motivos vagos o inválidos.", "Matar a una persona de un solo golpe, roleando mediante el comando /do dejarlo en estado K.O de un puñetazo."}}
},
-- Pregunta número 2
{
{Pregunta="Elige la opción correcta para definir Roleplay."},
{Repuesta={"Es una modalidad de juego todos contra todos, el que tenga más asesinatos tendrá más dinero.", "Es una modalidad creada para conseguir cosas que te gusten a base de trabajar sin parar.", "Es una modalidad de juego que busca asemejarse la vida real, tomando todos sus elementos y características para ematizar la realidad."}}
},
-- Pregunta número 3
{
{Pregunta="Elige la opción correcta para definir la normativa de Power Gaming."},
{Repuesta={"Ambas son correctas.", "Power Gaming es ejecutar acciones irreales, imposibles y poco comunes con tu personaje.", "Power Gaming es el acto de forzar el rol de otro usuario utilizando los comandos /me y /do, impidiéndole defenderse y/o responder a tus acciones con los comandos /me y /do."}}
},
-- Pregunta número 4
{
{Pregunta="¿Cuándo puedo quedarme AFK?."},
{Repuesta={"Siempre que yo quiera, no afecta en nada.", "Puedo quedarme unos minutos dentro de mi casa.", "No puedo quedarme AFK."}}
},
-- Pregunta número 5
{
{Pregunta="Selecciona los requisitos a tener en cuenta para robar a un usuario."},
{Repuesta={"Debes ver que el usuario sea mayor a Nivel 3, respetar los entornos y zonas seguras; agregando la supervisión de un GO III.","Debo tener en cuenta el nivel del asaltado (Este debe ser superior a nivel tres (3)), debo rolear mediante /do el entorno correspondiente.","No se puede robar bajo ningún concepto, más bien esta penado y es malo para la sociedad."}}
},
-- Pregunta número 6
{
{Pregunta="¿Qué normas debo cumplir a la hora de estafar propiedades?"},
{Repuesta={"Tener estilo y poder, esto hace que la gente no se te acerque y te respeten, ganas más poder.", "Ser considerado NRE y se sancionará administrativamente por ello.", "El rol de una estafa no está aprobado dentro del servidor."}}
},
-- Pregunta número 7
{
{Pregunta="El andar por la vía publica con armas desemboca en. "},
{Repuesta={"Ser considerado NRA y se sancionará administrativamente por ello.", "Ser considerado NRE y se sancionará administrativamente por ello.", "Ser considerado Nula Interpretación de Personaje, lo cual conlleva a una sanción administrativa."}}
},
-- Pregunta número 8
{
{Pregunta="Quiero hacer un rol que pueda ser muy incomodo al usuario,¿Qué debo tener a cuenta?"},
{Repuesta={"Puedo rolear lo que sea con quien yo quiera, si la otra persona se resiste, estoy en mi derecho de reportarla por forzar el rol.", "Este rol no esta permitido, bajo ningun concepto.", "Para hacer un rol de este calibre se debe tener en cuenta la confirmación OOC de todas las partes."}},
},
-- Pregunta número 9
{
{Pregunta="¿Qué es MG?"},
{Repuesta={"Ambas respuestas son correctas.", "Meta Gaming, es el abuso de información OOC o externa al ámbito de juego IC para beneficio propio.", "Meta Gaming es considerado la acción o cadenas de mismas destinadas a perjudicar a un usuario/personaje por el simple hecho de que me cae mal de forma OOC."}},
},
-- Pregunta número 10
{
{Pregunta="¿Qué es PK?"},
{Repuesta={"Potencial Killer es el asesinato continuo de jugadores, significa que un usuario esta en racha de asesinatos.", "Power Kill, matas a un usuario de una forma extravagante, y se te dará una recompensa monetaria por tu gran trabajo.", "Player Kill, es la muerte de un personaje, ya sea parcial o total. Se perderá la información que nos llevó al evento de la muerte del personaje"}},
},
-- pregunta numero 11
{
{Pregunta="Selecciona la respuesta correcta del significado de la normativa CK."},
{Repuesta={"Es la muerte total de mi personaje . Perderé toda la historia de mi personaje; incluyento trama y todo lo vinculado a él,No puedo volver a jugar con ese personaje si no me cambio el nombre", "Es la muerte de mi personaje, no pierdo nada y puedo seguir usandolo.", "Es cuando mato a un personaje, él se olvidará de mi y todo lo relacionado con mi persona."}},
},
--Pregunta numero 12
{
{Pregunta="¿Puedo robar vehiculos en movimiento?, ¿Qué debo hacer para cumplirlo?"},
{Repuesta={"Si puedo, debo ponerme al lado del conductor y gritarle para que paré el camión, puedo usar un arma para amedrentarlo.", "No puedo robar a vehiculos en movimiento y si llego a hacerlo seré sancionado administrativamente.", "Puedo interceptar su camino con autos pesados para obligarlo a frenar o cortarle el camino para obligarlo a ceder."}},
},
--Pregunta numero 13
{
{Pregunta="¿Qué es BA?"},
{Repuesta={"Es Bug Abuse, abusar y explotar un  bug dentro del juego para obtener beneficio propio y no reportarlo. Aplica para animaciones, propiedades y semejantes.", "Buguear armas, como dice el nombre. Se refiere a multiplicar balas de un arma con o sin ayuda de un amigo, esto es sancionable administrativamente. ","Todas son incorrectas, en este servidor la normativa BA es inexistente."}},
},
--Pregunta numero 14
{
{Pregunta="Elige la opción correcta para la normativa RK."},
{Repuesta={"Ser asesinado bajo un motivo sólido por otro usuario, regresar al sitio y asesinarlo en forma de venganza.", "Que un usuario que asesiné venga y me asesine por los mismos motivos, ignorando la normativa de Player Kill.","Todas son correctas."}},
},
--Pregunta numero 15
{
{Pregunta="¿Qué pautas debo cumplir para realizar un rol de secuestro hacia otro personaje?"},
{Repuesta={"Debo planear el secuestro y ejecutarlo de forma correcta.", "Para secuestrar a un usuario debo cerciorarme de que sea un nivel superior a cinco, contar con un motivo y realizar un rol de entorno usando el comando /do.","Todas las respuestas son incorrectas."}},
},
--Pregunta numero 16
{
{Pregunta="¿Qué es el rol de entorno?, elige la respuesta correcta a continuación."},
{Repuesta={"El rol de entorno es lo que escribo por el comando /do", "El rol de entorno es el lugar y sitio donde se desenvuelve mi personaje; NPC's, sonidos, clima y hora son particularidades que conforman el entorno.","Todas las respuestas son correctas."}},
},
--Pregunta numero 17
{
{Pregunta="Elige la respuesta correcta referente al uso del comando /do."},
{Repuesta={"El comando /do es un comando hecho para ematizar todo lo que ve mi personaje.", "El comando /do esta hecho para rolear entorno.","El comando /do sirve para evitar el forzado de rol/PG."}},
},
--Pregunta numero 18
{
{Pregunta="¿Qué es NRH?"},
{Repuesta={"No rolear heridas estando a menos de 50% de vida. Lo cual es sancionable.", "No Rol de Hermanos, esto se hace cuando tienes un hermano en el juego y no lo reconoces como tal.","No rol de heridas, aplica a la hora de recibir o realizar una acción violenta hacia mi personaje, como por ejemplo cortarme con un cuchillo e ignorarlo por completo."}},
},
--Pregunta numero 19
{
{Pregunta="Elige la respuesta correcta del buen uso del comando /me."},
{Repuesta={"El comando /me sirve para ematizar las acciones de mi personaje y que otros usuarios puedan interpretarlas de forma correcta.", "El comando /me sirve para rolear acciones. Las mismas deben ser descriptas a detalle sin importar la longitud de estas.","El comando /me sirve para rolear una llamada al NPC."}},
},
--Pregunta numero 20
{
{Pregunta="¿Qué debo hacer en caso de solicitar ayuda administrativa?"},
{Repuesta={"Debo hacer uso del comando /re o /duda, describiendo a detalle mis necesidades.", "Debo utilizar los canales internos de nuestro discord para contactarme con algún miembro del STAFF.","Puedo realizar todo lo anterior para que me atiendan."}},
},
}

local PuntosRepuestaTable = {
-- 1
["Death match es referido hacia cualquier acción violenta realizada hacia otro jugador teniendo motivos vagos o inválidos."]= 1,
["Es una modalidad de juego que busca asemejarse la vida real, tomando todos sus elementos y características para ematizar la realidad."]= 1,
["Ambas son correctas."] = 1,
["Puedo quedarme unos minutos dentro de mi casa."] = 1,
["Debo tener en cuenta el nivel del asaltado (Este debe ser superior a nivel tres (3)), debo rolear mediante /do el entorno correspondiente."] = 1,
["El rol de una estafa no está aprobado dentro del servidor."] = 1,
["Ser considerado NRE y se sancionará administrativamente por ello."] = 1,
["Para hacer un rol de este calibre se debe tener en cuenta la confirmación OOC de todas las partes."] = 1,
["Ambas respuestas son correctas."] = 1,
["Player Kill, es la muerte de un personaje, ya sea parcial o total. Se perderá la información que llevó al evento de la muerte del personaje."] = 1,
["Es la muerte total de mi personaje . Perderé toda la historia de mi personaje; incluyento trama y todo lo vinculado a él,No puedo volver a jugar con ese personaje si no me cambio el nombre"] = 1,
["No puedo robar a vehiculos en movimiento y si llego a hacerlo seré sancionado administrativamente."] = 1,
["Es Bug Abuse, abusar y explotar un  bug dentro del juego para obtener beneficio propio y no reportarlo. Aplica para animaciones, propiedades y semejantes."] = 1,
["Todas son correctas."] = 1,
["Para secuestrar a un usuario debo cerciorarme de que sea un nivel superior a cinco, contar con un motivo y realizar un rol de entorno usando el comando /do."] = 1,
["El rol de entorno es el lugar y sitio donde se desenvuelve mi personaje; NPC's, sonidos, clima y hora son particularidades que conforman el entorno."] = 1,
["El comando /do es un comando hecho para ematizar todo lo que ve mi personaje."] = 1,
["No rol de heridas, aplica a la hora de recibir o realizar una acción violenta hacia mi personaje, como por ejemplo cortarme con un cuchillo e ignorarlo por completo."] = 1,
["El comando /me sirve para ematizar las acciones de mi personaje y que otros usuarios puedan interpretarlas de forma correcta."] = 1,
["Puedo realizar todo lo anterior para que me atiendan."] = 1,
}
--[[
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelRoleplay = guiCreateWindow(0.32, 0.34, 0.36, 0.32, "Pasos: 1/10", true)
        guiWindowSetSizable(PanelRoleplay, false)
        guiSetVisible(PanelRoleplay, false)

        LabelPregunta = guiCreateLabel(0.02, 0.11, 0.96, 0.18, "Pregunta: ¿?", true, PanelRoleplay)
        guiSetFont(LabelPregunta, "default-bold-small")
        guiLabelSetHorizontalAlign(LabelPregunta, "center", true)
        guiLabelSetVerticalAlign(LabelPregunta, "center")
        ListaRepuestas = guiCreateGridList(0.04, 0.32, 0.94, 0.47, true, PanelRoleplay)
        guiGridListAddColumn(ListaRepuestas, "Repuestas", 0.9)
        botonSiguiente = guiCreateButton(0.41, 0.83, 0.18, 0.13, "Siguiente..", true, PanelRoleplay)
        guiSetProperty(botonSiguiente, "NormalTextColour", "FFAAAAAA")    
    end
)]]
GUIEditor = {
    gridlist = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelRoleplay = guiCreateWindow(0.09, 0.20, 0.83, 0.61, "pregunta 1/20", true)
        guiWindowSetSizable(PanelRoleplay, false)

        ListaRepuestas = guiCreateGridList(0.01, 0.48, 0.98, 0.50, true, PanelRoleplay)
        guiGridListAddColumn(ListaRepuestas, "Respuestas", 0.9)
        botonSiguiente = guiCreateButton(0.85, 0.06, 0.13, 0.10, "Siguiente", true, PanelRoleplay)
        guiSetFont(botonSiguiente, "default-bold-small")
        guiSetProperty(botonSiguiente, "NormalTextColour", "FFFFFEFE")
        GUIEditor.label[1] = guiCreateLabel(0.01, 0.17, 0.99, 0.11, "PREGUNTA", true, PanelRoleplay)
        local font0_EmblemaOne = guiCreateFont(":guieditor/fonts/EmblemaOne.ttf", 30)
        guiSetFont(GUIEditor.label[1], font0_EmblemaOne)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        LabelPregunta = guiCreateLabel(0.07, 0.30, 0.87, 0.11, "Hola", true, PanelRoleplay)
        local font1_EmblemaOne = guiCreateFont(":guieditor/fonts/EmblemaOne.ttf", 12)
        guiSetFont(LabelPregunta, font1_EmblemaOne)
        guiLabelSetHorizontalAlign(LabelPregunta, "center", false)
        guiLabelSetVerticalAlign(LabelPregunta, "center")    
        guiSetVisible(PanelRoleplay, false)
    end
)
local PasosRoleplay2 = 0
addEventHandler("onClientGUIClick", resourceRoot, function()
	local repuesta = guiGridListGetItemText ( ListaRepuestas, guiGridListGetSelectedItem ( ListaRepuestas ), 1 )
	if source == botonSiguiente then
		if repuesta ~="" then
			if PuntosRepuestaTable[repuesta] then
				PuntosRolepaly = PuntosRolepaly + PuntosRepuestaTable[repuesta]
			end
			if PasosRoleplay >= 1 and PasosRoleplay <= 19 then
				PasosRoleplay = PasosRoleplay + 1
				PasosRoleplay2 = PasosRoleplay2 + 1
				loadPreguntas()
			elseif PasosRoleplay >= 20 then
				PuntosTotal = PuntosRolepaly
				PasosRoleplay2 = PasosRoleplay2 + 1
			end
			print(PuntosTotal)
			if PasosRoleplay2 >= 20 then
				if PuntosTotal >= 15 then
					outputChatBox("¡Muy bien pasaste el test de rol!", 50, 150, 50)
					guiSetVisible( PanelRoleplay, false )
					triggerServerEvent("PasoElRol", localPlayer)
				else
					triggerServerEvent("kickedPlayer", localPlayer)
					guiSetVisible( PanelRoleplay, false )

				end
			end
		else
			outputChatBox("¡Debes selecciona una repuesta antes de ir a la siguiente!", 150, 50, 50)
		end
	end
end)

addEvent("setVisibleTestRol", true)
addEventHandler("setVisibleTestRol", root, function()
	if guiGetVisible(PanelRoleplay) == true then
		guiSetVisible(PanelRoleplay, false)
	else
		guiSetVisible(PanelRoleplay, true)
		loadPreguntas()
	end
end)

function loadPreguntas()
	guiGridListClear(ListaRepuestas)
	for i, s in ipairs(RoleplayPreguntas) do
		if PasosRoleplay >= i and PasosRoleplay <= i then
			local valPre = s[1]
			guiSetText(PanelRoleplay, "Pasos: "..i.."/20")
			guiSetText(LabelPregunta, "Pregunta: "..valPre.Pregunta)
			local valRep = s[2]
			local r1 = math.randomDiff(1, #valRep.Repuesta)
			local r2 = math.randomDiff(1, #valRep.Repuesta, r1)
			local r3 = math.randomDiff(1, #valRep.Repuesta, r1,r2)
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r1])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r2])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r3])
			guiGridListSetSortingEnabled ( ListaRepuestas, false )
			--guiGridListSetItemText(ListaRepuestas, row, 1, tostring(math.randomDiff(1, v)), false, false)
		end
	end
end

function math.randomDiff(a, b, distA, distB)
	local distA = distA or 0
	local distB = distB or 0
	local random = math.random(a,b)
	while random == distA or random == distB do
		random = math.random(a,b)
		if random ~= distA and random ~= distB then
			break;
		end
	end
	return random
end
