local Shape2D = {}
Shape2D.__index = Shape2D

---creates a shape
---@param name string name of the shape
---@param points table table of points
---@param transform? Transform the position, rotation and line width of the shape 
---@param color? Color the color of all the lines in the shape
---@param enclosed? boolean encloses the shape by setting the first point also as the last 
---@return Shape2D
function Shape2D:new(name, points, transform, color, enclosed)
    local s = setmetatable({}, Shape2D)

    s.name = name

    s.points = List:new('points of '..s.name)
    s.points:addItems(points)

    if enclosed == true or enclosed == nil then
        s.points:addItem(points[1])
    end

    transform = transform or { position = Point:center(), rotation = 0, lineWidth = 2 }
    s.transform = {}
    s.transform.position = transform.position or Point:center()
    s.transform.rotation = transform.rotation or 0
    s.transform.lineWidth = transform.lineWidth or 2

    s.color = color or Color.white

    return s
end

---draws the shape that calls it
function Shape2D:draw()
    self.color:setColor()
    love.graphics.setLineWidth(self.transform.lineWidth)

    local pointCords = {}
    local cordIndex = 1
    for key, point in pairs(self.points:getItems()) do
        pointCords[cordIndex] = self.transform.position.x + (point.x * math.cos(self.transform.rotation) - point.y * math.sin(self.transform.rotation))
        pointCords[cordIndex + 1] = self.transform.position.y + (point.y * math.cos(self.transform.rotation) + point.x * math.sin(self.transform.rotation))

        cordIndex = cordIndex + 2
    end

    love.graphics.line(pointCords)
    Color.white:setColor()
end

---returns a rectangle with the given stats
---@param name string name of rectangle
---@param size Point x = width, y = height
---@param transform Transform standart Shape2D transform
---@param color? Color color of shape
---@return Shape2D
function Shape2D:rectangle(name, size, transform, color)
    local width, height = size.x / 2, size.y / 2

    local rectPoints = {
        Point:new(-width, -height),
        Point:new(width, -height),
        Point:new(width, height),
        Point:new(-width, height)
    }

    return Shape2D:new(name, rectPoints, transform, color)
end

---returns a point at the given coordinates
---@param name string
---@param position Point
---@param color Color
---@return Shape2D
function Shape2D:point(name, position, color)
    return Shape2D:rectangle(name, Point:new(1, 1), {position = position, lineWidth = 1}, color)
end

return Shape2D