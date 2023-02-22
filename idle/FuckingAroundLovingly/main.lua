local Object = require("pointfull.object")
local vert = require("pointfull.vertebra")
--local PLR = require("player")
local vertest = vert(Point(), 40, 1)
function love.load()
    for i, obj in pairs(Object.objects) do
       obj:onLoad()
    end
end

function love.update(dt)
    for i, obj in pairs(Object.objects) do
        obj:onUpdate()
    end

    --local x, y = love.mouse.getPosition()
    vertest:reachFor(Point(love.mouse.getX(), love.mouse.getY()))
end

function love.draw()
    for i, obj in pairs(Object.objects) do
        obj:onDraw()
    end

    vertest:draw()
end
