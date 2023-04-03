local Graphics = {}
Graphics.__index = Graphics

Graphics.sprites = List.new('sprites')
Graphics.fonts = List.new('fonts')

---splits a string on every "/" really only needed here
local function splitSource(source)
    local stringArray = {}

    for word in string.gmatch(source, "([^/]+)") do
        table.insert(stringArray, word)
    end

    return stringArray
end

---returns the last element of the given path. Should be the full file name
local function getFileName(source)
    local splitSource = splitSource(source)
    return splitSource[#splitSource]
end

---returns a sprite and add it the sprites list
---@param filePath string
---@return love.Image
function Graphics.newSprite(filePath)
    local sprite = love.graphics.newImage(filePath)
    local splitFilePath = splitSource(filePath)
    -- the last element is the name of the file with the file extention. The string.sub clears the file extention 
    local spriteName = string.sub(splitFilePath[#splitFilePath], 0, string.len(splitFilePath[#splitFilePath]) - 4)

    Graphics.sprites:addItem(sprite, spriteName)
    print(spriteName.."was added")
    return sprite
end

---loads all PNGs in assets as sprites
function Graphics.addFromAssets()
    local filesInAssets = FileSystem.gutDirectory("assets")

    local fullFileName = {}
    local spriteName = ""
    for spriteIndex, fullFilePath in ipairs(filesInAssets) do
        Graphics.newSprite(fullFilePath)
    end
end

---returns the sprite with the given name
---@param spriteName string
---@return love.Image
function Graphics.getSprite(spriteName)
    return Graphics.sprites:getItem(spriteName)
end

---saves the given font in fonts either under the given name or by the name of the tff file
---@param fontPath string the path to the tff file
---@param fontName? string the key for the font in "fonts", if not given the key would be the name of the tff file
---@param fontSize? number the height of the letters
function Graphics.newFont(fontPath, fontName, fontSize)
    if fontName == nil then
        local fullFontName = getFileName(fontPath)
        fontName = string.sub(fullFontName, 1, #fullFontName - 4)
    end
    local font
    if fontSize == nil then
        font = love.graphics.newFont(fontPath)
    else
        font = love.graphics.newFont(fontPath, fontSize, "normal")
    end

    Graphics.fonts:addItem(font, fontName)
end

---sets the default font - used when no font is given in Text related functions
---@param fontPath string 
function Graphics.setDefaultFont(fontPath)
    Graphics.fonts:removeItem('default')
    Graphics.newFont(fontPath, 'default')
end

---gets called on load. Don not call manualy. 
function Graphics.setTheLoveBaseFontAsDefault()
    Graphics.fonts:addItem(love.graphics.getFont(), "default")
end

---returns a Text object with the given string. If no font is given the Text has the set font
---@param text string the contents of the Text
---@param fontName? string the name of the wanted font, that hopefully exists
function Graphics.newText(text, fontName)
    return love.graphics.newText(Graphics.fonts:getItem(fontName or "default"), text)
end

return Graphics