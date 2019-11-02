--[[
--------------------------------------------------------------------------------
-- Extremely Useful Composite Combinators mod
--------------------------------------------------------------------------------
-- euc.lua 

]]--

const = {
	managedEnts = {
		"euc-distinct-constant-combinator",
		"euc-simple-delay-combinator"
	},
	simpleDelayCombinator = {
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
		thresholdIdToSign = {
			'+', '-', '*', '/', '%'
		}
	}
	
	
}

function OnInit()
	global.state = {
		tickTasks = { },
		tasksCount = 0,
		players = { },
		delayCombinators = { }
	}
    
	global.hasTasks = false
	
	RegisterEntities()
	EnsurePlayerStates()
end

function OnConfigChanged(data)
	EnsurePlayerStates() -- TODO REMOVE?
end

remote.add_interface("ExtremelyUsefulCombinators", {
	PickBuildString = function(entity)
		if entity.name == "euc-simple-delay-combinator" then
			SetDelayCombinatorDisplay(entity, const.simpleDelayCombinator.defaultDelayId)
			return const.simpleDelayCombinator.defaultDelayId
		end
		return 1
	end
})


function RegisterEntities()
	remote.call(
		"Composite-Combinators-Core", "registerCompositeCombinatorPrototype", 
		"euc-distinct-constant-combinator", 
		2, { x = 0.5, y = 0.5 },
		{
			"item-with-tags$composite-combinator-io-marker$item$constant-combinator$)1$2$1$262144$1(3$4$2$131584$1[(3$4$2$393472$1[()01$131073$65537(00$196609$65537("
		},
		"ExtremelyUsefulCombinators"
	)
	remote.call(
		"Composite-Combinators-Core", "registerCompositeCombinatorPrototype", 
		"euc-simple-delay-combinator", 
		6, { x = 0.66, y = 0.33 },
		{
			-- 1 tick
			"item$arithmetic-combinator$item-with-tags$composite-combinator-io-marker$)1$2$45$131077$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131328$1(1$2$45$131333$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131339$2()01$131073$65537(01$262145$65538(00$196610$65537(00$262147$65538(",
			-- 2 ticks
			"item$arithmetic-combinator$item-with-tags$composite-combinator-io-marker$)1$2$45$131075$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131079$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131584$1(1$2$45$131843$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131847$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131595$2()01$196609$65537(01$131073$65538(01$393218$65538(00$262147$65537(00$327684$65538(00$393221$65538(",
			-- 3 ticks
			"item$arithmetic-combinator$item-with-tags$composite-combinator-io-marker$)1$2$45$131075$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131077$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131079$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131584$1(1$2$45$131843$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131845$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131847$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131595$2()01$262145$65537(01$131073$65538(01$196610$65538(01$524291$65538(00$327684$65537(00$393221$65538(00$458758$65538(00$524295$65538(",
			-- 5 ticks
			"item$arithmetic-combinator$item-with-tags$composite-combinator-io-marker$)1$2$45$131330$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131075$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131077$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131336$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131079$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131584$1(1$2$45$131586$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131843$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131845$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131847$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131592$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131595$2()01$393217$65537(01$131073$65538(01$196610$65538(01$327683$65538(01$327684$131073(01$786436$65538(00$458758$65537(00$524295$65538(00$589832$65538(00$655369$65538(00$720906$65538(00$786443$65538(",
			-- 7 ticks
			"item$arithmetic-combinator$item-with-tags$composite-combinator-io-marker$)1$2$45$131330$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131332$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131075$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131334$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131077$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131336$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131079$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131584$1(1$2$45$131586$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131843$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131588$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131845$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131590$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131847$virtual@signal-each@^@1@virtual@signal-each@1(1$2$45$131592$virtual@signal-each@^@1@virtual@signal-each@1(3$4$1$131595$2()01$524289$65537(01$196609$65538(01$196610$131073(01$327682$65538(01$327684$131073(01$458756$65538(01$458758$131073(01$1048582$65538(00$589832$65537(00$655369$65538(00$720906$65538(00$786443$65538(00$851980$65538(00$917517$65538(00$983054$65538(00$1048591$65538(",
		},
		"ExtremelyUsefulCombinators"
	)
	
end

function SetDelayCombinatorDisplay(entity, delayId)
	local params = entity.get_control_behavior().parameters
	params.parameters.operation = const.simpleDelayCombinator.thresholdIdToSign[delayId]
	entity.get_control_behavior().parameters = params
end

function OnTick(e)
	if global.hasTasks == false then -- return as qucikly as we can
		return
	end
	
	for name, task in pairs(global.state.tickTasks) do
		if name == "MaintainUI" then
			local player = game.players[task.playerIndex]
			msg(1, "ggg")
			if player and player.connected and player.opened and player.opened_gui_type and player.opened_gui_type == defines.gui_type.entity then
				local openedEntityName = player.opened.name
				if HasValue(const.managedEnts, openedEntityName) then
					ShowIoCombinatorMenu(player.opened, task.playerIndex)
				end
			else
				task.age = task.age + 1
				if task.age > 2 and not player.selected then
					removeTickTask("MaintainUI")
				end
			end
		end
	end
end


function ShowIoCombinatorMenu(entity, playerIndex)
	local player = game.players[playerIndex]
	
	local playerDesc = global.state.players[playerIndex]
	CloseMenus(playerIndex)
	playerDesc.centralUIElement = {
		name = "DelayCombinator",
		selectedEntity = entity
	}
	global.state.players[playerIndex] = playerDesc
	
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
	local indicatorFlow = flow.add {
		type = "flow",
		name = "flow1",
		direction = "horizontal"
	}
	local buttonsFlow = flow.add {
		type = "flow",
		name = "flow2",
		direction = "horizontal"
	}
	indicatorFlow.add {
		type = "label",
		name = "label",
		style = "composite_combinators_settings_label",
		caption =  { "misc.DelaySettings_Indicator" }
	}
	indicatorFlow.add {
		type = "label",
		name = "label2",
		style = "composite_combinators_settings_label",
		caption =  { ''..global.state.delayCombinators[entity.unit_number].currentDelayId }
	}
	local numId = 1
	for _,num in pairs(const.simpleDelayCombinator.thresholds) do
		buttonsFlow.add {
			type = "button",
			name = "button_setdelay_"..numId,
			style = "composite_combinators_settings_button",
			caption = ''..num
		}
		if numId % 3 == 0 then
			buttonsFlow = flow.add {
				type = "flow",
				name = "flow"..(numId), 
				direction = "horizontal"
			}
		end
		numId = numId + 1
	end
	player.opened = frame
	frame.force_auto_center()
end


function OnGuiClick(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	
	if playerDesc.centralUIElement then
		if playerDesc.centralUIElement.name == "DelayCombinator" then
			local elementName = e.element.name
			local tnum = 1
			for num in ipairs(const.simpleDelayCombinator.thresholds) do -- I hate lua too much to do this in a civil way
				if tnum ~= 0 then
					msg(1, elementName..' or '.."button_setdelay_"..tnum)
					if elementName == "button_setdelay_"..tnum then 
						local entity = playerDesc.centralUIElement.selectedEntity
						remote.call("Composite-Combinators-Core", "changeLayout", entity.unit_number, tnum)
						SetDelayCombinatorDisplay(entity, tnum)
						global.state.delayCombinators[entity.unit_number].currentDelayId = tnum
						msg(1, "Changed delay to "..const.simpleDelayCombinator.thresholds[tnum])
						tnum = 0
					end
					tnum = tnum + 1
				end
			end
		end
	end
end

function OnSelectedEntityChanged(e)
	local playerIndex = e.player_index
	local player = game.players[playerIndex]
	
	if player.selected then
		if HasValue(const.managedEnts, player.selected.name) then
			msg(1, "yo")
			addTickTask("MaintainUI", { playerIndex = playerIndex, age = 1 })
		end
	end
end


function OnCheckedStateChanged(e)


end


function OnCombinatorBuilt(entity)
	global.state.delayCombinators[entity.unit_number] = { currentDelayId = const.simpleDelayCombinator.defaultDelayId }
end

function OnPlayerBuiltEntity(e)
	local entity = e.created_entity
	if HasValue(const.managedEnts, entity.name) then
		OnCombinatorBuilt(entity)
	end
end

function OnRotobBuiltEntity(e)
	local entity = e.created_entity
	if HasValue(const.managedEnts, entity.name) then
		OnCombinatorBuilt(entity)
	end
end

-- TODO: on destroyed

function OnPlayerJoinedGame(e)
	local playerIndex = e.player_index
	global.state.players[playerIndex] = CreatePlayerDesc()
end

function OnPlayerLeftGame(e)
	local playerIndex = e.player_index
	global.state.players[playerIndex] = nil
end


function CreatePlayerDesc()
	return {
		centralUIElement = nil
	}
end

function EnsurePlayerStates()
	for _, player in pairs(game.connected_players) do
		global.state.players[player.index] = CreatePlayerDesc()
	end
end


function CloseMenus(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	if playerDesc.centralUIElement and playerDesc.centralUIElement.selectedEntityId then
		TrySaveIoCombinatorSettings(playerIndex)
		TrySaveModalText(playerIndex)
	end
	playerDesc.centralUIElement = nil
	removeTickTask("MaintainUI")
	
	local player = game.get_player(playerIndex)
	player.opened = nil
	player.gui.screen.clear()
end

function OnGuiClosed(e)
	local player = game.get_player(e.player_index)
	CloseMenus(e.player_index)
	if player.selected then
		if HasValue(const.managedEnts, openedEntityName) then
			addTickTask("MaintainUI", { playerIndex = e.player_index, age = 1 })
		end
	end
end


local de = defines.events

script.on_init(OnInit)
script.on_configuration_changed(OnConfigChanged)
script.on_event(de.on_tick, OnTick)
script.on_event(de.on_selected_entity_changed, OnSelectedEntityChanged)
script.on_event(de.on_gui_click, OnGuiClick)
script.on_event(de.on_gui_closed, OnGuiClosed)
script.on_event(de.on_gui_checked_state_changed, OnCheckedStateChanged)
script.on_event(de.on_player_joined_game, OnPlayerJoinedGame)
script.on_event(de.on_player_left_game, OnPlayerLeftGame)
script.on_event(de.on_built_entity, OnPlayerBuiltEntity)
script.on_event(de.on_robot_built_entity, OnRotobBuiltEntity)