local antiSpamOOC = {}
function chatOCC( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamOOC[source] and antiSpamOOC[source][1] and tick - antiSpamOOC[source][1] < 2000) then
			source:outputChat("Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
				tipo = " [#0752ebAdministrador#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) then
				tipo = " [#57b9ffSuperMod#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Staff" ) ) then
				tipo = " [#006bffSup.Staff#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
				tipo = " [#a2d9ffMod#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Facc" ) ) then
				tipo = " [#57b9ffSup.Facciones#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Asesor" ) ) then
				tipo = " [#57b9ffSup.Asesores#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Grupos" ) ) then
				tipo = " [#57b9ffSup.Grupos#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Donador" ) ) then
				tipo = " [#F2F609Donador#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Asesor" ) ) then
				tipo = " [#7a9fb9Asesor#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIPNormal" ) ) then
				tipo = " [#EEC81EVIP#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIPPro" ) ) then
				tipo = " [#3ECB1BVIP+#FFFFFF]"

			else
				tipo = ""
			end
			local message2 = message
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString(nick.." ((OOC)): "..tipo..": #FFFFFF"..message2.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				v:outputChat("#FFFFFF"..nick.." [OOC]: "..tipo..": #FFFFFF(("..message2.."))", 165, 242, 255, true)
			end
			if (not antiSpamOOC[source]) then
				antiSpamOOC[source] = {}
			end
			antiSpamOOC[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"b", "occ"}, chatOCC)