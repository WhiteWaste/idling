require "guts.guts"

function love.mousepressed()
    Game:onMouseClick()
end

function love.keypressed(key)
    Game.onKeyboardPress(key)
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.resize(w, h)
    Game.onResize(w, h)
end

function love.load()
    love.keyboard.keysPressed = {}

    Game:onLoad()
end

function love.update(dt)
    love.keyboard.keysPressed = {}
    Game:onUpdate(dt)
end

function love.draw()
    Game:onDraw()
end
