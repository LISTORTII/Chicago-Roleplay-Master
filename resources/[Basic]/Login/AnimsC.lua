local CamMatrix = {
	{
		from={-38.24741363525391, -4245.787109375, 3264.55908203125, -132.3813171386719, -4270.16015625, 3241.21875, 0, 70},
		to={-60.22302627563477, -4254.7109375, 3262.71337890625, -157.9282379150391, -4254.91357421875, 3241.414306640625, 0, 70}
	},
	{
		from={-60.22302627563477, -4254.7109375, 3262.71337890625, -157.9282379150391, -4254.91357421875, 3241.414306640625, 0, 70},
		to={-55.77018737792969, -4245.46923828125, 3262.71337890625, -60.57791519165039, -4340.455078125, 3231.8173828125, 0, 70}
	},
	{
		from={-55.77018737792969, -4245.46923828125, 3262.71337890625, -60.57791519165039, -4340.455078125, 3231.8173828125, 0, 70},
		to={ -39.662353515625, -4241.39453125, 3262.969970703125, -133.0203857421875, -4242.0771484375, 3227.1396484375, 0, 70}
	},
	{
		from={ -39.662353515625, -4241.39453125, 3262.969970703125, -133.0203857421875, -4242.0771484375, 3227.1396484375, 0, 70},
		to={-30.72762680053711, -4240.5625, 3262.39013671875, -129.8650360107422, -4244.40283203125, 3249.859130859375, 0, 70},
	}
}

local forward = {
	{
		{-52.0263671875, -4254.9365234375, 3261.4587402344, 357.3000793457},
		{-52.8525390625, -4251.494140625, 3261.4587402344, -87.103698730469},
		{-55.91015625, -4251.5009765625, 3261.4587402344, 357.10232543945},
		{-55.91015625, -4247.94140625, 3261.4587402344, 357.10232543945},
	},

	{
		{-55.91015625, -4247.94140625, 3261.4587402344, -299.33961181641},
		{-44.4169921875, -4241.5224609375, 3261.4587402344, -269.01806640625},
	},
	{
		{-34.4169921875, -4241.5224609375, 3261.4587402344, -269.01806640625},
	}

}

pedRolin = {}
local timerRotCa = {}
local Caminatas = {
	{
		{-60.98046875, -4252.380859375, 3261.4587402344, 357.18676757812},
		{-61.05078125, -4233.689453125, 3261.4587402344, 180.18676757812}
	},
	{
		{-35.64453125, -4248.548828125, 3261.4587402344, 88.13},
		{-83.197273254395, -4248.658203125, 3261.4587402344, 268.14465332031}
	}
}

local caminar = false
local cache = false

addEventHandler( "onClientRender", getRootElement(),
	function()

		if caminar and isElement(pedCreation) then

			local tip = caminar.tip
			local mat = #caminar.matrix
			local i = caminar.index
			local p = pedCreation.position
			local r = pedCreation.rotation
			local to = Vector3(unpack(caminar.matrix[i],1,3))

			if getDistanceBetweenPoints3D(p, to) <= 0.5  then
				
				if pedCreation:getControlState('forwards') then
					pedCreation:setControlState('forwards', false)
					setPedControlState( pedCreation, 'walk', false )
				end

				tickRot = tickRot or getTickCount(  )
				setElementRotation(pedCreation, 0,0,caminar.matrix[i][4])--math.lerp(r.z, matrix[i][4], (getTickCount(  ) - tickRot) / 2000))


				if not timerRot or not timerRot:isValid() then
					caminar = false
					if not (i+1 > mat) then
						forwardPed(tip, pedCreation, i+1)
					elseif tip < #forward then
					--	forwardPed(tip+1, ped, 1)
					end
				end

				
			elseif getDistanceBetweenPoints3D(p, to) > 0.5 then
				if not pedCreation:getControlState('forwards') then
					pedCreation:setControlState('forwards', true)
					setPedControlState( pedCreation, 'walk',  true )
				end
				tickRot = false
			end
			
			
		end

		if #pedRolin > 0 then

			for i, ped in ipairs(pedRolin) do

				local ii = (ped:getData('index') or 1)
				local p = ped.position
				local r = ped.rotation
				local to = Vector3(unpack(Caminatas[i][ii],1,3))

				if getDistanceBetweenPoints3D(p, to) <= 0.25 then
					
					ped.position = to
					if ped:getControlState('forwards') then
						ped:setControlState('forwards', false)
						setPedControlState( ped, 'walk', false )
					end

					setElementRotation(ped, 0,0,Caminatas[i][ii][4])

					timerRotCa[ped] = timerRotCa[ped] or getTickCount(  )
					if getTickCount(  ) - timerRotCa[ped] > 5000 then
						ped:setData('index', 3 - ii)
						timerRotCa[ped] = nil
					end

					
				elseif getDistanceBetweenPoints3D(p, to) > 0.25 then
					ped.rotation = Vector3(0,0,findRotation(p.x, p.y, to.x,to.y))
					if not ped:getControlState('forwards') and not timerRotCa[ped] then
						ped:setControlState('forwards', true)
						setPedControlState( ped, 'walk',  true )
					end
				end
			
			end	
		end

		if cache then
		
			local cx, cy, cz, lx, ly, lz = getCameraMatrix()
			local toX, toY, toZ, tolx, toly, tolz = unpack(cache.to)
		
	        local x1, y1, z1, lx1, ly1, lz1 = cx, cy, cz, lx, ly, lz
	        local x2, y2, z2, lx2, ly2, lz2 = toX, toY, toZ, tolx, toly, tolz

	        local alpha = math.min(1, (getTickCount()-cache.tTimer) / 30000)
	        local df, dy, dz, dxl, dly, dlz = math.lerp(x1, x2, alpha), math.lerp(y1, y2, alpha),math.lerp(z1, z2, alpha),math.lerp(lx1, lx2, alpha),math.lerp(ly1, ly2, alpha),math.lerp(lz1, lz2, alpha),math.lerp(180, 0, alpha)
	       	
	       	setCameraMatrix(df, dy, dz, dxl, dly, dlz)

	       	if alpha >= 1 then
	       		cache = nil
	       	end

    	end

    	if camInicial then

			local x1, y1, z1, lx1, ly1, lz1 = 1440.174072265625, -882.0802001953125, 470.0768127441406, 1442.820678710938, -964.7522583007813, 413.8777770996094
	        local x2, y2, z2, lx2, ly2, lz2 = 1548.824462890625, -1345.34814453125, 330.4664001464844, 1549.069580078125, -1349.340576171875, 329.4664001464844

	        local alpha = math.min(1, (getTickCount()-camInicial) / 8000)
	        local df, dy, dz, dxl, dly, dlz, rol = math.lerp(x1, x2, alpha), math.lerp(y1, y2, alpha),math.lerp(z1, z2, alpha),math.lerp(lx1, lx2, alpha),math.lerp(ly1, ly2, alpha),math.lerp(lz1, lz2, alpha),math.lerp(180, 0, alpha)
	       	
	       	setCameraMatrix(df, dy, dz, dxl, dly, dlz, rol)

	       	if getTickCount()-camInicial > 8000 and alpha >= 1 then
	       		camInicial = nil
	       	end
	       	
	    end
 		
 		if camChangePj then

 			local posV = camChangePj.ped.position + camChangePj.ped.matrix.forward * 4
 			local x1, y1, z1, lx1, ly1, lz1 = getCameraMatrix()
	        local x2, y2, z2, lx2, ly2, lz2 = posV:getX(),posV:getY(),posV:getZ() + 1, camChangePj.ped.position:getX(),camChangePj.ped.position:getY(),camChangePj.ped.position:getZ()

	        local alpha = math.min(1, (getTickCount()-camChangePj.tick) / 4000)
	        local df, dy, dz, dxl, dly, dlz = math.lerp(x1, x2, alpha), math.lerp(y1, y2, alpha),math.lerp(z1, z2, alpha),math.lerp(lx1, lx2, alpha),math.lerp(ly1, ly2, alpha),math.lerp(lz1, lz2, alpha)
	       	
	       	setCameraMatrix(df, dy, dz, dxl, dly, dlz)

	       	if getTickCount()-camChangePj.tick >= 4000 and alpha >= 1 then
	       		camChangePj = nil
	       	end

 		end

 		if camFainal then

 			local x1, y1, z1, lx1, ly1, lz1 = camFainal.cam[1],camFainal.cam[2],camFainal.cam[3],camFainal.cam[4],camFainal.cam[5],camFainal.cam[6]
	        local x2, y2, z2, lx2, ly2, lz2 = camFainal[1], camFainal[2], z1, lx1, ly1, getGroundPosition( x1, y1, z1 )

	        local alpha = math.min(1, (getTickCount()-camFainal.tick) / 5000)
	        local df, dy, dz, dxl, dly, dlz = math.lerp(x1, x2, alpha), math.lerp(y1, y2, alpha),math.lerp(z1, z2, alpha),math.lerp(lx1, lx2, alpha),math.lerp(ly1, ly2, alpha),math.lerp(lz1, lz2, alpha)
	       	
	       	setCameraMatrix(df, dy, dz, df, dy, getGroundPosition( df, dy, dz ))

	       	if alpha >= 1 then
	       		if not camFainal2 then
	       			camFainal2 = {camFainal[1], camFainal[2], getGroundPosition( camFainal[1], camFainal[2], camFainal[3]) + 15,
	       				cam = {df, dy, dz, dxl, dly, dlz},
						tick = getTickCount(  ),
					}
				end
				local x1, y1, z1, lx1, ly1, lz1 = camFainal2.cam[1],camFainal2.cam[2],camFainal2.cam[3],camFainal2.cam[4],camFainal2.cam[5],camFainal2.cam[6]
 				local x2, y2, z2, lx2, ly2, lz2 = camFainal2[1], camFainal2[2], camFainal2[3], camFainal2[1], camFainal2[2], camFainal2[3]

	        	local alpha = math.min(1, (getTickCount()-camFainal2.tick) / 2500)
	        	local df, dy, dz, dxl, dly, dlz = math.lerp(x1, x2, alpha), math.lerp(y1, y2, alpha),math.lerp(z1, z2, alpha),math.lerp(lx1, lx2, alpha),math.lerp(ly1, ly2, alpha),math.lerp(lz1, lz2, alpha)
	    		
	    		setCameraMatrix(df, dy, dz, df, dy, getGroundPosition( df, dy, dz ))

	    		if alpha >= 1 then
		       		camFainal2 = nil
		       		camFainal = nil
		       		fadeCamera(false)
		       		setTimer(fadeCamera, 3000,1, true, 0.2)
		       		setTimer(setCameraTarget,3100,1,localPlayer)		
		       	end

	       	end

 		end

	end
)

function forwardPed(tip, ped, index)

	if index > 1 then
		setElementRotation(ped, 0,0,forward[tip][index-1][4])
	end

	caminar = {
		tip = tip,
		matrix = forward[tip],
		index = index or 1,
	}

end

function onCameraInicial(n)
	if not n then
		camInicial = nil
	else
		camInicial = getTickCount(  )
	end
end

function changeCameraPed(ped)
	if not isElement(ped) then
		camChangePj = nil
	else
		camChangePj = {}
		camChangePj.ped = ped
		camChangePj.tick = getTickCount(  )
	end
end


function displayCinematic(tip, time, reverse)
	if not tip then
		cache = false
		return
	end

	cache = {}

	if reverse then
		cache.from = CamMatrix[tip].to
		cache.to = CamMatrix[tip].from
	else
		cache.from = CamMatrix[tip].from
		cache.to = CamMatrix[tip].to
	end

	setCameraMatrix(unpack(cache.from))

	cache.tTimer = getTickCount(  )
	cache.time = 6000
end

function onCamFinal(x,y,z)
	local x1, y1, z1, lx1, ly1, lz1 = getCameraMatrix()
	local x2, y2, z2, lx2, ly2, lz2 = x1, y1, z1 + 1, lx1, ly1, getGroundPosition( x1, y1, z1 )
	setCameraMatrix(x2, y2, z2, lx2, ly2, lz2)
	camFainal = {x,y,z,
		tick = getTickCount(  ),
		cam = {getCameraMatrix(x2, y2, z2, lx2, ly2, lz2)}
	}
end


function showPedRoling()
	pedRolin = {Ped(217, -61.05078125, -4233.689453125, 3261.4587402344, 180.18676757812), Ped(211, -83.299812316895, -4248.2421875, 3261.4587402344, 267.7216796875)}
end

function removePedRoling()
	if isElement(pedRolin[1]) then
		pedRolin[1]:destroy()
		pedRolin[1] = nil
	end
	if isElement(pedRolin[2]) then
		pedRolin[2]:destroy()
		pedRolin[2] = nil
	end
end


function Vector3:compare( comparison, precision )
	assert( type( comparison.getLength ) == 'function', "First argument must be a Vector3." )
	assert( not precision or type( precision ) == 'number', "Precision type must be a number, got " .. type( precision ) .. "." )

	if ( not precision ) then
		if ( self:getX( ) ~= comparison:getX( ) ) or
		   ( self:getY( ) ~= comparison:getY( ) ) or
		   ( self:getZ( ) ~= comparison:getZ( ) ) then
			return false
		end
	else
		if ( math.abs( self:getX( ) - comparison:getX( ) ) > precision ) or
		   ( math.abs( self:getY( ) - comparison:getY( ) ) > precision ) or
		   ( math.abs( self:getZ( ) - comparison:getZ( ) ) > precision ) then
			return false
		end
	end

	return true
end




function factorCompare(x,y,p)
	if not p then
		if x == y then
			return true
		end
	else
		if x - y <= p then
			return true
		end
	end
	return false
end

function math.lerp(from, to, alpha)
	return from + (to-from) * alpha
end

function math.maxmin(...)
	return math.max(...), math.min(...)
end

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end