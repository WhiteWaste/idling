local Frame = require("pointfull.point")

local class = require("pointfull.class")
Object = class:derive("Object")

Object.objects = {} -- table of all objects, hopefully
Object.createNew = {} -- table of functions for creating new objects

-- executor object, executes functions whilst it exists, if it any are added 

function Object.createNew:executor(objectName)
    local newObject = setmetatable({}, Object)

    newObject.name = objectName
    newObject.base = Object

    Object.objects[objectName] = newObject
    return newObject
end

-- construct, an array of points used to for a shape/image

function Object.createNew:construct(objectName, position, pointConstellation)
    local newObject = Object.createNew:executor(objectName)

    newObject.root = position

    return newObject
end

-- troupe, a collection fo actors(visages), takes a position 

function Object.createNew:troupe(objectName, actors)
    local newObject = Object.createNew:actor(objectName, actors)

    return newObject
end

function Object:onLoad() end
function Object:onUpdate() end
function Object:onDraw() end

return Object