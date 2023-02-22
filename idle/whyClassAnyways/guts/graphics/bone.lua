local Bone = {}
Bone.__index = Bone

---creates a bone
---@param root? Point the "root" of the bone
---@param size? Point x = width, y = lenght
---@param angle? number 0-360
---@param color? Color the color of the bone
---@return Bone
function Bone:new(root, size, angle, color)
    local b = setmetatable({}, self)

    b.root = root or Point:center()
    b.size = size or Point:new(2, 30)
    b.angle = angle or 0
    b.color = color or "color"

    return b
end

---returns the tip of the bone as a Point
---@return Point
function Bone:getEndPoint()
    return Point:new(self.root.x + math.cos(self.angle) * self.size.y, self.root.y + math.sin(self.angle) * self.size.y)
end

---returns the center of the bone as a Point
---@return Point
function Bone:getMiddlePoint()
    local endPoint = self:getEndPoint()
    return Point:new((endPoint.x + self.root.x) * .5, (endPoint.y + self.root.y) * .5)
end

---takes a Point and makes the bone "point at" it
---@param target Point
function Bone:pointAt(target)
    local direction  = Point:new(target.x - self.root.x, target.y - self.root.y)

    self.angle = math.atan2(direction.y, direction.x)
end

---draws the bone
function Bone:draw()
    local ep = self:getEndPoint()
    love.graphics.line(self.root.x, self.root.y, ep.x, ep.y)
end

return Bone
