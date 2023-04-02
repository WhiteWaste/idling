local GameClock = {}

GameClock.deltaTime = 0

GameClock._ = {}
GameClock._.onUpdate = List.new("onUpdate")

---attaches a functions to the love.update function with the given name
---@param func function
---@param functionName string
function GameClock.attach(func, functionName)
    GameClock._.onUpdate:addItem(func, functionName)
end

---detaches the function from the love.update
---@param functionName string
function GameClock.detach(functionName)
    GameClock._.onUpdate:removeItem(functionName)
end

return GameClock