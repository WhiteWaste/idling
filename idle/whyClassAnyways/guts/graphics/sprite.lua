local Sprite = {}
Sprite.__index = Sprite

Sprite.sprites = List.new('sprites')

local function splitSource(source)
    local stringArray = {}
    
    for word in string.gmatch(source, "([^/]+)") do
        stringArray[#stringArray + 1] = word 
    end

    return stringArray
end

function Sprite.newSprite(filePath)
    local sprite = love.graphics.newImage(filePath)
    local spriteName = splitSource(filePath)
    Sprite.sprites:addItem(sprite, spriteName)
    
    return sprite
end

function Sprite.addFromAssets()
    
end

local strTest = "asd/ferds/ds"
local splitStrTest = splitSource(strTest)

for index, value in ipairs(splitStrTest) do
    print(value)
end

return Sprite