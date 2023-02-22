local Color = require "guts.color"

local Cable = require "guts.cable"
local Line2D = Cable.cableBhv:derive('Line2D')

function Line2D:new(x, y, angle, length, color)
    self.root = {}

    self.root.x = x
    self.root.y = y

    self.angle = angle
    self.length = length

    self.color = color or Color:instantiate(255, 0, 0)
end

function Line2D:draw()
    local ex, ey = self:getEnd()
    love.graphics.line(self.root.x, self.root.y, ex, ey)
end

function Line2D:getEnd()
    local endX = self.root.x + math.cos(self.angle) * self.length
    local endY = self.root.y + math.sin(self.angle) * self.length
    
    return endX, endY
end

return Line2D