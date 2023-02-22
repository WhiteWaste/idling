local Vector = require "guts.vector2d"
local List = require "guts.list"
local Color = require "guts.color"

local Cable = require "guts.cable"
local Shape2d = Cable:derive("Shape2d")

-- constructor for a shape, takes a table of vectors as "points", a position respective to which the points get drawn and a rotation(applied before drawing the points) 
function Shape2d:new(points, position, rotation, lineColor, closed)
    --closed = closed or true

    self.points = List("points of "..self.cableType)
    self.points:addItems(points) -- get them points
    if closed then
        self.points:addItem(self.points:getItemByIndex(1)) -- the first points also becomes the last to close the shape
    end

    self.position = position
    self.rotation = rotation

    self.lineColor = lineColor or Color() -- just the color of the lines, white as standart
    self.isEnclosed = closed
end

-- gets called in the onDraw function of objects
function Shape2d:draw()
    love.graphics.translate(self.position.x, self.position.y) -- sets the position of the shape
    love.graphics.rotate(self.rotation) -- sets rotation
    self.lineColor:setColor() -- sets its color

    local p1, p2 -- temporary variables to hold the vectors from the list 
    --local points, pointIndex = {}, 1
    for i = 1, #self.points.items - 1 do
        p1 = self.points:getItemByIndex(i)
        p2 = self.points:getItemByIndex(i + 1)
        
        love.graphics.line(p1.x, p1.y, p2.x, p2.y) -- draws a line between the temp variables
    end
    
    --love.graphics.line(points)

    Color.white:setColor()
    love.graphics.origin()
end

-- makes a simple square, takes a size and position as vectors, rotation and a color
-- if no variables are given it makes a white square centered on the screen without any rotation 
function Shape2d:square(size, position, rotation, color)
    size = size or Vector(16, 16) -- if no size makes the square 16x16

    local pointX, pointY = (size.x / 2), (size.y / 2) -- makes sure that the square is centered
    local points = { Vector(-pointX, -pointY), Vector(pointX, -pointY), Vector(pointX, pointY), Vector(-pointX, pointY) } -- sets up the list of vectors

    return Shape2d(points, position or Vector:center(), rotation or 0, color, true) -- returns the square
end

-- like a square but smol, only has a position and color
function Shape2d:point(position, color)
    return Shape2d:square(Vector(1, 1), position, 0, color) -- returns a smol square at the set position 
end

return Shape2d