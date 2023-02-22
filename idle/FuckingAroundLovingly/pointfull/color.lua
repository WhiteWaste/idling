local class = require("pointfull.class")
Color = class:derive("Color")

function Color:new(red, green, blue, alpha)
    self.r = (red / 255) or 1
    self.g = (green / 255) or 1
    self.b = (blue / 255) or 1
    self.a = (alpha / 255) or 1
end

function Color:setColor()
    love.graphics.setColor(self.r, self.g, self.b, self.a)
end

function Color:setBackground()
    love.graphics.setBackgroundColor(self.r, self.g, self.b, self.a)
end

Color.White = Color(255, 255, 255, 255)
Color.Black = Color(0, 0, 0, 255)

Color.Red = Color(255, 0, 0, 255)
Color.DarkRed = Color(127, 0, 0, 255)

Color.Green = Color(0, 255, 0, 255)
Color.DarkGreen = Color(0, 127, 0, 255)

Color.Blue = Color(0, 0, 255, 255)
Color.DarkBlue = Color(0, 0, 127, 255)

Color.Yellow = Color(255, 255, 0, 255)
Color.DarkYellow = Color(127, 127, 0, 255)

Color.Pink = Color(255, 0, 255, 255)
Color.DarkPink = Color(127, 0, 127, 255)

Color.Cyan = Color(0, 255, 255, 255)
Color.DarkCyan = Color(0, 127, 127, 255)

return Color