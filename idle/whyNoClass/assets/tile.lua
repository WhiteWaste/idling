local Shape = require "guts.shape2d"
local Vector = require "guts.vector2d"
local Color = require "guts.color"

local lineWidth = 128
--ineWidth = lineWidth * 2
local halfLineWidth = lineWidth / 2
local shaPoints = {
    Vector(lineWidth, 0),
    Vector(0, -lineWidth),
    Vector(-lineWidth, 0),
    Vector(0, lineWidth),
    Vector(lineWidth, 0),

    Vector(lineWidth, halfLineWidth),
    Vector(0, lineWidth + halfLineWidth),
    Vector(0, lineWidth),
    Vector(0, lineWidth + halfLineWidth),
    Vector(-lineWidth, halfLineWidth),
    Vector(-lineWidth, 0)
}

local Object = require "guts.object"
local Tile = Object("Tile", Shape:square()) --Object("Tile", Shape(shaPoints, Vector:center(), 0, Color.red, false)) -- 

return Tile