Point = require "guts.point2d"
List = require "guts.list"

Window = require "guts.window"
Cursor = require "guts.cursor"

--Color = require "guts.color"
Sprite = require "guts.sprite"
local Game = {}

Game.channels = {}
Game.channels.onLoad = List.new("OnLoad") -- all functions in it get executed on the start 
Game.channels.onResize = List.new("OnResize") -- ... on every resizing of the screen
Game.channels.onUpdate = List.new("OnUpdate") -- ... on every update of the gameclock

Game.channels.onDraw = {} -- onDraw has layers for easier... drawing. The lower the layer the sooner the object will be drawn 
Game.channels.onDraw[1] = List.new("Layer[1]") -- as standart it has only one layer

Game.channels.onRMB = List.new('OnRMB') -- ... on clicking the right mouse button
Game.channels.onLMB = List.new('OnLMB') -- ... the left 
Game.channels.onMMB = List.new('OnMMB') -- ... the scroll (does not include scrolling, only pressing the scroll)

---gets called on every mouse click
function Game.onMouseClick()
    local pressedMouseButton = "" -- holds the channel of the clicked button
    if Cursor.isDown(1) then
        pressedMouseButton = "onRMB"
    elseif Cursor.isDown(2) then
        pressedMouseButton = "onLMB"
    else
        pressedMouseButton = "onMMB"
    end

    -- runs the attached functions of the clicked mouse button
    for functionName, func in pairs(Game.channels[pressedMouseButton]:getItems()) do
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
    Window.set('is game? maybe', nil, nil, { resizable = true})
    Sprite.addFromAssets({ "testSquare" })

    for functionName, func in pairs(Game.channels.onLoad:getItems()) do
        func()
    end
end

--gets called every frame
function Game:onUpdate(dt)
    for functionName, func in pairs(Game.channels.onUpdate:getItems()) do
        func()
    end
end

--gets called every frame
function Game.onDraw()
    for layerIndex, layerList in ipairs(Game.channels.onDraw) do
        for functionName, func in pairs(layerList:getItems()) do
            func()
        end
    end
    love.graphics.draw(Sprite.sprites.items['testSquare'])
end

---comment
---@param channel channels
---@param func function
---@param functionName string
---@param drawIndex? number
function Game.attach(channel, func, functionName, drawIndex)
    if channel == "onDraw" then
        Game.channels[channel][drawIndex]:addItem(func, functionName)
        return
    end
    
    Game.channels[channel]:addItem(func, functionName)
end

return Game