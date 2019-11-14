--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
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


function getStorageDataSlotsCopy(entity)
	local dataSlots = { }
	for _,signals in pairs(entity.get_control_behavior().parameters) do -- Good thing this works for ghosts
		for _,signal in pairs(signals) do
			if signal.signal.name then
				table.insert(dataSlots, signal)
			end
		end
	end
	return dataSlots
end