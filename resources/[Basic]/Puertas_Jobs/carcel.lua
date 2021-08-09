local puertas = {

	{ID=1,Modelo=1495,Pos={526.200,451.3,1020.7},Rot={0,0,270},Mov={526.200,452.899,1020.7},Int=6},
	{ID=2,Modelo=1495,Pos={526.200,455.4,1020.7},Rot={0,0,270},Mov={526.200,456.899,1020.7},Int=6},
	{ID=3,Modelo=1495,Pos={526.200,459.4,1020.7},Rot={0,0,270},Mov={526.200,460.899,1020.7},Int=6},
	{ID=4,Modelo=1495,Pos={526.200,463.4,1020.7},Rot={0,0,270},Mov={526.200,465,1020.7},Int=6},
	{ID=5,Modelo=1495,Pos={526.200,467.5,1020.7},Rot={0,0,270},Mov={526.200,469,1020.7},Int=6},
}

local Puerta = {}
local Mov = {}
local Pos = {}

function constructor()
	for i,array in ipairs(puertas) do
		Puerta[i] = createObject(array.Modelo, array.Pos[1],array.Pos[2],array.Pos[3], array.Rot[1],array.Rot[2],array.Rot[3])
		Mov[i] = array.Mov
		Pos[i] = array.Pos
		setElementFrozen(Puerta[i], true )
		setElementInterior(Puerta[i], array.Int)
	end
end
addEventHandler( "onResourceStart", getResourceRootElement( ),constructor) 

function abrirpuertas(player,cmd,data)
	--if player:getData("Roleplay:faccion") == "Policia" then
		if tonumber(data) then
			for ind,va in ipairs(puertas) do
				if tonumber(data) == tonumber(va.ID) then
					Puerta[ind]:move(2500, Mov[ind][1],Mov[ind][2],Mov[ind][3])
					setTimer(function()
						Puerta[ind]:move(2500, Pos[ind][1],Pos[ind][2],Pos[ind][3])
					end,5000,1)
					break
				end
			end
		elseif data == "all" then
			for ind,va in ipairs(puertas) do
				Puerta[ind]:move(2500, Mov[ind][1],Mov[ind][2],Mov[ind][3])
				setTimer(function()
					Puerta[ind]:move(2500, Pos[ind][1],Pos[ind][2],Pos[ind][3])
				end,7000,1)
			end
		else
			player:outputChat("Syntax: /abrirc [12345 o all]",255,0,0,true)
		end
	--end
end
addCommandHandler("abrirc",abrirpuertas)

local Marcador = Marker( 489.935546875, 443.466796875, 1025.8203125-1, "cylinder", 2.2, 100, 100, 100, 0)
setElementInterior(Marcador, 6)


local playerWeapons = {}

function getPedWeapons(ped)
	for i=0, 12 do 
		if getPedWeapon( ped, i ) then
				local v = getPedWeapon( ped, i )
				local muni = getPedTotalAmmo(ped,i)
			if v and v ~= 0 then
				if muni and muni ~= 0 then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
					playerWeapons[ped] = true	
				end	
			end 
		end
	end
	if playerWeapons[ped] == true then
		return true
	else
		return false
	end
end

addEventHandler("onMarkerHit",Marcador,function(other)
	if other:getData("Roleplay:faccion") ~= "Policia" then
		if getPedWeapons( other ) == true then
			for i=0, 12 do 
				local v = getPedWeapon( other, i )
				local muni = getPedTotalAmmo(other,i)
				if v and v ~= 0 then
					if muni and muni ~= 0 then
						if getPedWeapon( other, i ) then
							takeWeapon( other, v )
							giveWeapon( other, v , muni )
							triggerClientEvent(other,"playalarm",other)
							playerWeapons[other] = nil
						end
					end
				end
			end
		end
	end
end)