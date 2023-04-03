local FileSystem = {}

---returns the data of the given file as string
---@param filePath string
---@return string
function FileSystem.readFile(filePath)
    local openedFile = love.filesystem.newFile(filePath)
    local fileContent = openedFile:read()

    openedFile:close()
    return fileContent
end

---adds the given string to the text file at the given file path
---@param filePath string
---@param additionalContent string
function FileSystem.addToTextFile(filePath, additionalContent)
    local openedFile = love.filesystem.newFile(filePath, "w")
    openedFile:write(additionalContent)
    openedFile:close()
end

function FileSystem.gutDirectory(dirPath)
    local fileNamesTable = love.filesystem.getDirectoryItems(dirPath)
    local filePathsTable = {}

    for fileIndex, fullFileName in ipairs(fileNamesTable) do
        local filePath = dirPath.."/"..fullFileName
        local fileInfo = love.filesystem.getInfo(filePath)

        if fileInfo.type == "file" then
            table.insert(filePathsTable, filePath)
        else
            local localFolder = FileSystem.gutDirectory(filePath)

            for index, value in ipairs(localFolder) do
                table.insert(filePathsTable, value)
            end
        end
    end

    return filePathsTable
end

return FileSystem