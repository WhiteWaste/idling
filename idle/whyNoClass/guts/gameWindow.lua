local Clock = require "guts.clock"

local Object = require "guts.object"

local Shape = require "guts.shape2d"
local Vector = require "guts.vector2d"
local Color = require "guts.color"

local Cable = require "guts.cable"
local GameWindow = Cable:derive('GameWindow')

-- manages the resolution of the screen. Can't use vectors 'ere since they need the screen for some functions  
function GameWindow:new(title, screenSize, resolution)
    love.window.setTitle(title) -- sets and saves the title of game
    GameWindow.title = title
    
    love.graphics.setDefaultFilter("nearest", "nearest") -- makes pixels pixely

    -- the size of the screen
    GameWindow.screenSize = screenSize or Vector(1080, 720)
    -- the amount of pixels on the screen
    GameWindow.resolution = resolution or Vector(320, 240)
    
    -- the scale of the difference between the resolution and screen size
    GameWindow.scale = Vector(GameWindow.screenSize.x / GameWindow.resolution.x, GameWindow.screenSize.y / GameWindow.resolution.y)
    
    -- creates a canvas with the size of the resolution that gets upscailed by he scales in the draw function
    GameWindow.window = love.graphics.newCanvas(GameWindow.resolution.x, GameWindow.resolution.y)
    
    -- sets up the screen stats to reflect the input 
    love.window.setMode(GameWindow.screenSize.x, GameWindow.screenSize.y, {resizable = true, minwidth = GameWindow.resolution.x, minheight = GameWindow.resolution.y})
    Vector:getScreenStats(GameWindow.screenSize, GameWindow.resolution)
end

function GameWindow:onResize(newWidth, newHeight)
    GameWindow(self.title, Vector(newWidth, newHeight), self.resolution)
end

function GameWindow:onLoad()
    love.window.setVSync(0)
    love.graphics.setLineJoin('bevel')

    love.graphics.setLineStyle('rough')
    love.graphics.setLineWidth(2)

    print("Game is loaded")
    local tile = require('assets.tile')
    local middlePoint = Object('middlePoint', Shape:point(Vector:center(), Color.magenta))

    for i, obj in ipairs(Object.objects:getItems()) do
        obj:onLoad()
    end
end

function GameWindow:onUpdate(dt)
    Clock:run()
    --love.keyboard.keysPressed = {}
    
    for i, obj in ipairs(Object.objects:getItems()) do
        obj:onUpdate()
    end
end

function GameWindow:onDraw()
    --[[
    for i, obj in ipairs(Object.objects:getItems()) do
        obj:onDraw()
    end
    --]]
    love.graphics.setCanvas(GameWindow.window)
        --love.graphics.clear()
        Color.blue:setBackgroundColor()

        for i, obj in ipairs(Object.objects:getItems()) do
            obj:onDraw()
        end
    love.graphics.setCanvas()

    love.graphics.draw(GameWindow.window, 0, 0, 0, GameWindow.scale.x, GameWindow.scale.y)

end

return GameWindow