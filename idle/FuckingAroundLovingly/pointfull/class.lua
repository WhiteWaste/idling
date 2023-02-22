Class = {}
Class.__index = Class
Class.type = "Bedrock"

function Class.new(...)
    print("The bedrock welcomes the attempt to instanciate from it")
end

function Class:returnType()
    print(self.type)
end

function Class:derive(newClassType)
    local newClass = {}
    
    newClass.type = newClassType
    newClass.__call = Class.__call
    newClass.__index = newClass
    newClass.base = self
    setmetatable(newClass, self)

    return newClass
end

function Class:__call(...)
    local classInstance = setmetatable({}, self)
    
    classInstance:new(...)
    
    return classInstance
end

return Class