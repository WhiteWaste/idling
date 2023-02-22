local cable = {}

cable.cableName = 'Cable'
cable.parent = 'none'

cable.cableBhv = {}

function cable.cableBhv:new()
    print("shouldn't be instancing from cable mate")
end

local function cloneTable(table, instancing)
    if type(table) ~= "table" then
        return table
    end

    local clone = {}
    for key, value in pairs(table) do
        if type(value) == "table" then
            value = cloneTable(value)
        end

        clone[key] = value
    end

    return clone
end

function cable.cableBhv:derive(newType)
    local newCable = cloneTable(self, false)

    newCable.cableName = newType
    newCable.parent = self.cableName

    return newCable
end

function cable.cableBhv:instantiate(...)
    local c = {}

    c = cloneTable(self, true)

    c.parent = self.cableName
    c.cableName = "Instance of "..self.cableName

    c:new(...)

    for key, value in pairs(c) do
        if key == 'cableBhv' then
            c[key] = nil
        end
    end

    return c
end

-- makes sure that 'splayOut' does it's job. It recieves a table and number of tabs 
local function splay(table, numOfTabs)
    local text = "" -- the returned string 
    local tabIndex, tabs = 0, ""

    for key, element in pairs(table) do
        while tabIndex < numOfTabs do -- tabs get added based of numOfTabs
            tabs = tabs.." "
            tabIndex = tabIndex + 1
        end
        text = text.."\n"..tabs.."["..key.."] " -- each row hold the key of the element in []

        local elementType = type(element)
        if elementType == 'table' then -- if the element is a table itself the function gets called recurcively with the number of tabs increased 
            text = text..splay(element, numOfTabs + 1)
        elseif elementType == 'function' then
            text = text.."<"..elementType..">"
        else
            text = text.."<"..elementType.."> "..element -- if it's anything else the <type> and value get added after the key
        end
    end

    return text
end

function cable:splayOut()
    return splay(self, 0)
end
--[[
local testTable = { asd = 3, fr = { 3, 4 ,5 } }
testTable = cable:derive("test")

local testInstanceOfTable = testTable:instantiate()

print(testTable:splayOut().."\n"..testInstanceOfTable:splayOut())
]]
return cable