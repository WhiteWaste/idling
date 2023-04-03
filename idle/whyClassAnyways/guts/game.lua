Point = require "guts.point2d"
List = require "guts.list"
Color = require "guts.graphics.color"

FileSystem = require "guts.fileSystem"
Graphics = require "guts.graphics"

GameClock = require "guts.gameClock"
Window = require "guts.window"
Cursor = require "guts.cursor"

local Game = {}

---gets called on every mouse click
function Game.onMouseClick()
    local pressedMouseButton = "" -- holds the channel of the clicked button
    if love.mouse.isDown(1) then
        pressedMouseButton = "onRMB"
    elseif love.mouse.isDown(2) then
        pressedMouseButton = "onLMB"
    else
        pressedMouseButton = "onMMB"
    end

    -- runs the attached functions of the clicked mouse button
    for functionName, func in pairs(Cursor._[pressedMouseButton]:getItems()) do
        func()
    end
end

---gets called on every keypress of the keyboard
---@param key love.KeyConstant
function Game.onKeyboardPress(key)
    if key == 'escape' then love.event.quit() end
end

--gets called upon resizing the screen
function Game.onResize(w, h)
    Window:resize(w, h)
end

--gets called on starting the game
function Game.onLoad()
    print("Game has loaded")
    Window.set('is game? maybe', nil, nil)

    Graphics.addFromAssets()
    Graphics.setTheLoveBaseFontAsDefault()
    Window.startWriting(1, "test", { fontColor = Color.red }, Point.new(50, 50))
end

--gets called every frame
function Game:onUpdate(dt)
    GameClock.deltaTime = dt
    for functionName, func in pairs(GameClock._.onUpdate:getItems()) do
       func()
    end
end

--gets called every frame
function Game.onDraw()
    for layerName, layer in pairs(Window.drawLayers) do
        for functionName, func in pairs(layer:getItems()) do
            func()
        end
    end
end

return Game