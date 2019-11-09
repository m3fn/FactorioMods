--[[
--------------------------------------------------------------------------------
-- Extremely Useful Composite Combinators
--------------------------------------------------------------------------------
-- misc.lua 

]]--

function addTickTask(taskName, task)
	local incr = not global.state.tickTasks
	global.state.tickTasks[taskName] = task
	if incr then
		global.state.tasksCount = global.state.tasksCount + 1
	end
	global.hasTasks = true
end

function removeTickTask(taskName)
	local decr = not not global.state.tickTasks[taskName]
	global.state.tickTasks[taskName] = nil
	if decr then
		global.state.tasksCount = global.state.tasksCount - 1
	end
	global.hasTasks = global.tasksCount == 0
end

function callCore(...)
	return remote.call("Composite-Combinators-Core", ...)
end

function callBase(...)
	return remote.call("Composite-Combinators-Base", ...)
end