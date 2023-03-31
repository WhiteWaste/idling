local List = {}
List.__index = List

List.name = ""
List.itmes = {}
List.itemCount = 1

---makes a list with the given name
---@param listName string
---@return List
function List.new(listName)
    local l = setmetatable({}, List)

    l.name = listName -- holds the name of the list
    l.items = {} -- holds the items of the list
    l.itemCount = 1 -- holds the number of items in the list

    return l
end

---takes a variable and a key and shoves the list
---@param variable any the variable that is added
---@param key any string or number pointing toward the inserted variable
function List:addItem(variable, key)
    key = key or #self.items + 1

    if self.items[key] ~= nil then
        print("["..self.name.."] already has an item at the given key")
        return
    end

    self.items[key] = variable
    self.itemCount = self.itemCount + 1
end

---takes a table of variables and add them to the list with the same key they had in the given table, does not deepcopy tables. 
---@param tableOfVariables table
function List:addItems(tableOfVariables)
    for key, value in pairs(tableOfVariables) do
        self.items[key] = value
        self.itemCount = self.itemCount + 1
    end
end

---removes the item at the given key
---@param key string
function List:removeItem(key)
    if self.items[key] == nil then
        print("["..self.name.."] has no such element")
        return
    end

    self.items[key] = nil
    self.itemCount = self.itemCount - 1
end

---returns the item at the given key
---@param key string
function List:getItem(key)
    return self.items[key]
end

---returns all items of the list
---@return table
function List:getItems()
    return self.items
end

---lists all items by their keys in the console 
function List:listItems()
    local valType
    local txt = ""

    for key, item in pairs(self.items) do
        valType = type(item)
        txt = txt.."\n["..key.."] "

        if valType ~= "string" or valType ~= "number" then
            txt = txt..valType
        else
            txt = txt..item
        end
    end

    print(txt)
end

return List