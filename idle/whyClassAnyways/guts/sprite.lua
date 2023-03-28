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
    print(string.sub(splitFilePath[#splitFilePath], 0, string.len(splitFilePath[#splitFilePath]) - 4))
    return sprite
end

local assetFilePath = "assets/"
---takes a table of asset names and loads them from the assets folder
---@param tableOfassetNames table
function Sprite.addFromAssets(tableOfassetNames)

    local pathToImg = ""
    for index, value in ipairs(tableOfassetNames) do
        pathToImg = assetFilePath..value..".png"
        Sprite.newSprite(pathToImg)
    end
end

return Sprite