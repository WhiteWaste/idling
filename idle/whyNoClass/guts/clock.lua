Cable = require "guts.cable"
Clock = Cable:derive("Clock")

Clock.schedule = {}

-- the clock runs as long as it has logged tasks
function Clock:run()
    for i, task in ipairs(Clock.schedule) do
        if task.time < love.timer.getTime() then 
            task:func() -- when the time of the task exeeds the timer's it's function gets executed
            table.remove(Clock.schedule, i) -- once executed the task gets removed 
        end 
    end
end

function Clock:addTask(timeInSeconds, func)
    local task = {} -- a task takes a time period and a function 

    task.time = timeInSeconds
    task.func = func

    table.insert(Clock.schedule, task) -- once loaded up the task gets loaded into the clock scheudle
end

return Clock