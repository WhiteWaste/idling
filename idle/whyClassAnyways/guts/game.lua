Point = require "guts.point2d"
List = require "guts.list"
Sprite = require "guts.sprite"

GameClock = require "guts.gameClock"
Window = require "guts.window"
Cursor = require "guts.cursor"

--Color = require "guts.color"
local Game = {}

Game.channels = {}
Game.channels.onLoad = List.new("OnLoad") -- all functions in it get executed on the start 
Game.channels.onUpdate = List.new("OnUpdate") -- ... on every update of the gameclock

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

    for functionName, func in pairs(Game.channels.onResize:getItems()) do
        func()
    end
end

--gets called on starting the game
function Game.onLoad()
    print("Game has loaded")
    Window.set('is game? maybe', nil, nil)

    Sprite.addFromAssets()

    for functionName, func in pairs(Game.channels.onLoad:getItems()) do
        func()
    end
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