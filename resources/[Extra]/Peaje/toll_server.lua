--[[	Resource Name:	BRIDGE TOLL BOOTHS
		Author:			Mega9
		Version:		2.0.3
		All Rights Reserved (c) 2014
]]



-- Settings
local tollPrice = 10		-- Toll Price (Default: 150)
local allowedTypes = { 		-- Allowed vehicle types
	["Automobile"]=true; 
	["Bike"]=true; 
	["Monster Truck"]=true; 
}	
local teamsImmuneToToll = {
	["Police"]=true;
}
	
-- End of settings

-- Barriers
local tollbarrierLSLV = createObject (968, 1745.19, 509.79, 28.6, 0, 90, 340) 	-- gate LS > LV
local tollbarrierLSLV2 = createObject (968, 1736.8, 513.2, 28.6, 0, 89, 338) 	-- gate LS > LV 2
local tollbarrierLVLS = createObject (968, 1723.5, 510.5, 28.9, 0, 270, 338) 	-- gate LV > LS
local tollbarrierLVLS2 = createObject (968, 1731.9, 507.64, 28.9, 0, 271, 338) 	-- gate LV > LS 2
local tollbarrierLVSF = createObject (968, -1401.1, 826.2, 47.6, 0, 270, 318) 	-- gate LV > SF
local tollbarrierLVSF2 = createObject (968, -1407.9, 832, 47.6, 0, 270, 316) 	-- gate LV > SF 2
local tollbarrierSFLV = createObject (968, -1395.1, 829.2, 47.6, 0, 90, 316) 	-- gate SF > LV
local tollbarrierSFLV2 = createObject (968, -1389, 823.4, 47.6, 0, 90, 316) 	-- gate SF > LV 2
local tollbarrierTRSF = createObject (968, -2691.69, 1271.3, 55.5, 0, 270, 0) 	-- gate TR > SF
local tollbarrierTRSF2 = createObject (968, -2683, 1271.19, 55.5, 0, 270, 0) 	-- gate TR > SF 2
local tollbarrierSFTR = createObject (968, -2671.2, 1277.7, 55.5, 0, 90, 0) 	-- gate SF > TR
local tollbarrierSFTR2 = createObject (968, -2680.8, 1278.19, 55.5, 0, 90, 0) 	-- gate SF > TR 2
local tollbarrierLSSF = createObject (968, 51.7, -1528.1, 5.2, 0, 90, 85) 		-- gate LS > SF
local tollbarrierSFLS = createObject (968, 53.7, -1535, 5.2, 0, 270, 85) 		-- gate SF > LS



-- Markers
local tollboothLSLV = createMarker (1746, 499, 27.5, "cylinder", 5, 0, 0, 0, 255) --
local tollboothLSLV2 = createMarker (1736.69, 503.2, 27.5, "cylinder", 5.0, 0, 0, 0, 255)
local tollboothLVLS = createMarker (1725, 524, 27.5, "cylinder", 5, 0, 0, 0, 255)--
local tollboothLVLS2 = createMarker (1732.19, 518.2, 27.1, "cylinder", 5.0, 0, 0, 0, 255)
local tollboothLVSF = createMarker (-1397, 836, 47, "cylinder", 5, 0, 0, 100, 255)--
local tollboothLVSF2 = createMarker (-1403.59, 839.79, 46, "cylinder", 4.0, 0, 0, 0, 255)
local tollboothSFLV = createMarker (-1399, 820, 47, "cylinder", 5, 0, 0, 0, 255)--
local tollboothSFLV2 = createMarker (-1394.09, 813.7, 46, "cylinder", 4.0, 0, 0, 0, 255)
local tollboothTRSF = createMarker (-2696, 1283, 54, "cylinder", 5, 0, 0, 0, 255)--
local tollboothTRSF2 = createMarker (-2686.3, 1281.8, 54, "cylinder", 5, 0, 0, 0, 255)
local tollboothSFTR = createMarker (-2667, 1268, 54, "cylinder", 5, 0, 0, 0, 255)--
local tollboothSFTR2 = createMarker (-2677, 1267.3, 54, "cylinder", 5, 0, 0, 0, 255)
local tollboothLSSF = createMarker (57.59, -1525.3, 4, "cylinder", 5, 0, 0, 0, 0)--
local tollboothSFLS = createMarker (46.79, -1537.09, 4, "cylinder", 5, 0, 0, 0, 0)

addEventHandler ("onMarkerHit", root,
	function (hitElement, dimension)
		local s = source
		if s == tollboothLSLV or s == tollboothLVLS or s == tollboothLVSF or s == tollboothSFLV or s == tollboothTRSF or s == tollboothSFTR or s == tollboothLSLV2 or s == tollboothLVLS2 or s == tollboothLVSF2 or s == tollboothSFLV2 or s == tollboothTRSF2 or s == tollboothSFTR2 or s == tollboothLSSF or s == tollboothSFLS and dimension then
			if getElementType (hitElement) == "player" and isPedInVehicle (hitElement) then
				local sourceVehicle = getPedOccupiedVehicle (hitElement)
				local controller = getVehicleController (sourceVehicle)
				local pAcc = getPlayerAccount (hitElement)
				if allowedTypes [getVehicleType (sourceVehicle)] then
					if isGuestAccount (pAcc) then
						if getPlayerMoney (hitElement) < tollPrice then
							outputChatBox ("[NPC]¡No tienes dinero para pagar el peaje! (Precio: $"..tollPrice..")", controller, 255, 0, 0)
						else
							setElementVelocity (sourceVehicle, 0, 0, 0)
							triggerClientEvent (controller, "manageTollGUI", controller, 1, tollPrice, true)
						end
					elseif not isGuestAccount (pAcc) then
						if getPlayerTeam (controller) and teamsImmuneToToll[getTeamName(getPlayerTeam(controller))] then
							triggerEvent ("tollPaid", controller, true)
							outputChatBox ("[TOLL] This pass was financed by the Government", controller, 120, 255, 0)
						else
							if getAccountData (pAcc, "toll.impulses") and getAccountData (pAcc, "toll.impulses") > 0 then
								setAccountData (pAcc, "toll.impulses", getAccountData (pAcc, "toll.impulses") - 1)
								triggerEvent ("tollPaid", controller, true)
								outputChatBox ("[NPC]¡Usaste un Ticket!, te restan:#ffffff "..getAccountData (pAcc, "toll.impulses"), controller, 255, 120, 0, true)
							elseif not getAccountData (pAcc, "toll.impulses") or getAccountData (pAcc, "toll.impulses") == 0 then
								setElementVelocity (sourceVehicle, 0, 0, 0)
								triggerClientEvent (controller, "manageTollGUI", controller, 1, tollPrice)
							end
						end
					end
				else
					outputChatBox ("[NPC]¡No puedes pasar por este peaje!", controller, 255, 0, 0)
				end
			else
				return
			end
		end
	end
)

addEventHandler ("onMarkerLeave", root,
	function (leaveElement, dimension)
		local s = source
		if s == tollboothLSLV or s == tollboothLVLS or s == tollboothLVSF or s == tollboothSFLV or s == tollboothTRSF or s == tollboothSFTR or s == tollboothLSLV2 or s == tollboothLVLS2 or s == tollboothLVSF2 or s == tollboothSFLV2 or s == tollboothTRSF2 or s == tollboothSFTR2 or s == tollboothLSSF or s == tollboothSFLS and dimension then
			if getElementType (leaveElement) == "player" and isPedInVehicle (leaveElement) then
				triggerClientEvent (leaveElement, "manageTollGUI", leaveElement, 2)
			end
		end
	end
)

addEvent ("tollPaid", true)
function openRamp (freePass)
	if isElementWithinMarker (source, tollboothLSSF) and not isTimer (ob13) then
		moveObject (tollbarrierLSSF, 1000, 51.7, -1528.1, 5.2, 0, -90, 0)
		setTimer (moveObject, 3500, 1, tollbarrierLSSF, 1000, 51.7, -1528.1, 5.2, 0, 90, 0)
		ob13 = setTimer (function () end, 5000, 1)
	elseif isElementWithinMarker (source, tollboothSFLS) and not isTimer (ob14) then
		moveObject (tollbarrierSFLS, 1000, 53.7, -1535, 5.2, 0, 90, 0)
		setTimer (moveObject, 3500, 1, tollbarrierSFLS, 1000, 53.7, -1535, 5.2, 0, -90, 0)
		ob14 = setTimer (function () end, 5000, 1)
	end
	if not freePass then
		takePlayerMoney (source, tollPrice)
	end
end
addEventHandler ("tollPaid", root, openRamp)

addEvent ("manageImpulses", true)
addEventHandler ("manageImpulses", root,
	function (value)
		local acc = getPlayerAccount (source)
		if value == 1 then
			if not getAccountData (acc, "toll.impulses") then
				setAccountData (acc, "toll.impulses", 1)
			else
				setAccountData (acc, "toll.impulses", getAccountData (acc, "toll.impulses") + 1)
			end
			outputChatBox ("[NPC]¡Compraste un Ticket!, ahora tienes: #ffffff"..getAccountData (acc, "toll.impulses"), source, 10, 230, 10, true)
			takePlayerMoney (source, tollPrice)
		elseif value == 2 then
			givePlayerMoney (source, tollPrice)
			setAccountData (acc, "toll.impulses", getAccountData (acc, "toll.impulses") - 1)
			outputChatBox ("[NPC]¡Rembolsaste un Ticket! te restan: #ffffff"..getAccountData (acc, "toll.impulses"), source, 255, 130, 0, true)
		end
	end
)