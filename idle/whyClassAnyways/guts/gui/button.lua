local Button = {}
Button.__index = Button

---creates a button
---@param text Text a text object 
---@param position Point 
---@param size? Point x = width, y = height
---@param colors? Colors a table of 4 colors, 2 standart, 2 for hovering
---@param onClick function the function that get's called after a click
---@return Button
function Button:new(text, position, size, colors, onClick, buttonName)
    local b = setmetatable({}, Button)

    b.text = text
    b.text.position = position:offset(b.text.style.textWidth / 2, b.text.style.textHeight / 2)

    b.size = size or Point:new(70, 20)
    b.position = position:offset(b.size.x / 2, b.size.y / 2)

    b.colors = colors or { color = Color.gray, textColor = Color.white, hoverColor = Color.white, hoverTextColor = Color.black }
    b.currentColor = b.colors.color
    b.text.color = b.colors.textColor

    b.onClick = function () if b:isHovered() then onClick() end end
    b.name = buttonName

    return b
end

---draws the button
function Button:draw()
    self.currentColor:setColor()
    love.graphics.rectangle('fill', self.position.x, self.position.y, self.size.x, self.size.y)
    self.text:draw()
end

--[[checks if the cursor is over the button returns true if that is the case
---@return boolean
function Button:isHovered()
    local cp = Cursor:getPosition()
    return cp.x > self.position.x and cp.x < self.position.x + self.size.x and cp.y > self.position.y and cp.y < self.position.y + self.size.y
end
]]
---if put in the onUpdate list will change the state of the button when the cursor is over it
function Button:updateState()
    if self:isHovered() then
        self.currentColor = self.colors.hoverColor
        self.text.color = self.colors.hoverTextColor
    else
        self.currentColor = self.colors.color
        self.text.color = self.colors.textColor
    end
end

return Button