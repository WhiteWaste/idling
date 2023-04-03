local Color = {}
Color.__index = Color

---returns a color with the given rgba values
---@param red? number
---@param green? number
---@param blue? number
---@param alpha? number
---@return Color
function Color.new(red, green, blue, alpha)
    local c = setmetatable({}, Color)

    red = red or 255
    green = green or 255
    blue = blue or 255
    alpha = alpha or 255

    c.r = red / 255
    c.g = green / 255
    c.b = blue / 255
    c.a = alpha / 255

    return c
end

-- sets the color of everything drawn bellow the call of this function
function Color:setColor()
    love.graphics.setColor(self.r, self.g, self.b, self.a)
end

-- sets the background color
function Color:setBackgroundColor()
    love.graphics.setBackgroundColor(self.r, self.g, self.b, self.a)
end

function Color.resetColor()
    love.graphics.setColor(0, 0, 0)
end

Color.white = Color.new()
Color.gray = Color.new(127, 127, 127)
Color.black = Color.new(0, 0, 0)

Color.red = Color.new(255, 0, 0)
Color.darkRed = Color.new(127, 0, 0)

Color.blue = Color.new(0, 255, 0)
Color.darkBlue = Color.new(0, 127, 0)

Color.green = Color.new(0, 0, 255)
Color.darkGreen = Color.new(0, 0, 127)

Color.yellow = Color.new(255, 255, 0)
Color.darkYellow = Color.new(127, 127, 0)

Color.cyan = Color.new(0, 255, 255)
Color.darkCyan = Color.new(0, 127, 127)

Color.magenta = Color.new(255, 0, 255)
Color.darkMagenta = Color.new(127, 0, 127)

return Color