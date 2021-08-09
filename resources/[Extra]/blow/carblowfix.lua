setTimer(
function ( )
	for _, vehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
	 if getElementHealth(vehicle) < 301 then
	 setVehicleDamageProof( vehicle, true)
	 setVehicleEngineState( vehicle, false)
 else
     if getElementHealth(vehicle) > 302 then
	 setVehicleDamageProof( vehicle, false)
	 setVehicleEngineState( vehicle, true)
   end
  end
 end
end,
100, 0
)