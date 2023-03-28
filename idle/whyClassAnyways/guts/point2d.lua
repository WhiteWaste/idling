local Point = {}
Point.__index = Point

Point.x = 0
Point.y = 0

---creates a new point
---@param x number
---@param y number
---@return Point
function Point.new(x, y)
    local p = setmetatable({}, Point)

    p.x = x or 0
    p.y = y or 0

    return p
end

---takes the screen size and resolution as points
---@param screen Point
---@param resolution Point
function Point.getScreenSpecs(screen, resolution)
    Point.screenSize = screen
    Point.resolution = resolution
end

---returns a point at the center of the screen based on the resolution
---@return Point
function Point.center()
    return Point.new(Point.resolution.x / 2, Point.resolution.y / 2)
end

---returns a new point offset by the given x and y
---@param x number
---@param y number
---@return Point
function Point:offset(x, y)
    return Point.new(self.x - x, self.y - y)
end

return Point