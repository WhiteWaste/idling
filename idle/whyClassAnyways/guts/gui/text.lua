local Text = {}
Text.__index = Text

---creates a text object
---@param text string the displayed text
---@param position? Point the position of the text
---@param color? Color color of the text
---@param style? Style the font and font size of the text
---@return Text
function Text:new(text, position, color, style)
    local txt = setmetatable({}, Text)

    txt.text = text or "text"

    txt.color = color or Color.white

    style = style or { fontSize = 10, font = Text.standartFont }
    txt.style = style
    txt.style.font = style.font or Text.standartFont
    txt.style.textWidth = txt.style.font:getWidth(txt.text)
    txt.style.textHeight = txt.style.font:getHeight()

    position = position or Point:center()
    txt.position = position:offset(txt.style.textWidth / 2, txt.style.textHeight / 2) 

    return txt
end

---draws the text
function Text:draw()
    love.graphics.setFont(self.style.font)
    self.color:setColor()
    love.graphics.print(self.text, self.position.x, self.position.y)
end

-- the stanrat font
Text.standartFont = love.graphics.newFont("fonts/PixelOperator8.ttf", 16, 'none')

-- resets the font size
function Text.resetFont()
    love.graphics.setFont(Text.standartFont)
end

--Text.fontTestSentance = "Sphinx of black quartz, judge my vow"


return Text