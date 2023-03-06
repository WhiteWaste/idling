Point = require "guts.point2d"
List = require "guts.list"

local Window = require "guts.window"

Color = require "guts.graphics.color"
Text = require "guts.gui.text"

local Game = {}
Game.lists = {} -- holds lists of functions that get called in their respective functions

--[[-gets called on every mouse click
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
]]
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
    Window.set('is game? maybe', nil, nil, { resizable = true})

   
end

--gets called every frame
function Game:onUpdate(dt)
   
end

--gets called every frame
function Game.onDraw()
    
end

return Game