local Color = require("pointfull.color")
local class = require("pointfull.class")

Point = class:derive("Point")

function Point:new(x, y)
    self.x = x or love.graphics.getWidth() / 2
    self.y = y or love.graphics.getHeight() / 2
end

return Point