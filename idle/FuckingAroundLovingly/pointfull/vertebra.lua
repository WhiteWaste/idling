local Point = require "pointfull.point"

local class = require("pointfull.class")
local Vert = class:derive("Vertebra")

function Vert:new(position, lenght, angle)
    self.root = position or Point()
    self.lenght = lenght
    self.angle = angle
end

function Vert:getEndPoint()
    return Point(self.root.x + math.cos(self.angle) * self.lenght, self.root.y + math.sin(self.angle) * self.lenght)
end

function Vert:pointAt(targetPoint)
    local dirX = targetPoint.x - self.root.x
    local dirY = targetPoint.y - self.root.y

    self.angle = math.atan2(dirY, dirX)
end

function Vert:reachFor(targetPoint)
    self:pointAt(targetPoint)

    self.root.x = targetPoint.x - math.cos(self.angle) * self.lenght
    self.root.y = targetPoint.y - math.sin(self.angle) * self.lenght
end

function Vert:draw()
    local ep = self:getEndPoint()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.line(self.root.x, self.root.y, ep.x, ep.y)
end

return Vert