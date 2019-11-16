--[[
--------------------------------------------------------------------------------
-- Extremely Useful Composite Combinators mod
--------------------------------------------------------------------------------
-- euc.lua 
	Main
]]--

const = {
	managedEnts = {
		"euc-distinct-constant-combinator",
		"euc-simple-delay-combinator",
		"euc-inclusive-filter-combinator",
	},
	distinctConstantCombinator = {
		defaultBuildString = "2#$item#composite-combinator-io-marker#constant-combinator#$1#3#2#0#0#2#1*%1#2#1#0#0#0#1%1#3#2#0#1#2#1*%$01#1#2#1#1#%00#2#3#1#1#%"
	},
	simpleDelayCombinator = {
		buildStrings = {
			-- 1 tick
			"2#$item#composite-combinator-io-marker#arithmetic-combinator#$1#2#1#0#0#0#1%1#3#45#5.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#2#1#0#0#0#2%$01#1#2#1#1#%00#1#3#1#1#%01#2#4#2#1#%00#3#4#2#1#%",
			-- 2 ticks
			"2#$item#composite-combinator-io-marker#arithmetic-combinator#$1#2#1#0#0#0#1%1#3#45#4.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#4.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#6.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#6.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#2#1#0#0#0#2%$01#1#3#1#1#%00#1#2#1#1#%00#2#4#2#1#%01#3#5#2#1#%00#4#6#2#1#%01#5#6#2#1#%",
			-- 3 ticks
			"2#$item#composite-combinator-io-marker#arithmetic-combinator#$1#2#1#0#0#0#1%1#3#45#3.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#3.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#2#1#0#0#0#2%$01#1#5#1#1#%00#1#2#1#1#%00#2#3#2#1#%00#3#4#2#1#%00#4#8#2#1#%01#5#6#2#1#%01#6#7#2#1#%01#7#8#2#1#%",
			-- 5 ticks
			"2#$item#composite-combinator-io-marker#arithmetic-combinator#$1#2#1#0#0#0#1%1#3#45#3.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#2.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#2.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#8.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#8.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#3.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#2#1#0#0#0#2%$01#1#5#1#1#%00#1#6#1#1#%00#2#6#1#2#%00#2#3#2#1#%00#3#4#2#1#%00#4#8#2#1#%01#5#9#2#1#%01#7#11#1#2#%01#7#12#2#1#%00#8#12#2#1#%01#9#10#2#1#%01#10#11#2#1#%",
			-- 7 ticks
			"2#$item#composite-combinator-io-marker#arithmetic-combinator#$1#2#1#0#0#0#1%1#3#45#3.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#0#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#2.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#2.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#4.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#4.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#6.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#6.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#8.5#2#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#8.5#1#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#3.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#5.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#3#45#7.5#3#2#virtual!signal-each!^!1!virtual!signal-each!1%1#2#1#0#0#0#2%$01#1#5#1#1#%00#1#6#1#1#%00#2#6#1#2#%00#2#8#2#1#%00#3#8#1#2#%00#3#10#2#1#%00#4#10#1#2#%00#4#12#2#1#%01#5#13#2#1#%01#7#13#1#2#%01#7#14#2#1#%01#9#14#1#2#%01#9#15#2#1#%01#11#15#1#2#%01#11#16#2#1#%00#12#16#2#1#%",
		},
		defaultDelayId = 3,
		thresholds = {
			1, 2, 3, 5, 7
		},
		thresholdIds = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[5] = 4,
			[7] = 5
		},
		thresholdIdToSign = { -- use vanilla arithmetic combinator signs to display current delay
			'+', '-', '*', '/', '%'
		}
	},
	filterCombinator = {
		emptyString = "2#$item#composite-combinator-io-marker#$1#2#1#0#0#0#1%1#2#1#0#0#0#2%$",
		maxItems = 8,
		emptyDisplaySign = '^'
	},
	strBuilderName = "euc"
}

function OnInit()
	global.state = {
		tickTasks = { },
		tasksCount = 0,
		players = { },
		constantCombinators = { },
		delayCombinators = { },
		filterCombinators = { },
		
		nextGuiCloseHandlers = { }
	}
	
	global.hasTasks = false
	
	RegisterEntities()
	EnsurePlayerStates()
	
	-- remote.call("Composite-Combinators-Core", "registerCompositeCombinatorPrototype", "euc-demo", 2, { x = 0, y = 0 }, "ExtremelyUsefulCombinators", "demoEntity_")
end

function CreatePlayerDesc()
	return {
		centralUIElement = nil
	}
end

function OnConfigChanged(data)
	EnsurePlayerStates() -- TODO REMOVE?
end

-- callbacks from core
remote.add_interface("ExtremelyUsefulCombinators", {

	-- Distinct constant combinator
	dcc_GetBuildString = function(entity)
		if entity == nil then
			return nil
		end
		return const.distinctConstantCombinator.defaultBuildString
	end,
	
	dcc_SaveStateInfoToSlots = function(entity) 
		return { }
	end,
	
	dcc_RestoreStateInfoFromSlots = function(entity, slots, nextSlot)
	end,
	
	-- Simple delay combinator
	sdc_GetBuildString = function(entity)
		if entity == nil then
			return nil
		end
		local entityId = entity.unit_number
		local delayId
		if global.state.delayCombinators[entityId] then
			-- GetBuildString is called when changing delay
			delayId = global.state.delayCombinators[entityId].currentDelayId
		else
			-- Although it is set on on_built_entity in OnCombinatorBuilt function, on_built_entity order is not defined
			-- This is for the case when core mod on_built_entity is called second
			delayId = const.simpleDelayCombinator.defaultDelayId
		end
		SetDelayCombinatorDisplay(entity, delayId)
		return const.simpleDelayCombinator.buildStrings[delayId]
	end,
	
	sdc_SaveStateInfoToSlots = function(entity) 
		if entity == nil then
			return nil
		end
		local slots = { }
		local entityId = entity.unit_number
		local combinatorState = global.state.delayCombinators[entityId]
		-- add some information so we can identify combinator settings when it is built from blueprint
		if combinatorState then
			slots[1] = { signal = { type = 'item', name = 'wood' }, count = combinatorState.currentDelayId, index = 1 }
		end
		return slots
	end,
	
	sdc_RestoreStateInfoFromSlots = function(entity, slots, nextSlot)
		if entity == nil then
			return nil
		end
		local entityId = entity.unit_number
		local combinatorState = global.state.delayCombinators[entityId]
		if combinatorState then
			combinatorState.currentDelayId = slots[nextSlot].count
		else
			-- We reached this place before OnCombinatorBuilt
			-- meh, it is always like this -- TODO
			global.state.delayCombinators[entityId] = { currentDelayId = slots[nextSlot].count }
		end
	end,
	
	-- Inclusive filter combinator
	ifc_GetBuildString = function(entity)
		if entity == nil then
			return nil
		end
		local entityId = entity.unit_number
		if global.state.filterCombinators[entityId] then
		end
		if global.state.filterCombinators[entityId] and global.state.filterCombinators[entityId].currentStr then
			return global.state.filterCombinators[entityId].currentStr
		else
			return const.filterCombinator.emptyString
		end
	end,
	
	ifc_SaveStateInfoToSlots = function(entity) 
		if entity == nil then
			return nil
		end
		local entityId = entity.unit_number
		local slots = { }
		local combinatorState = global.state.filterCombinators[entityId]
		if combinatorState then
			local sigCount = 0
			for _,sig in pairs(combinatorState.filterSignals) do
				sigCount = sigCount + 1
			end
			table.insert(slots, { signal = { type = 'virtual', name = combinatorState.mixWires and 'signal-A' or 'signal-B' }, count = sigCount })
			for numId,sig in pairs(combinatorState.filterSignals) do
				table.insert(slots, { signal = sig, count = numId })
			end
		end
		return slots
	end,
	
	ifc_RestoreStateInfoFromSlots = function(entity, slots, nextSlot)
		if entity == nil then
			return nil
		end
		local entityId = entity.unit_number
		local combinatorState = global.state.filterCombinators[entityId]
		if combinatorState then
		else
			combinatorState = { }
			global.state.filterCombinators[entityId] = combinatorState
		end
		combinatorState.mixWires = slots[nextSlot].signal.name == 'signal-A'
		combinatorState.filterSignals = { }
		local sigCount = slots[nextSlot].count 
		nextSlot = nextSlot + 1
		local numId = 1
		while numId <= sigCount do
			combinatorState.filterSignals[slots[nextSlot].count] = slots[nextSlot].signal
			numId = numId + 1
			nextSlot = nextSlot + 1
		end
	end,
	
  --[[
  demoEntity_GetBuildString = function(entity)
    if entity == nil then
      return nil
    end
    return "%#!^XYZ*$"
  end,

  demoEntity_SaveStateInfoToSlots = function(entity) 
    if entity == nil then
      return nil
    end
    return { }
  end,
  
  demoEntity_RestoreStateInfoFromSlots = function(entity, slots, nextSlot)
    if entity == nil then
      return
    end
  end
  ]]--
})

local function RegisterEntity(name, prefix, offs, cpos)
	remote.call(
		"Composite-Combinators-Core", "registerCompositeCombinatorPrototype", 
		name, offs, cpos,
		"ExtremelyUsefulCombinators", prefix
	)
end

function RegisterEntities()
	-- Register our entities, other info is gained through callbacks
	RegisterEntity("euc-distinct-constant-combinator", 		"dcc_", 	2, { x = 0.5, y = 0.5 })
	RegisterEntity("euc-simple-delay-combinator", 			"sdc_",		6, { x = 0.66, y = 0.33 })
	RegisterEntity("euc-inclusive-filter-combinator",		"ifc_",		6, { x = 0.66, y = 0.33 })
end

function OnTick(e)
	if global.hasTasks == false then -- return as qucikly as we can
		return
	end
	
	for name, task in pairs(global.state.tickTasks) do
		if name == "MaintainUI" then
			local player = game.players[task.playerIndex]
			if player and player.connected and player.opened and player.opened_gui_type and player.opened_gui_type == defines.gui_type.entity then
				local openedEntityName = player.opened.name
				if openedEntityName == "euc-simple-delay-combinator" then
					ShowDelayCombinatorMenu(player.opened, task.playerIndex)
				end
				if openedEntityName == "euc-distinct-constant-combinator" then
					ShowDistinctConstantCombinatorMenu(player.opened, task.playerIndex)
				end
				if openedEntityName == "euc-inclusive-filter-combinator" then
					ShowFilterCombinatorMenu(player.opened, task.playerIndex)
				end
			else
				task.age = task.age + 1
				if task.age > 1 and not player.selected then
					removeTickTask("MaintainUI")
				end
			end
		end
	end
end

function SetCommonArithmeticCombinatorDisplay(entity, operation)
	-- use vanilla arithmetic combinator signs to display anything
	local params = entity.get_control_behavior().parameters
	params.parameters.operation = operation
	entity.get_control_behavior().parameters = params
end

function SetDelayCombinatorDisplay(entity, delayId)
	local operation = const.simpleDelayCombinator.thresholdIdToSign[delayId]
	SetCommonArithmeticCombinatorDisplay(entity, operation)
end

function UpdateFilterCombinator_CreateDeciderForWire(x, y, nextUnitId, sig)
	local deciderComponentParams = { -- vanilla decider combinator params
		parameters = {
			comparator = "≠",
			constant = 0,
			copy_count_from_input = false,
			first_signal = {
				name = sig.name,
				type = sig.type
			},
			output_signal = {
				name = sig.name,
				type = sig.type
			}
		}
	}
	
	-- damn this feels good; just build this component there, coorinates are as of uncompressed, archetype build
	componentStr = callBase("DeciderCombinatorBuildString", deciderComponentParams)
	
	callCore("strBuilderAddComponent", const.strBuilderName, "decider-combinator", { x = x, y = y }, defines.direction.east, componentStr, nextUnitId)
end

function UpdateFilterCombinator(entityId)
	local entityState = global.state.filterCombinators[entityId]
	local componentStr
	
	--- Build str
	callCore("strBuilderBegin", const.strBuilderName, "euc-inclusive-filter-combinator")
	
	local nextX = 1
	local nextUnitId = 1
	for _,sig in pairs(entityState.filterSignals) do
		-- Separate combinators for each wire type
		UpdateFilterCombinator_CreateDeciderForWire(nextX, 1, nextUnitId, sig)
		nextX = nextX + 1
		nextUnitId = nextUnitId + 1
		if not entityState.mixWires then
			UpdateFilterCombinator_CreateDeciderForWire(nextX, 2, nextUnitId, sig)
			nextX = nextX + 1
			nextUnitId = nextUnitId + 1
		end
	end
	
	if nextUnitId == 1 then -- no signals
		callCore("strBuilderClose", const.strBuilderName)
		entityState.currentStr = const.filterCombinator.emptyString
		callCore("changeLayout", entityId)
		return
	end
	
	nextUnitId = 1
	-- Connect wires
	for _,sig in pairs(entityState.filterSignals) do
		-- connect zero entity each decider component, corresponding inputs and outputs
		-- zero is composite combinator
		callCore("strBuilderAddConnection", const.strBuilderName, 0, nextUnitId, 1, 1, defines.wire_type.red)
		callCore("strBuilderAddConnection", const.strBuilderName, 0, nextUnitId, 2, 2, defines.wire_type.red)
		if not entityState.mixWires then
			nextUnitId = nextUnitId + 1
		end
		callCore("strBuilderAddConnection", const.strBuilderName, 0, nextUnitId, 1, 1, defines.wire_type.green)
		callCore("strBuilderAddConnection", const.strBuilderName, 0, nextUnitId, 2, 2, defines.wire_type.green)		
		nextUnitId = nextUnitId + 1
	end
	
	--- Save str
	
	local str = callCore("strBuilderCompileAndClose", const.strBuilderName)
	entityState.currentStr = str
	
	--- Apply str

	callCore("changeLayout", entityId)
end

--- #region Mostly just UI

function DistinctConstantCombinatorClick_ForWire(combinator, player, wireId)
	local playerIndex = player.index
	local combinatorId = combinator.unit_number
	CloseMenus(playerIndex)
	local constantCombinatorId = callCore( "getComponentEntityId", combinatorId, wireId)
	-- TODO: find better way
	local pf = player.surface.find_entities_filtered({ -- pfffts, why can't we get ent by id
		position = player.position,
		radius = 1024, -- TODO: smth better, also surface can be different
		name = callCore( "getComponentPrototype", "constant-combinator").componentEntityName
	})
	for _,entity in pairs(pf) do
		if entity.unit_number == constantCombinatorId then
			player.opened = entity
			table.insert(
				global.state.nextGuiCloseHandlers, 
				function(e) 
					callCore( "refreshDataStorageSlots", combinatorId)
				end
			)
			return
		end
	end
end

function OnEucGuiClick(e)
	local playerIndex = e.player_index
	local player = game.get_player(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	
	local elementName = e.element.name
	local entity = playerDesc.centralUIElement.selectedEntity
	local entityId = entity.unit_number
	
	if playerDesc.centralUIElement.name == "DelayCombinator" then
		local tnum = 1
		for num in ipairs(const.simpleDelayCombinator.thresholds) do -- I hate lua too much to do this in a civil way
			if elementName == "button_setdelay_"..tnum then 
				global.state.delayCombinators[entityId].currentDelayId = tnum
				callCore("changeLayout", entityId)
				CloseMenus(playerIndex)
				return
			end
			tnum = tnum + 1
		end
	end
	if playerDesc.centralUIElement.name == "DistinctConstantCombinator" then	
		-- Show inner constant combinators on click
		if elementName == "button_pickwire_red" then 
			DistinctConstantCombinatorClick_ForWire(entity, player, 1)
			return
		end
		if elementName == "button_pickwire_green" then 
			DistinctConstantCombinatorClick_ForWire(entity, player, 2)
			return
		end
	end
	if playerDesc.centralUIElement.name == "InclusiveFilterCombinator" then
	end
end

function OnEucCheckedStateChanged(e)
	local playerIndex = e.player_index
	local player = game.get_player(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	
	local elementName = e.element.name
	local entity = playerDesc.centralUIElement.selectedEntity
	local entityId = entity.unit_number
	
	if playerDesc.centralUIElement.name == "InclusiveFilterCombinator" then	
		if elementName == "checkbox_mixwires" then
			global.state.filterCombinators[entityId].mixWires = e.element.state
		end
		UpdateFilterCombinator(entityId)
	end
end

function OnEucGuiElemChanged(e)
	local playerIndex = e.player_index
	local player = game.get_player(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	
	local elementName = e.element.name
	local entity = playerDesc.centralUIElement.selectedEntity
	local entityId = entity.unit_number
	
	if playerDesc.centralUIElement.name == "InclusiveFilterCombinator" then	
		local numId = 1
		while numId <= const.filterCombinator.maxItems do
			if elementName == "button_setfilter_"..numId then
				global.state.filterCombinators[entityId].filterSignals[numId] = e.element.elem_value
			end
			numId = numId + 1
		end
		UpdateFilterCombinator(entityId)
	end
end

function OnCombinatorBuilt(entity)
	local entityName = entity.name
	local entityId = entity.unit_number
	if entityName== "euc-distinct-constant-combinator" then
		global.state.constantCombinators[entityId] = { entity = entity }
	end
	if entityName == "euc-simple-delay-combinator" then
		local applyDelay = const.simpleDelayCombinator.defaultDelayId
		if global.state.delayCombinators[entityId] then
			applyDelay = global.state.delayCombinators[entityId].currentDelayId
		end
		global.state.delayCombinators[entityId] = { entity = entity, currentDelayId = applyDelay }
	end
	if entityName ==  "euc-inclusive-filter-combinator" then
		if global.state.filterCombinators[entityId] then
			global.state.filterCombinators[entityId].entity = entity
			UpdateFilterCombinator(entityId)
		else
			global.state.filterCombinators[entityId] = { entity = entity, filterSignals = { }, mixWires = false }
		end
		SetCommonArithmeticCombinatorDisplay(entity, const.filterCombinator.emptyDisplaySign)
	end
end


function TrySaveOpenedMenus(playerIndex)
	TrySaveIoCombinatorSettings(playerIndex)
	TrySaveModalText(playerIndex)
end

function ShowCombinatorMenuCommon(entity, playerIndex, name)
	local playerDesc = global.state.players[playerIndex]
	CloseMenus(playerIndex)
	playerDesc.centralUIElement = {
		name = name,
		selectedEntity = entity
	}
	global.state.players[playerIndex] = playerDesc
end

function ShowDistinctConstantCombinatorMenu(entity, playerIndex)
	ShowCombinatorMenuCommon(entity, playerIndex, "DistinctConstantCombinator")

	local player = game.players[playerIndex]
	
	local frame = player.gui.screen.add{
		type = "frame",
		name = "euc_delay_combinator",
		style = "composite_combinators_settings_container",
		caption = { "misc.DelaySettings" },
		direction = "vertical",
	}
	local flow = frame.add {
		type = "flow",
		name = "flow",
		direction = "vertical"
	}
	flow.add {
		type = "label",
		name = "label",
		style = "subheader_caption_label",
		caption =  { "misc.DistinctConstantCombinator_SelectWire" }
	}
	local buttonsFlow = frame.add {
		type = "flow",
		name = "flow2",
		direction = "horizontal"
	}
	buttonsFlow.add {
		type = "sprite-button",
		name = "button_pickwire_red",
		style = "euc_iconbutton",
		sprite = "item/red-wire"
	}
	buttonsFlow.add {
		type = "sprite-button",
		name = "button_pickwire_green",
		style = "euc_iconbutton",
		sprite = "item/green-wire"
	}
	player.opened = frame
	frame.force_auto_center()
end

function ShowDelayCombinatorMenu(entity, playerIndex)
	ShowCombinatorMenuCommon(entity, playerIndex, "DelayCombinator")
	
	local player = game.players[playerIndex]
	
	local frame = player.gui.screen.add{
		type = "frame",
		name = "euc_delay_combinator",
		caption = { "misc.DelaySettings" },
		direction = "vertical",
	}
	local flow = frame.add {
		type = "flow",
		name = "flow",
		direction = "vertical"
	}
	local indicatorFlow = flow.add {
		type = "flow",
		name = "flow1",
		direction = "horizontal"
	}

	indicatorFlow.add {
		type = "label",
		name = "label",
		style = "subheader_caption_label",
		caption =  { "misc.DelaySettings_Indicator" }
	}
	indicatorFlow.add {
		type = "label",
		name = "label2",
		style = "subheader_caption_label",
		caption = ''..const.simpleDelayCombinator.thresholds[global.state.delayCombinators[entity.unit_number].currentDelayId]
	}
	local buttonsFlow = flow.add {
		type = "flow",
		name = "flow2",
		direction = "horizontal"
	}
	buttonsFlow.add {
		type = "label",
		name = "label3",
		style = "subheader_caption_label",
		caption = { "misc.DelaySettings_SetDelay" }
	}
	buttonsFlow = flow.add {
		type = "flow",
		name = "flowA", 
		style = "euc_spaceflow",
		direction = "horizontal"
	}
	local numId = 1
	for _,num in pairs(const.simpleDelayCombinator.thresholds) do
		buttonsFlow.add {
			type = "button",
			name = "button_setdelay_"..numId,
			style = "euc_button",
			caption = ''..num
		}
		if numId % 3 == 0 then
			buttonsFlow = flow.add {
				type = "flow",
				name = "flow"..(numId), 
				style = "euc_spaceflow",
				direction = "horizontal"
			}
		end
		numId = numId + 1
	end
	player.opened = frame
	frame.force_auto_center()
end

function ShowFilterCombinatorMenu(entity, playerIndex)
	ShowCombinatorMenuCommon(entity, playerIndex, "InclusiveFilterCombinator")
	
	local combinatorState = global.state.filterCombinators[entity.unit_number]
	
	local player = game.players[playerIndex]
	
	local frame = player.gui.screen.add{
		type = "frame",
		name = "euc_filter_combinator",
		style = "composite_combinators_settings_container",
		caption = { "misc.FilterSettings" },
		direction = "vertical",
	}
	local flow = frame.add {
		type = "flow",
		name = "flow",
		direction = "vertical"
	}
	flow.add {
		type = "checkbox",
		name = "checkbox_mixwires",
		style = "caption_checkbox",
		caption = { "misc.FilterCombinator_MixWires" },
		state = combinatorState.mixWires
	}
	local buttonsFlow = flow.add {
		type = "flow",
		name = "flow2",
		direction = "horizontal"
	}
	buttonsFlow.add {
		type = "label",
		name = "label3",
		style = "subheader_caption_label",
		caption = { "misc.FilterCombinator_Items" }
	}
	buttonsFlow = flow.add {
		type = "flow",
		name = "flowA", 
		style = "euc_spaceflow",
		direction = "horizontal"
	}
	local numId = 1
	while numId <= const.filterCombinator.maxItems do
		buttonsFlow.add {
			type = "choose-elem-button",
			name = "button_setfilter_"..numId,
			style = "euc_elembutton",
			elem_type = "signal",
			signal = combinatorState.filterSignals[numId] or nil
		}
		if numId % 4 == 0 then
			buttonsFlow = flow.add {
				type = "flow",
				name = "flow"..(numId), 
				style = "euc_spaceflow",
				direction = "horizontal"
			}
		end
		numId = numId + 1
	end
	player.opened = frame
	frame.force_auto_center()
end

--- #endregion

-- that's it

local de = defines.events

script.on_init(OnInit)
script.on_configuration_changed(OnConfigChanged)
script.on_event(de.on_tick, OnTick)