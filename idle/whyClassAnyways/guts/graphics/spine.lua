local Spine = {}
Spine.__index = Spine
---comment
---@param name? string
---@param root? Point
---@param numberOfVertibrae? number
---@param virtibraeLenght table
---@param color? Color
---@return Spine
function Spine:new(name, root, numberOfVertibrae, virtibraeLenght, color)
    local s = setmetatable({}, Spine)

    s.name = name or "spine"
    s.root = root or Point:center()
    s.verts = {}

    local currentRoot, lenghtIndex = nil, 1
    for i = 1, numberOfVertibrae do
        if i == 1 then currentRoot = root
        else currentRoot = s.verts[i - 1]:getEndPoint()
        end

        s.verts[i] = Bone:new(currentRoot, virtibraeLenght[lenghtIndex], 0, color)

        if lenghtIndex == #virtibraeLenght then lenghtIndex = 1
        else lenghtIndex = lenghtIndex + 1
        end
    end

    return s
end

function Spine:draw()
    for index, value in ipairs(self.verts) do
        value:draw()
    end
end

local leg = Spine:new('spin', nil, 3, {30, 30, 10}, Color.red)
local function spinTest()
    leg:draw()
end

Game:attach('onDraw', spinTest, 'spinTest', 1)
return Spine