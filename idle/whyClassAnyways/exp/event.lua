local Event = {}

Event.events = List.new('Events')

---creates a new event type
---@param eventType string
function Event.create(eventType)
    Event.events:addItem({}, eventType)
end

---removes the given event type and all of it's callbacks
---@param eventType string
function Event:remove(eventType)
    Event.events:removeItem(eventType)
end

---takes a table of events and a callback function and returns either -1 if there are no duplicates or the index of the duplicate
---@param eventTable table table of events
---@param callback function
---@return integer -1 if there is no such callback, otherwise it returns the index of the given duplicate
local function findDuplicateCallbacks(eventTable, callback)
    for index, value in ipairs(eventTable) do
        if value == callback then
            return index
        end
    end

    return -1
end

---"hooks" a given callback to the given event type
---@param eventType string
---@param callback function
function Event.hook(eventType, callback)
    if findDuplicateCallbacks(Event.events[eventType], callback) ~= -1 then
        print('Callback already exists in the given event type')
        return
    end

    Event.events[eventType][#Event.events + 1] = callback
end

---removes the callback from the given event type
---@param eventType string
---@param callback function
function Event.unhook(eventType, callback)
    local cbIndex = findDuplicateCallbacks(Event.events[eventType], callback)
    if cbIndex == -1 then
        print('no such callbacks in the given table')
        return
    end

    table.remove(Event.events[eventType], cbIndex)
end

---invokes the given event
---@param eventType string
function Event.invoke(eventType, ...)
    for index, value in ipairs(Event.events[eventType]) do
        value()
    end
end

return Event