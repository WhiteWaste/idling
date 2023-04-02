local Tower = {}
Tower.__index = Tower

Tower.attack = 2
Tower.hp = 3
Tower.sprite = nil
Tower.positon = Point.new(0, 0)

function Tower.new(name, position, sprite)
    local t = setmetatable({}, Tower)

    t.attack = 5
    t.positon = position
    t.sprite = sprite

    return t
end

local function moveTower()
    Tower.positon:offset(1, 1)
    print(Tower.positon.x, Tower.positon.y)
end

Game.attach("onUpdate", moveTower, "moveTower")
Window.draw(1, "testSquare", Tower.positon, 0)

return Tower