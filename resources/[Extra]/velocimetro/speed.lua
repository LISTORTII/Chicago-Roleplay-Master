local sx, sy = guiGetScreenSize()
local px, py = 1600, 900
local rx, ry = (sx / px), (sy / py)
local circleShader = dxCreateShader("circle.fx")
local fontN = dxCreateFont("Certege.ttf", ry * 56)
local fontT = dxCreateFont("Certege.ttf", ry * 14)
local chekState = false

function getSpeed(element)
	local vx, vy, vz = getElementVelocity(element)
	local speed = ((vx ^ 2 + vy ^ 2 + vz ^ 2) ^ (0.6)) * 180
	return speed
end

function getCircle(x, y, width, height, color, angleStart, angleSweep, borderWidth)
	if angleSweep < 360 then
		angleEnd = math.fmod(angleStart + angleSweep, 360)
	else
		angleStart = 0
		angleEnd = 360
	end
	dxSetShaderValue(circleShader, "sCircleWidthInPixel", width)
	dxSetShaderValue(circleShader, "sCircleHeightInPixel", height)
	dxSetShaderValue(circleShader, "sBorderWidthInPixel", borderWidth)
	dxSetShaderValue(circleShader, "sAngleStart", math.rad(angleStart) - math.pi)
	dxSetShaderValue(circleShader, "sAngleEnd", math.rad(angleEnd) - math.pi)
	dxDrawImage(x, y, width, height, circleShader, 0, 0, 0, color)
end

addEventHandler("onClientRender", root,
	function()
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			local maxFuel = 100
			local fuel = getElementData(vehicle, "Fuel") or 0
			local result = fuel / maxFuel * 90
			local distance = getElementData(vehicle, "distance") or 0
			local distance = math.floor(distance / 1000)
			local speed = math.floor(getSpeed(vehicle))
			local hp = getElementHealth(vehicle)
			if distance < 10 then
				tdistance = "00000"..distance
			elseif distance < 100 then
				tdistance = "0000"..distance
			elseif distance < 1000 then
				tdistance = "000"..distance
			elseif distance < 10000 then
				tdistance = "00"..distance
			elseif distance < 100000 then
				tdistance = "0"..distance
			else
				tdistance = distance
			end
			if speed < 10 then
				tspeed = "00"..speed
			elseif speed < 100 then
				tspeed = "0"..speed
			else
				tspeed = speed
			end
			if hp < 250 then
				text = "Leva el coche al mecanico !!!"
				color = tocolor(255, 25, 25, 175)
			elseif hp < 500 then
				text = "Daño severo!"
				color = tocolor(255, 255, 25, 175)
			elseif hp < 750 then
				text = "Daño Leve"
				color = tocolor(255, 255, 255, 175)
			else
				text = ""
				color = tocolor(255, 255, 255, 175)
			end
			if result < 20 then
				dxDrawText("Nesecita Repostar!", sx, sy-30, sx - ry * 160, sy - ry * 425, tocolor(239, 195, 138, 175), ry * 1.2, "default-bold", "right", "center", false, false, false, true)
			end
			dxDrawText(text, sx, sy, sx - ry * 160, sy - ry * 425, color, ry * 1.3, "default-bold", "right", "center", false, false, false, true)
			dxDrawText(tspeed, sx, sy * 2 - ry * 460, sx - ry * 130, ry * 200, tocolor(255, 255, 255, 130), 1, fontN, "right", "center", false, false, false, true)
			if speed > 0 then
				dxDrawText(speed, sx, sy * 2 - ry * 460, sx - ry * 130, ry * 200, tocolor(255, 255, 255, 255), 1, fontN, "right", "center", false, false, false, true)
			end
			dxDrawText("KM/H", sx, sy * 2 - ry * 380, sx - ry * 130, ry * 200, tocolor(255, 255, 255, 130), 1, fontT, "right", "center", false, false, false, true)
			getCircle(sx - ry * 240, sy - ry * 220, ry * 180, ry * 180, tocolor(219, 66, 66, 255), 0, hp/8+15, ry * 10)
			getCircle(sx - ry * 255, sy - ry * 236, ry * 210, ry * 210, tocolor(204, 144, 66, 130), 0, 90, ry * 8)
			getCircle(sx - ry * 255, sy - ry * 236, ry * 210, ry * 210, tocolor(239, 195, 138, 255), 90 - result, result, ry * 8)
			dxDrawImage(sx - ry * 130, sy - ry * 68, ry * 30, ry * 30, "engine.png", 0, 0, 0, tocolor(219, 66, 66, 255))
			dxDrawImage(sx - ry * 55, sy - ry * 120, ry * 20, ry * 20, "fuel.png", 0, 0, 0, tocolor(239, 195, 138, 255))
			dxDrawImage(sx - ry * 175, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 0, 0, 0, tocolor(255, 255, 255, 130))
			dxDrawImage(sx - ry * 215, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 180, 0, 0, tocolor(255, 255, 255, 130))
			if chekState then
				if getElementData(vehicle, "allflash") then
					dxDrawImage(sx - ry * 175, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 0, 0, 0, tocolor(255, 255, 25, 255))
					dxDrawImage(sx - ry * 215, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 180, 0, 0, tocolor(255, 255, 25, 255))
				elseif getElementData(vehicle, "leftflash") then
					dxDrawImage(sx - ry * 215, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 180, 0, 0, tocolor(255, 255, 25, 255))
				elseif getElementData(vehicle, "rightflash") then
					dxDrawImage(sx - ry * 175, sy - ry * 68, ry * 30, ry * 30, "arrow.png", 0, 0, 0, tocolor(255, 255, 25, 255))
				end
			end
		end
	end
)

setTimer(function()
	chekState = not chekState
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and getVehicleController(vehicle) == localPlayer then
		newX, newY, newZ = getElementPosition(vehicle)
		if oldX and oldY and oldZ then
			local curentDistance = getDistanceBetweenPoints3D(oldX, oldY, oldZ, newX, newY, newZ)
			if curentDistance >= 1 then
				local oldDistance = getElementData ( vehicle, "distance" ) or 0
				local totalDistance = oldDistance + curentDistance
				setElementData(vehicle, "distance", totalDistance)
			end
		end
		oldX, oldY, oldZ = newX, newY, newZ
	end
end, 600, 0)