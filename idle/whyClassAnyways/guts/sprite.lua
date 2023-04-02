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

---returns a sprite and add it the sprites list
---@param filePath string
---@return love.Image
function Sprite.newSprite(filePath)
    local sprite = love.graphics.newImage(filePath)
    local splitFilePath = splitSource(filePath)
    
    -- the last element is the name of the file with the file extention. The string.sub clears the file extention 
    Sprite.sprites:addItem(sprite, string.sub(splitFilePath[#splitFilePath], 0, string.len(splitFilePath[#splitFilePath]) - 4))
    
    return sprite
end

local assetFilePath = "assets/"
---loads them from the assets folder
function Sprite.addFromAssets()
    
    --[[local spritesInAssets = love.filesystem.getDirectoryItems("assets")

    local sprite
    local spriteName
    for fileIndex, fullFileName in ipairs(spritesInAssets) do
        spriteName = string.sub(fullFileName, 1, #fullFileName - 4)
        sprite = love.graphics.newImage(assetFilePath..fullFileName)
        Sprite.sprites:addItem(sprite, spriteName)
    end]]
end

---returns the sprite with the given name
---@param spriteName string
---@return love.Image
function Sprite.getSprite(spriteName)
    return Sprite.sprites:getItem(spriteName)
end

return Sprite