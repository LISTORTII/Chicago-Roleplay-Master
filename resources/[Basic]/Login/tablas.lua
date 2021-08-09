--loadstring(exports['[CR]Exports']:getMyCode())()
--import('*'):init('[CR]Exports')

function dxDrawText2(t, x, y, w, h, over, c, ...)
	local color = isCursorOver(x,y,w,h) and (over or c) or c
	return dxDrawText(t, x,y,w+x,h+y, color, ...)
end

function dxDrawRectangle2(x,y,w,h,color,gui)
	local r,g,b,a = colorToRgba(color)
	local color = isCursorOver(x,y,w,h) and not getKeyState'mouse1' and tocolor(r,g,b,a+50) or tocolor(r,g,b,a)
	local sX = isCursorOver(x,y,w,h) and getKeyState'mouse1' and Vector2(GuiElement.getScreenSize()).x*0.001 or 0
	local sY = isCursorOver(x,y,w,h) and getKeyState'mouse1' and Vector2(GuiElement.getScreenSize()).y*0.001 or 0
	return sX, sY, dxDrawRectangle(x+sX,y+sY,w-sX*2,h-sY*2, color, gui)
end

function dxDrawRecLined(x,y,w,h, color2, color, size, gui, bool)
	local sX,sY = 0,0
	if bool then
		sX, sY = dxDrawRectangle2(x,y,w,h,color2, gui)
	end
	local x,y,w,h = x+sX,y+sY,w-sX*2,h-sY*2
	dxDrawRectangle(x, y-(size+.1), w, size+.1,color, gui) --up
	dxDrawRectangle(x-size-.1, y-(size+.1), size-.1, h+(size+.1)*2,color, gui) --left
	dxDrawRectangle(x+w, y-(size+.1), size+.1, h+(size+.1)*2,color, gui) --right
	dxDrawRectangle(x, y+h, w, (size+.1),color, gui) --down
end

function colorToRgba(color)
   return bitExtract(color,16,8),bitExtract(color,8,8), bitExtract(color,0,8), bitExtract(color,24,8)
end

function isCursorOver(x,y,w,h)

	if isCursorShowing() then

		local sx,sy = guiGetScreenSize(  ) 
		local cx,cy = getCursorPosition(  )
		local px,py = sx*cx,sy*cy

		if (px >= x and px <= x+w) and (py >= y and py <= y+h) then

			return true

		end

	end
	return false
end


function isCursorText(x,y,w,h)

	if isCursorShowing() then

		local sx,sy = guiGetScreenSize(  ) 
		local cx,cy = getCursorPosition(  )
		local px,py = sx*cx,sy*cy
		local w,h = w-x, h-y

		if (px >= x and px <= x+w) and (py >= y and py <= y+h) then

			return true

		end

	end
	return false
end


