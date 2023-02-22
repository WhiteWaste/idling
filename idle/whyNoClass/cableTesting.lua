local function cloneValue(value)
    if type(value) ~= "table" then
        return value
    end

    local table = {}
    for i, element in pairs(value) do
        table[i] = cloneValue(element)
    end
    
    return table
end



