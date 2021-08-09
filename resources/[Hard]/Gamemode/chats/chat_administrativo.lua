local antiSpamAdmin = {}
local Administradores ={
["Admin"]=true,
["Asesor"]=true,
["Mod"]=true,
["SuperMod"]=true,
["Sup.Facc"]=true,
["Sup.Staff"]=true,
["Sup.Asesor"]=true,
["Sup.Grupos"]=true,
}

Rangos ={
["Admin"]= 'Admin',
["Asesor"]= 'Asesor',
["Mod"]= 'Mod',
["SuperMod"]= 'SuperMod',
["Sup.Facc"]= 'Sup.Facc',
["Sup.Staff"]= 'Sup.Staff',
["Sup.Asesor"]= 'Sup.Asesor',
["Sup.Grupos"]= 'Sup.Grupos',
}

RColor= {
["Admin"]= "0752eb",
["Mod"]= "a2d9ff",
["SuperMod"]= "57b9ff",
["Sup.Facc"]= "57b9ff",
["Sup.Asesor"]= "57b9ff",
["Sup.Staff"]= "006bff",
["Sup.Grupos"]= "57b9ff",
["Asesor"]= "7a9fb9",
}

function chatAdministrativo(player, cmd, ...)
    if not notIsGuest(player) then
        if Administradores[getACLFromPlayer(player)] == true then
            local tick = getTickCount()
            if (Administradores[player] and Administradores[player][1] and tick - Administradores[player][1] < 500) then
                return
            end
            local msg = table.concat({...}, " ")
            if msg ~="" and msg ~=" " then
                local hex = "#"..RColor[getACLFromPlayer(player)]
                local MyACL = getACLFromPlayer(player)
                local nick = player:getData("nombre:staff")
                for i, v in ipairs(Element.getAllByType("player")) do
                local accName = getAccountName ( getPlayerAccount ( v ) )
                    if Administradores[getACLFromPlayer(v)] == true   then
                    
                        v:outputChat("#2cfc03 [/a-STAFF] #0890d4" .. hex .. "".. player:getData("nombre:staff") .. " (" ..MyACL..  "): #FFFFFF" .. msg, 255, 255, 255, true)
                        print(getACLFromPlayer(v))
                    end
                end
                if (not Administradores[player]) then
                    Administradores[player] = {}
                end
                Administradores[player][1] = getTickCount()
            end
        end
    end
end
addCommandHandler("a", chatAdministrativo)


--[[addCommandHandler( "a",
    function( player, cmd, ... )
        local message = table.concat( { ... }, " " )
        if #message > 0 then
            for key, value in ipairs( getElementsByType( "player" ) ) do
                if Administradores[getACLFromPlayer(value)] == true then
				local hex = "#"..RColor[getACLFromPlayer(value)]
                    outputChatBox("#2cfc03 [/a-STAFF] #0890d4" .. hex .. "".. player:getData("nombre:staff") .. " (" ..getACLFromPlayer(value)..  "): #FFFFFF" .. message, value, 255, 255, 255,true)
                end
            end
        end
    end
)--]]


--[[addCommandHandler( "a",
    function( player, cmd, ... )
        local message = table.concat( { ... }, " " )
        if #message > 0 then
            for key, value in ipairs( getElementsByType( "player" ) ) do
                if Administradores[getACLFromPlayer(value)] == true then
                    outputChatBox("#FFFFFF[" .. Rcolor[getACLFromPlayer(value)] .. Rangos[getACLFromPlayer(value)] .. " - /a#FFFFFF]  " .. Rcolor[getACLFromPlayer(value)] .. getAccountName( getPlayerAccount( player ) ) .. " #FFFFFFdice: #FFFFFF" .. message, value, 255, 255, 191,true)
                end
            end
        end
    end
)--]]

