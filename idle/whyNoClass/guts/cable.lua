Cable = {} -- class + table = cable, get it? hehe
Cable.__index = Cable -- makes a table point toward itself. Not sure why, but it's mandatory for using the metatable function
Cable.cableType = "Table, but, like, better? Maybe."

-- creates new tables, similarly to classes
-- if a derived table doesn't have a function/variable in itself it will check the table it's derived from(It's metatable)
-- Cable should only have the foundations for further inheritance and maybe some functions for debuging

-- creates new "classes" that inherit from cable insuring that every new "class" can also have spawn
function Cable:derive(newTableType)
    local newTable = setmetatable({}, self) -- the new table 

    newTable.cableType = newTableType -- table type for debugging, do not overite it with some dumb shit in future classes
    newTable.baseCable = self -- the last table from which the newly made one inherits. Same goes for it as it does for type!
    newTable.__index = newTable -- makes sure that the new table can be a good metatable to it's children
    newTable.__call = self.__call -- pretty much a constructor for instances of the new table

    return newTable -- shoves the new table inside a variable
end

-- the closest thing to a constructor that lua has. It's called by using the name of the cable as a function
function Cable:__call(...) -- the "..." just mean that the function will take any number of arguments as a table
    local tableInstance = setmetatable({}, self) -- crates the instance 

    tableInstance.cableType = "Instance of "..self.cableType -- I know what I said about baseCable and cableType, but like, it's more readable during debuging this way

    ---@diagnostic disable-next-line: redundant-parameter
    tableInstance:new(...) -- executes any custom code/sets variables. Gives :new() the (...) table as arguments 

    return tableInstance
end

-- in normal languages this would be replaced with putting arguments/custom code inside a constructor
function Cable:new()
    self.msg = "Please don't derive from Cable" -- any new variables should be put inside this way
    print(self.msg) -- if you see this message, you don't have any custom constructors through the inheritance chain
end

-- simply for debugging, here's hoping it'll be underused
function Cable:reportStatus()
    print("I ["..self.cableType.."] exist and derive from ["..self.baseCable.cableType.."]") -- simply gives it's type and the cable it derives from and if it's an instance
end

--[[

--in case of forgor use and comments no help:

local test = Cable:derive("test")

local tester = test:derive("tester")
local instanceOfTester = tester()

local testiest = tester:derive("testiest")

test:reportStatus()
tester:reportStatus()
instanceOfTester:reportStatus()
testiest:reportStatus()

]]


return Cable