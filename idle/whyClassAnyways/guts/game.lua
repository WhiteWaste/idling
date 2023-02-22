Point = require "guts.point2d"
List = require "guts.list"

local Window = require "guts.window"
Cursor = require "guts.cursor"

Color = require "guts.graphics.color"
Shape = require "guts.graphics.shape2d"
Bone = require "guts.graphics.bone"


Text = require "guts.gui.text"
Button = require "guts.gui.button"

local Game = {}

Game.lists = {} -- holds lists of functions that get called in their respective functions

---gets called on every mouse click
function Game.onMouseClick()
    local mp = ""
    if Cursor.isDown(1) then
        mp = "onRMB"
    elseif Cursor.isDown(2) then
        mp = "onLMB"
    else
        mp = "onMMB"
    end

    for key, func in pairs(Game.lists[mp]:getItems()) do
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

    for key, value in pairs(Game.lists.onResize:getItems()) do
        value()
    end
end

--gets called on starting the game
function Game.onLoad()
    print("Game has loaded")
    Window.set('is game? maybe', nil, nil, { resizable = true})

    for key, value in pairs(Game.lists.onLoad:getItems()) do
        value()
    end

    Spine = require "guts.graphics.spine"
end

--gets called every frame
function Game:onUpdate(dt)
    for key, value in pairs(Game.lists.onUpdate:getItems()) do
        value()
    end
end

--gets called every frame
function Game.onDraw()
    love.graphics.setCanvas(Window.canvas)
        love.graphics.clear()
        love.graphics.print(Window.screenSize.x.." "..Window.screenSize.y)

        for index, layer in ipairs(Game.lists.onDraw) do
            for key, func in pairs(layer:getItems()) do
                func()
            end
        end
        Text.resetFont()
        Color.white:setColor()
    love.graphics.setCanvas()
    love.graphics.draw(Window.canvas, 0, 0, 0, Window.scale.x, Window.scale.y)
end





-- list of all functions that are called on resizing the screen
Game.lists.onResize = List:new("onResize")

Game.lists.onRMB = List:new('onRMB')
Game.lists.onLMB = List:new('onLMB')
Game.lists.onMMB = List:new('onMMB')

-- a list of all functions that gets called on loading of the game
Game.lists.onLoad = List:new("onLoad")

-- a list of all functions that gets called on every update call of the game
Game.lists.onUpdate = List:new("onUpdate")

-- a list of all functions that gets called on every draw call of the game
Game.lists.onDraw = {} -- holds the "layers" for  
Game.lists.onDraw[1] = List:new("layer1") -- only the first layer is set




---attaches a function to a chosen "bus" of the game's clock 
---@param bus buses
---@param func function the function that is passed to the list
---@param key string the key the function can be found at in the list
---@param layer? number only for onDraw. The lower the number the sooner the function will be called/drawn
function Game:attach(bus, func, key, layer)
    if bus == 'onDraw' then -- if the bus is onDraw the functions gets moved to one of it's layers
        layer = layer or #Game.lists.onDraw + 1 -- if no layer is given then it gets sent to the last 

        -- if the layer doesn't exist, it gets created, then the function gets added
        if Game.lists.onDraw[layer] == nil then
            Game.lists.onDraw[layer] = List:new("layer"..layer)
        end

        Game.lists.onDraw[layer]:addItem(func, key)
    else
        -- if anything other onDraw is chosen it just gets shoved in
        Game.lists[bus]:addItem(func, key)
    end
end

---removes the item from the selected bus. Layer is only for onDraw
---@param bus buses
---@param key string the key the function can be found at in the list
---@param layer? number
function Game:detach(bus, key, layer)
    layer = layer or #Game.lists.onDraw
    if bus == 'onDraw' then
        Game.lists.onDraw[layer]:removeItem(key)
        return
    end

    Game.lists[bus]:removeItem(key)
end

return Game