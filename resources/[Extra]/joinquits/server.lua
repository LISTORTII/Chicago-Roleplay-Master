function onClientCrapBox(player, test1, test2, test3)
	triggerClientEvent(getRootElement(), "onClientCrapBox", getRootElement(), test1, test2, test3)
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	onClientCrapBox(source, "join", getPlayerName(source).." #FFFFFFentró al servidor.", exports.admin:getPlayerCountry(source))
end)

addEventHandler("onPlayerLogin", getRootElement(), function()
end)

addEventHandler("onPlayerQuit", getRootElement(), function(typ)
	onClientCrapBox(source, "quit", getPlayerName(source).." #FFFFFFsalió del servidor(#FF0000"..typ.."#FFFFFF).")
end)

addEventHandler("onPlayerMute", getRootElement(), function(typ)
end)