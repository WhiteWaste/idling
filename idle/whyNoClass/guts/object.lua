local Clock = require "guts.clock"
local Vector = require "guts.vector2d"
local List = require "guts.list"
local Shape = require "guts.shape2d"

local Cable = require "guts.cable"
local Object = Cable:derive("Object") -- it's a name. 

Object.objects = List("objects") -- a collection of all instantiated objects

function Object:new(objectName, shape)
    self.name = objectName
    self.shape = shape or Shape:square()

    Object.objects:addItem(self)
end

-- the onLoad/Update/Draw functions get executed in their respective love2d functions by foreach loops
function Object:onLoad()
    print("["..self.name.."] loaded") -- the base onLoad function just writes the name of the loaded object into the console
end

-- the onLoad/Update/Draw functions get executed in their respective love2d functions by foreach loops
function Object:onUpdate(dt)
end

-- the onLoad/Update/Draw functions get executed in their respective love2d functions by foreach loops
function Object:onDraw()
    if self.shape ~= nil then self.shape:draw() end
end

-- remvoes the object that called it 
function Object:destroy(timeInSeconds)
    timeInSeconds = timeInSeconds or 0 -- calling it without arguments instatntly wipes it
    
    Clock:addTask(timeInSeconds + love.timer.getTime(), function() -- the destruction process gets logged to the clock
        print("["..self.name.."] am die")
        Object.objects:remove(self)
    end)
end



function Object:clone()
    --[[
    local name = "Clone of "..self.name
    ]]
    local shape = self.shape
    local clone = Object("Clone of "..self.name, Shape(shape.points:getItems(), Vector(shape.position.x, shape.position.y), shape.rotation, shape.lineColor, shape.isEnclosed))

    return clone
end

--[[
local obj = Object()
local obj2 = Object()

for i, obj in ipairs(Object.objects) do
    print(obj.name)
end
]]

return Object