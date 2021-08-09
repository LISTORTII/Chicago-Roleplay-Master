local dimensiones = 5
local tiempoTotal = 40
local screenW, screenH = guiGetScreenSize()

local Robos_c = {}

addEventHandler( 'onClientRender', getRootElement(),
    function()

        for dim in pairs(Ints) do

            local shop = getElementByID('ShopID_'..dim)
            if isElement(shop) then

                if Robos_c[shop] then

                    if Robos_c[shop].count then

                        if (getElementDimension( localPlayer ) == dim) then

                            
                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg", screenW * 0.4170, screenH * 0.6953, screenW * 0.5830, screenH * 0.7227, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "left", "top", false, false, false, false, false)

                        end

                    end

                end

            end

        end

    end
)

addEvent('displayTimeRob', true)
addEventHandler('displayTimeRob', localPlayer,
    function(shop, dim)
        local dim = dim
        Robos_c[shop] = Robos_c[shop] or {}

        Robos_c[shop].count = 40

        Robos_c[shop].timer = Timer(
            function(shop) 

                Robos_c[shop].count = Robos_c[shop].count - 1

                if Robos_c[shop].count <= 0 then
                    triggerServerEvent('ShopRobGiveMoney', localPlayer, dim)
                    Robos_c[shop].count = false
                    killTimer( sourceTimer )
                end

            end,
        1000,0, shop)
    end
)



