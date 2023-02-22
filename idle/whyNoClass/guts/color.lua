local Cable = require "guts.cable"
local Color = Cable:derive("Color")

-- a collection of 4 float values between 1 and 0 to serve the purposes of the love gods
function Color:new(red, green, blue, alpha) -- takes values from 0 to 255 like any other normal color variable
    self.r = red or 255
    self.g = green or 255
    self.b = blue or 255
    self.a = alpha or 255

    -- fixes up the values for love
    self.r = self.r / 255
    self.g = self.g / 255
    self.b = self.b / 255
    self.a = self.a / 255
end

-- sets the color of everything that gets drawn after the function
function Color:setColor()
    love.graphics.setColor(self.r, self.g, self.b, self.a)
end

-- sets the background color, here mostly for posterity 
function Color:setBackgroundColor()
    love.graphics.setBackgroundColor(self.r, self.g, self.b, self.a)
end

-- a collection of simpler colors I thought of 

Color.white = Color()
Color.black = Color(0, 0, 0)

Color.red = Color(255, 0, 0)
Color.darkRed = Color(128, 0, 0)

Color.green = Color(0, 255, 0)
Color.darkGreen = Color(0, 128, 0)

Color.blue = Color(0, 0, 255)
Color.darkBlue = Color(0, 0, 128)

Color.yellow = Color(255, 255, 0)
Color.darkYellow = Color(127, 127, 0)

Color.magenta = Color(255, 0, 255)
Color.darkMagenta = Color(127, 0, 127)

Color.cyan = Color(0, 255, 255)
Color.darkCyan = Color(0, 127, 127)

return Color