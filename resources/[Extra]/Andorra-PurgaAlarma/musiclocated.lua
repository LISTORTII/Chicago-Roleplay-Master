-- by AndrixX'
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
local desusound =playSound3D("desusound.mp3",1317.39063, -65.03819, 36.03524, true)
setSoundVolume(desusound,1.5)
setSoundMaxDistance(desusound, 10000)
    end
	           )
function stopMySound()
    stopSound( desusound )
end
addCommandHandler ( "apagarmusica", stopMySound )