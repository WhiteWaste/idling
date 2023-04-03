---@meta

---@alias mouseButtons string the specific flow you want
---| '"RMB"'
---| '"LMB"'
---| '"MMB"'

---@class Point
---@field x number
---@field y number
---@field offset function

---@class List
---@field addItem function 
---@field addItems function 
---@field removeItem function 
---@field getItem function
---@field getItems function
---@field listItems function

---@class Color
---@field r number
---@field g number
---@field b number
---@field a number
---@field setBackgroundColor function 
---@field setColor function

---@class TextStyle
---@field fontName string
---@field fontColor Color

