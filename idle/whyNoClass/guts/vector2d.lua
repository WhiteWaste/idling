local Cable = require "guts.cable"
local Vector2d = Cable:derive("Vector2d")

-- static value - holds the resolution as a vector
Vector2d.screenSize = {}
-- static value - holds the screen size as a vector
Vector2d.resolution = {}

-- just a collection of 2 values serving as x and y coordinates
function Vector2d:new(x, y)
    self.x = x or 0
    self.y = y or 0
end

-- this should only be called inside the constructor of the game window
function Vector2d:getScreenStats(screenSize, resolution)
    Vector2d.screenSize = screenSize
    Vector2d.resolution = resolution
end

-- returns a vector at the center of the scren
function Vector2d:center()
    return Vector2d(Vector2d.resolution.x / 2, Vector2d.resolution.y / 2)
end

function Vector2d:returnCords()
    return self.x and self.y
end

-- function to increase the individual values in a more readable fashion
-- decreases the Y value
function Vector2d:up(value)
    self.y = self.y - value
end

-- increases the Y value
function Vector2d:down(value)
    self.y = self.y + value
end

-- decreases the X value
function Vector2d:left(value)
    self.x = self.x - value
end

-- increases the X value
function Vector2d:right(value)
    self.x = self.x + value
end

-- just returns tha magnitude of the vector, potentialy never used
function Vector2d:magnitude()
    return (self.x * self.x + self.y * self.y)
end

return Vector2d