addEventHandler( "onResourceStart", resourceRoot,
	function()
		dbC = dbConnect( "sqlite", "test.db" )
	end
)
addEvent("PasoElRol", true)
addEventHandler("PasoElRol", root, function()
	--mysql:update("UPDATE Datos_Personajes SET TestRoleplay = ?  WHERE Cuenta = ?", 'Si', AccountName(source))
	dbFree( dbC:query('insert into savetest values(?)', source:getSerial()) )
    source:triggerEvent('VerifiedTestRol', source, true)
end)

addEvent("kickedPlayer", true)
addEventHandler("kickedPlayer", root, function()
	source:outputChat("¡No has pasado el test de Rol!", 150, 50, 50, true)
	source:setData("EnEdicion", true)
	setTimer(kickPlayer, 3000, 1, source, "Console", "No has pasado el test de rol")
end)

addEvent('VerifiedTestRol', true)
addEventHandler('VerifiedTestRol', root,
    function()
    	
    	local bool = false
    	local qh = dbC:query('select * from savetest where serial=?', client:getSerial())
    	local pol = qh:poll(-1)
    	if pol and #pol > 0 then
    		bool = true
    	end

    	client:triggerEvent('VerifiedTestRol', client, bool)
    	dbFree( qh )

    end
)