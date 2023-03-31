local Window = {}

Window.title = "Game Window"
Window.screenSize = Point.new(1080, 720)
Window.resolution = Point.new(640, 480)
Window.screenScale = Point.new(1, 1)

Window.drawLayers = {}
Window.drawLayers[1] = List.new('layer1')

---sets the screen's title, size and resolution
---@param title? string
---@param screenSize? Point
---@param resolution? Point
---@param flags? table
function Window.set(title, screenSize, resolution, flags)
    Window.title = title

    Window.screenSize = screenSize or Point.new(1080, 720)
    Window.resolution = resolution or Point.new(640, 480)
    Window.screenScale = Point.new(Window.screenSize.x / Window.resolution.x, Window.screenSize.y / Window.resolution.y)

    Window.flags = flags or {}
    love.window.setTitle(Window.title)
    love.window.setMode(Window.screenSize.x, Window.screenSize.y, flags)

    Point.getScreenSpecs(Window.screenSize, Window.resolution)
end

---changes the screen size based on the given width and height
---@param newWidth number
---@param newHeight number
function Window:resize(newWidth, newHeight)
    Window.set(self.title, Point.new(newWidth, newHeight), self.resolution, self.flags)
end

function Window.draw(layer, spriteName, position, rotation)
    local sprite = Sprite.getSprite(spriteName)

    local function drawCall() love.graphics.draw(sprite, position.x, position.y, rotation, 10, 10) end

    Window.drawLayers[layer]:addItem(drawCall, "draw: "..spriteName)
end

return Window