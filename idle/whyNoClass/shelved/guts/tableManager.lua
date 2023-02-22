local tableManager = {} -- hopefully a better 'table' table 

-- creates a named table
function tableManager.createTable(name, prefab)
    local table = {} -- makes a generic table

    table.tableName = name -- the name of the table. Don't overrite it

    if prefab ~= nil then
        table = tableManager.cloneTable(prefab)
    end

    return table
end

-- takes a table and returns an exact copy of it, changes the name to 'Clone of [recieved table name]' if the recieved table has one 
function tableManager.cloneTable(table)
    if type(table) ~= "table" then -- if it doesn't recieve a table it returns the value
        return table
    end

    local clone = {} -- clone of the recieved table
    for i, element in pairs(table) do
        if i == 'tableName' then -- if the recieved table is named the clone gets named 'clone of [recieved table name]'
            element = 'Clone of '..element
        end

        -- the function gets called recurcively until the table runs out of element
        clone[i] = tableManager.cloneTable(element)
    end

    return clone
end

-- makes sure that 'gutTable' does it's job. It recieves a table and number of tabs 
local function gut(table, numOfTabs)
    local text = "asd" -- the returned string 
    local tabIndex, tabs = 0, ""

    for i, element in pairs(table) do
        while tabIndex < numOfTabs do -- tabs get added based of numOfTabs
            tabs = tabs.." "
            tabIndex = tabIndex + 1
        end
        text = text.."\n"..tabs.."["..i.."] " -- each row hold the key of the element in []

        local elementType = type(element)
        if elementType == 'table' then -- if the element is a table itself the function gets called recurcively with the number of tabs increased 
            text = text..gut(element, numOfTabs + 1)
        elseif elementType == 'function' then
            text = text.."<"..elementType..">"
        else
            text = text.."<"..elementType.."> "..element -- if it's anything else the <type> and value get added after the key
        end
    end

    return text
end

-- returns a heiarchical string of all elements of the table and it's inner tables
function tableManager.gutTable(victim)
    return gut(victim, 0) -- give the taken table/variable to 'gut()'
end

--[[
local tileTable = tableManager.createTable('tile')
local randTable = { asd = 3, ayeUp = { "aye", 3, 4, 5, "up" } }

tileTable.transform = {}
tileTable.transform.postition = {}
tileTable.transform.postition.x, tileTable.transform.postition.y = 3, 5
tileTable.transform.rotation = 0
function tileTable:asd()
    return 3
end

local tableClone = tableManager.cloneTable(tileTable)
--local tableClone = tableManager.cloneTable(randTable)

function tableClone:asd()
    return 5
end


print(tableManager.gutTable(randTable))
print(tableManager.gutTable(tileTable))
print(tableManager.gutTable(tableClone))
print(tableClone:asd()..","..tileTable:asd())
]]
return tableManager