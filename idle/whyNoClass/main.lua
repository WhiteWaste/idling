local gw = require "guts.gameWindow"
local Vector = require "guts.vector2d"
local Game = gw("game window")

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    love.keyboard.keysPressed = {}

    Game:onLoad()
end

function love.resize(w, h)
    Game:onResize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Game:onUpdate()
end

function love.draw()
    Game:onDraw()
end

