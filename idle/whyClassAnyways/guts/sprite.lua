local Sprite = {}
Sprite.__index = Sprite

Sprite.sprites = List.new('sprites')

local function splitSource(source)
    local stringArray = {}

    for word in string.gmatch(source, "([^/]+)") do
        table.insert(stringArray, word)
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
    local spriteName = string.sub(splitFilePath[#splitFilePath], 0, string.len(splitFilePath[#splitFilePath]) - 4)

    Sprite.sprites:addItem(sprite, spriteName)
    print(spriteName.."was added")
    return sprite
end

---loads all PNGs in assets as sprites
function Sprite.addFromAssets()
    local filesInAssets = FileSystem.gutDirectory("assets")

    local fullFileName = {}
    local spriteName = ""
    for spriteIndex, fullFilePath in ipairs(filesInAssets) do
        Sprite.newSprite(fullFilePath)
    end
end

---returns the sprite with the given name
---@param spriteName string
---@return love.Image
function Sprite.getSprite(spriteName)
    return Sprite.sprites:getItem(spriteName)
end

return Sprite