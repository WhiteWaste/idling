---@meta

---@alias channels string the specific flow you want
---| '"onLoad"'
---| '"onUpdate"'
---| '"onDraw"'
---| '"onResize"'
---| '"onRMB"'
---| '"onLMB"'
---| '"onMMB"'

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

---@class Bone 
---@field root Point
---@field size Point
---@field angle number
---@field color Color
---@field pointAt function 
---@field draw function
---@field getEndPoint function 
---@field getMiddlePoint function

---@class Shape2D
---@field name string
---@field points table
---@field transform Transform
---@field color Color
---@field pointAt function 
---@field draw function
---@field getEndPoint function 
---@field getMiddlePoint function

---@class Transform
---@field position Point
---@field rotation number
---@field lineWidth number

---@class Text 
---@field text string
---@field position Point
---@field color Color
---@field style Style
---@field draw function

---@class Style
---@field fontSize number
---@field font love.Font
---@field textWidth number
---@field textHeight number

---@class Button
---@field text Text
---@field position Point
---@field size Point
---@field colors Colors
---@field currentColor Color
---@field onClick function
---@field draw function
---@field updateState function

---@class Colors
---@field color Color
---@field textColor Color
---@field hoverColor Color
---@field hoverTextColor Color

---@class Spine
---@field root Point
---@field verts table
---@field draw function


