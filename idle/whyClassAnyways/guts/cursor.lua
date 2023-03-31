local Window = require "guts.window"

local Cursor = {}

Cursor._ = {}
Cursor._.onRMB = List.new("onRMB")
Cursor._.onLMB = List.new("onLMB")
Cursor._.onMMB = List.new("onMMB")

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

---attaches a function on the given mouse button
---@param buttonName mouseButtons
---@param func function
---@param functionName string
function Cursor.attachFunction(buttonName, func, functionName)
    Cursor._["on"..buttonName]:addItem(func, functionName)
end

---detaches the function under the given key
---@param buttonName mouseButtons
---@param functionName string
function Cursor.dettachFunction(buttonName, functionName)
    Cursor._["on"..buttonName]:removeItem(functionName)
end

return Cursor