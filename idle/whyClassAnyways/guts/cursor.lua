local Window = require "guts.window"

local Cursor = {}

---returns the Cursors' current position relative to the resolution in pixels
---@return Point
function Cursor.getPosition()
    return Point.new(love.mouse.getX(), love.mouse.getY())
end

---sets the position of the 
---@param position any
function Cursor.setPosition(position)
    love.mouse.setPosition(position.x, position.y)
end

---returns true if a mouse button is pressed 1 = RMB, 2 = LMB, 3 = MMB
---@param button number
---@param ... number additional buttons to check
---@return boolean
function Cursor.isDown(button, ...)
    return love.mouse.isDown(button, ...)
end

return Cursor