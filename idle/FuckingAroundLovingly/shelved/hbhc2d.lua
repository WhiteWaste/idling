-- Entity
--[[

Entity = {}
Entity.__index = Entity
Entities = {}

function Entity.new(name, position, visage, onDraw, onFrame)
    local entity = setmetatable({}, Entity)
    
    entity.name = name
    entity.position = position or Point.Center
    
    entity.form = visage or nil
    if(entity.form ~= nil) then
        entity.form.pos = entity.position
    end

    entity.onDraw = onDraw or function () end
    entity.onFrame = onFrame or function () end

    table.insert(Entities, entity)
    return entity
end

function Entity:YellIntoTheVoid()
    print("Am called: "..self.name..". Am at ["..self.x..","..self.y.."]")
end

function Entity:Manifest()
    self.onDraw()
    
    if(self.form == nil) then return end

    self.form:DrawTheThing()
end 

function Entity:OnFrame()
    self.onFrame()
end

-- Visuals - rectangle

Visage = {}
Visage.__index = Visage

function Visage.new(lines, rotation)
    local v = setmetatable({}, Visage)
    
    v.r = rotation or 0
    v.ls = {}
    
    v.mX = 0
    v.mY = 0
    
    for lineIndex = 1, #lines do
        local l = {}
        
        l.w = lines[lineIndex][1]
        l.c = lines[lineIndex][2]

        l.ps = {}
        for pointIndex = 1, #lines[lineIndex] - 2 do
            l.ps[pointIndex] = lines[lineIndex][pointIndex + 2]

            if l.ps[pointIndex].x > v.mX then
                l.mX = l.ps[pointIndex].x 
            end
            if l.ps[pointIndex].y > v.mY then
                l.mY = l.ps[pointIndex].y 
            end
        end

        v.ls[lineIndex] = l
    end
    
    return v
end
function Visage:DrawTheThing()
    love.graphics.translate(self.pos.x, self.pos.y)
    love.graphics.rotate(self.r)
    
    print(self.mX)
    local ls = self.ls
    for line = 1, #ls do
        love.graphics.setLineWidth(ls[line].w)
        love.graphics.setColor(ls[line].c.r, ls[line].c.g, ls[line].c.b)
        
        for pointIndex = 1, #ls[line].ps - 1 do
            local ps = ls[line].ps
            love.graphics.line(
                ps[pointIndex].x - (self.ls[line].mX / 2),
                ps[pointIndex].y - (self.ls[line].mY / 2),
                ps[pointIndex + 1].x - (self.ls[line].mX / 2),
                ps[pointIndex + 1].y - (self.ls[line].mY / 2))
        end
    end
    
    love.graphics.origin()
end

Line = {}
Line.__index = Line
setmetatable(Line, Visage)

function Line.new(point1, point2, width, color)
    local l = setmetatable({}, Line)

    l.w = width or 3
    l.c = color or Color.White
    
    l.p1 = point1
    l.p2 = point2

    return l
end

function Line.new(x1, y1, x2, y2, width, color)
    --Line.new(Point.new(x1, y1), Point.new(x2, y2), width, color)
    local l = setmetatable({}, Line)

    l.w = width or 3
    l.c = color or Color.White

    l.p1 = Point.new(x1, y1)
    l.p2 = Point.new(x2, y2)

    return l
end

function Line:DrawTheThing()
    love.graphics.setColor(self.c.r, self.c.g, self.c.b)
    love.graphics.setLineWidth(self.w)  
    love.graphics.line(self.p1.x, self.p1.y, self.p2.x, self.p2.y)
end


-- Point

Point = {}
Point.__index = Point

function Point.new(x, y)
    local p = setmetatable({}, Point)

    p.x = x
    p.y = y

    return p
end

Point.Center = Point.new(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

-- Color

Color = {}
Color.__index = Color

function Color.new(r, g, b)
    local c = setmetatable({}, Color)

    c.r = r / 255
    c.g = g / 255
    c.b = b / 255

    return c
end

-- Color+

Color.Red = Color.new(255, 0, 0)
Color.DarkRed = Color.new(127, 0, 0)

Color.Green = Color.new(0, 255, 0)
Color.DarkGreen = Color.new(0, 127, 0)

Color.Blue = Color.new(0, 0, 255)
Color.DarkBlue = Color.new(0, 0, 127)

Color.Yellow = Color.new(255, 255, 0)
Color.DarkYellow = Color.new(127, 127, 0)

Color.Pink = Color.new(255, 0, 255)
Color.DarkPink = Color.new(127, 0, 127)

Color.Cyan = Color.new(0, 255, 255)
Color.DarkCyan = Color.new(0, 127, 127)

Color.White = Color.new(255, 255, 255)
Color.Black = Color.new(0, 0, 0)]]
