--[[
--------------------------------------------------------------------------------
-- Extremely Useful Composite Combinators mod
--------------------------------------------------------------------------------
-- commonesque.lua 
	Common events for all combinators and UIs
]]--

function OnSelectedEntityChanged(e)
	local playerIndex = e.player_index
	local player = game.players[playerIndex]
	
	if player.selected then
		if HasValue(const.managedEnts, player.selected.name) then
			addTickTask("MaintainUI", { playerIndex = playerIndex, age = 1 })
		end
	end
end


function OnCheckedStateChanged(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	
	if playerDesc.centralUIElement then
		OnEucCheckedStateChanged(e)
	end
end

function EnsurePlayerStates()
	for _, player in pairs(game.connected_players) do
		global.state.players[player.index] = CreatePlayerDesc()
	end
end

function OnPlayerBuiltEntity(e)
	local entity = e.created_entity
	if HasValue(const.managedEnts, entity.name) then
		OnCombinatorBuilt(entity)
	end
end

function OnRobotBuiltEntity(e)
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


function CloseMenus(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	if playerDesc.centralUIElement and playerDesc.centralUIElement.selectedEntityId then
		TrySaveOpenedMenus(playerIndex)
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
		local selectedEntityName = player.selected.name
		if HasValue(const.managedEnts, selectedEntityName) then
			addTickTask("MaintainUI", { playerIndex = e.player_index, age = 1 })
		end
	end
	for _,h in pairs(global.state.nextGuiCloseHandlers) do
		h(e)
	end
	global.state.nextGuiCloseHandlers = { }
end

function OnGuiClick(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	
	if playerDesc.centralUIElement then
		OnEucGuiClick(e)
	end
end

function OnGuiElemChanged(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	
	if playerDesc.centralUIElement then
		OnEucGuiElemChanged(e)
	end
end

local de = defines.events

script.on_event(de.on_selected_entity_changed, OnSelectedEntityChanged)
script.on_event(de.on_gui_click, OnGuiClick)
script.on_event(de.on_gui_closed, OnGuiClosed)
script.on_event(de.on_gui_checked_state_changed, OnCheckedStateChanged)
script.on_event(de.on_player_joined_game, OnPlayerJoinedGame)
script.on_event(de.on_player_left_game, OnPlayerLeftGame)
script.on_event(de.on_built_entity, OnPlayerBuiltEntity)
script.on_event(de.on_robot_built_entity, OnRobotBuiltEntity)
script.on_event(de.on_gui_elem_changed, OnGuiElemChanged)