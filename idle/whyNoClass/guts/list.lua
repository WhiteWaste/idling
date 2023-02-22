local Cable = require "guts.cable"
local List = Cable:derive("List")

-- list for tables and nothing else

function List:new(listName)
    self.name = listName -- the lists have names for some reason

    self.items = {} -- storage for tables 
    self.itemCount = 0 -- pretty much the lenght of the list
end

-- adds a the given table to the list
function List:addItem(item)
    item.itemInList = {} -- each item gets a control table as "proof" of being part of a list
    item.itemInList.indexInList = self.itemCount -- the added tables gets an index
    item.itemInList.nameOfList = self.name -- also it can show the name of the list it's part of
    
    self.itemCount = self.itemCount + 1
    self.items[self.itemCount] = item -- the item gets added and the item count increased
end

-- adds a table o' tables to a list
function List:addItems(tableOfItems)
    for i = 1, #tableOfItems do
        self:addItem(tableOfItems[i]) -- the table better have only tables inside couse I can't be bothered to makea contingecy otherwise
    end
end

-- removes the item on the given index
function List:removeByIndex(index)
    table.remove(self.items, index)
    self.itemCount = self.itemCount - 1 -- number of items get lowered
    
    for i = 1, #self.items do -- the indexes of all other elements get rearranged 
        self.items[i].itemInList.indexInList = i
    end
end

-- removes the items it's given as an argument if it's part of the lsit
function List:remove(item)
    if item.itemInList.nameOfList ~= self.name then -- conformation that the item is even in the list to begin with
        print("["..self.name.."] There is no such item in this list.")
        return
    end

    self:removeByIndex(item.itemInList.indexInList)
end

-- returns the item on the given index
function List:getItemByIndex(itemIndex)
    return self.items[itemIndex] -- returns what the function name suggests
end

-- returns the entire list
function List:getItems()
    return self.items
end

--[[
local list = List(" ")
local t1 = {name = 1} list:add(t1)
local t2 = {name = 2} list:add(t2)
local t3 = {name = 3} list:add(t3)
local t4 = {name = 4} list:add(t4)
local t5 = {name = 5} list:add(t5)

list:remove(t4)
for i = 1, #list.items do
    local listItem = list:getItemByIndex(i)
    print("["..listItem.name.."]: "..listItem.itemInList.indexInList)
end
]]

return List