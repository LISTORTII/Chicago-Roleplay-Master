Robos_s = {}

Robos_s.blips = {}
Robos_s.rob = {}

Robos_s.elementRobo = function()
	for dim in pairs(Ints) do
		Element('Tiendas_', 'ShopID_'..dim)
	end
end

Robos_s.elementRobo()

Robos_s.cmdRobar = function(p)
	local myDim = p.dimension
	if myDim then

		local shop = getElementByID('ShopID_'..myDim)
		if isElement(shop) then

			if (not Robos_s.rob[shop]) or (not Robos_s.rob[shop]:isValid()) then

				if (#getPlayersInFaction('Policia') >= 4) then
					
					Robos_s.rob[shop] = Timer(function(s) Robos_s.rob[s] = nil end,60000, 1, shop)

					local info = Ints[myDim]
					p:triggerEvent('displayTimeRob', p, shop, myDim)
					p:outputChat('#ffffffEstas Robado esta Tienda Mantente Alerta!',255,255,255,true)

					local Group = Element('Group-Police','LSPD')
					for i,v in ipairs(Element.getAllByType('player')) do
						if v:getData('Roleplay:faccion') == 'Policia' then
							v:outputChat('Estan Robando la tienda [ '..info[1]..' ] ¡todas las unidades acudir al robo!', 255,255,0)
							v:setParent(Group)
						end
					end

					Robos_s.blips[myDim] = Blip(info[2][1], info[2][2], info[2][3], 0, 2, 255, 0, 0, 255, 0, 1000, Group)
					Robos_s.blips[myDim]:setData('My_Parent', Group, false)
					
					
				end

			elseif Robos_s.rob[shop]:isValid() then

				local ms = getTimerDetails( Robos_s.rob[shop] )
				p:outputChat('Esta tienda fue robada recientemente, Tiempo para robar > '..formatTime(ms))
			
			end

		end

	end
end
addCommandHandler('robartienda', Robos_s.cmdRobar)

addEvent('ShopRobGiveMoney', true)
addEventHandler('ShopRobGiveMoney', root,
    function(dim)

    	if (source.dimension == dim) then
    		source:giveMoney(100)
			source:outputChat("#ffffffAcabas de obtener #004500#2,500 #ffffffde la caja",255,255,255,true)
    	end

    	local blipParent = Robos_s.blips[dim]:getData('My_Parent')
    	if isElement(blipParent) then
    		blipParent:destroy()
    	end

    	if isElement(Robos_s.blips[dim]) then
			Robos_s.blips[dim]:destroy()
		end
	end

)


function formatTime(ms)
	if not ms or type(ms) == 'userdata' then
		return false
	end
	local seg = math.floor(math.max(0,ms / 1000))
	return ('%02d:%02d'):format(math.floor(math.max(0,seg / 60)), seg)
end

function getPlayersInFaction(faction)
	local o = {}
	for i,v in ipairs(Element.getAllByType('player')) do
		if v:getData('Roleplay:faccion') == faction then
			table.insert(o,v)
		end
	end
	return o
end
