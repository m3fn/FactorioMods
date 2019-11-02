--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- game.lua 
-- Purpose: 
	Dev GUI
	Game events 
]]--


--- #region: Misc.

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

function OnPlayerJoinedGame(e)
	local playerIndex = e.player_index
	global.state.players[playerIndex] = CreatePlayerDesc()
end

function OnPlayerLeftGame(e)
	local playerIndex = e.player_index
	global.state.players[playerIndex] = nil
end

--- #endregion


--- #region: Dev mode & GUI

-- Open/Save/Close

function OnTick(e)
	if global.hasTasks == false then
		return
	end
	
	-- even simple task.age = task.age + 1 in this function is taking anacceptable amount of time, IMHO
	
	for name, task in pairs(global.state.tickTasks) do
		if name == "MaintainUI" then
			local player = game.players[task.playerIndex]
			if player and player.connected and player.opened and player.opened_gui_type and player.opened_gui_type == defines.gui_type.entity then
				local openedEntityName = player.opened.name
				if openedEntityName == "composite-combinator-io-marker" then
					ShowIoCombinatorMenu(player.opened, task.playerIndex)
				end
			else
				task.age = task.age + 1
				if task.age > 2 and not player.selected then
					removeTickTask("MaintainUI")
				end
			end
		end
		if name == "UCDoCC" then
			local del = true
			
			for _, subTask in pairs(task) do
				if (subTask.state == 1 or subTask.state == 2) and subTask.age > 60 then
					error("Something is wrong with blueprint creation. No 'combinator-data' pair built within 60 seconds.")
				end
				if subTask.state == 3 then 
					
					local dataSlots = { }
					local iii = 1
					for _,signals in pairs(subTask.constructionData.get_control_behavior().parameters) do
						for _,signal in pairs(signals) do
							if signal.signal.name then
								--if iii < 10 then
								--	msg(1, iii..'ii'..inspect(signal))
								--end
								--iii = iii + 1
								table.insert(dataSlots, signal)
							end
						end
					end
					table.insert(global.state.waitingForUnghosting, { 
						dataSlots = dataSlots,
						combinatorGhost = subTask.combinator,
						ghostLocation = subTask.combinator.position
					})
					subTask.constructionData.destroy()
					task[_] = nil -- No need for sub task at this point, waiting for ghost materialization
				end

				subTask.age = subTask.age + 1
				del = false
			end
		
			if del then
				msg(1, 'indeed')
				removeTickTask("UCDoCC")
			end
		end
	end
end

function OnSelectedEntityChanged(e)
	local playerIndex = e.player_index
	local player = game.players[playerIndex]
	
	if player.selected then
		if player.selected.name == "composite-combinator-io-marker" then
			addTickTask("MaintainUI", { playerIndex = playerIndex, age = 1 })
		end
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
		if player.selected.name == "composite-combinator-io-marker" then
			addTickTask("MaintainUI", { playerIndex = e.player_index, age = 1 })
		end
	end
end

function OnGuiTextChanged(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	if playerDesc.centralUIElement and playerDesc.centralUIElement.selectedEntityId then
		TrySaveIoCombinatorSettings(playerIndex)
	end
end

function OnCheckedStateChanged(e)
	local playerIndex = e.player_index
	local playerDesc = global.state.players[playerIndex]
	if playerDesc.centralUIElement and playerDesc.centralUIElement.selectedEntityId then
		TrySaveIoCombinatorSettings(playerIndex)
	end
end

function OnGuiClick(e) 
	
end

-- ModalText

function ShowModalText(playerIndex, str, title)
	local playerDesc = global.state.players[playerIndex]
	CloseMenus(playerIndex)
	playerDesc.centralUIElement = {
		name = "ModalTextBox"
	}
	global.state.players[playerIndex] = playerDesc
	
	local player = game.players[playerIndex]

	local frame = player.gui.screen.add{
        type = "frame",
        style = "composite_combinators_settings_container",
        caption = { title },
        direction = "vertical",
		auto_center = true
    }
	frame.add {
		type = "line",
		direction = "horizontal"
	}
	local textBox = frame.add{
		type = "text-box",
		style = "composite_combinators_settings_textbox",
		read_only = true,
		word_wrap = true,
		text = str
	}
	player.opened = frame
	frame.force_auto_center()
	textBox.select_all()
		
end

function TrySaveModalText(playerIndex)
	local player = game.get_player(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	
	if not playerDesc.centralUIElement or playerDesc.centralUIElement.name ~= "ModalTextBox" then
		return
	end
end

-- IO Combinator

function ShowIoCombinatorMenu(entity, playerIndex)
	local player = game.players[playerIndex]
	
	local playerDesc = global.state.players[playerIndex]
	CloseMenus(playerIndex)
	playerDesc.centralUIElement = {
		name = "IOsettings",
		selectedEntityId = entity.unit_number
	}
	global.state.players[playerIndex] = playerDesc
	
	local dataDesc = global.state.ioEntStates[entity.unit_number] or { num = '1' }
	
	local frame = player.gui.screen.add{
        type = "frame",
        name = "composite_combinators_io_settings",
        style = "composite_combinators_settings_container_small",
        caption = { "misc.IOSettings" },
        direction = "vertical",
    }
	local flow = frame.add {
        type = "flow",
		name = "flow",
        direction = "vertical"
    }
	local toggleFlow = flow.add {
		type = "flow",
		name = "flow1",
		direction = "horizontal"
	}
	local numFlow = flow.add {
		type = "flow",
		name = "flow2",
		direction = "horizontal"
	}
	numFlow.add {
		type = "label",
		name = "label",
		style = "composite_combinators_settings_label",
		caption =  { "misc.IONumber" }
	}
	inoutNum = numFlow.add {
		type = "textfield",
		name = "textfield",
		style = "composite_combinators_settings_textfield",
		text = dataDesc.num
	}
	player.opened = frame
	frame.force_auto_center()
end

function TrySaveIoCombinatorSettings(playerIndex)
	local player = game.get_player(playerIndex)
	local playerDesc = global.state.players[playerIndex]
	
	if not playerDesc.centralUIElement or playerDesc.centralUIElement.name ~= "IOsettings" then
		return
	end
	
	local ioNum = tonumber(player.gui.screen.composite_combinators_io_settings["flow"]["flow2"]["textfield"].text)
	local entityId = playerDesc.centralUIElement.selectedEntityId
	
	global.state.ioEntStates[entityId] = {
		num = ioNum
	}

	global.state.players[playerIndex] = playerDesc
end


-- Dev. rest

function ShowSelectionStr(player, entities)
	GetComponentsDataSlotsFromBigEntities_Prn(player, entities)
end

function ShowSelectionStr2(player, entities)
	for _,entity in pairs(entities) do
		if global.state.combinatorEntities[entity.unit_number] ~= nil then
			GetComponentsDataSlotsFromSmallEntities_Prn(player, entity)
			return
		end
	end
end

function ShowSelectionComponentStr(player, entities)
	PrintOneComponentStr(player, entities, true)
end


function OnPlayerSelectedArea(e)
	local playerIndex = e.player_index
	if e.item == "composite-combinator-str" then
		local player = game.get_player(playerIndex)
		ShowSelectionStr(player, e.entities)
		player.clean_cursor()
	end
	if e.item == "composite-combinator-component-str" then
		local player = game.get_player(playerIndex)
		ShowSelectionComponentStr(player, e.entities)
		player.clean_cursor()
	end
	if e.item == "composite-combinator-composite-str" then
		local player = game.get_player(playerIndex)
		ShowSelectionStr2(player, e.entities)
		player.clean_cursor()
	end
	if e.item == "composite-combinator-test-reserialize" and e.entities[1] then
		local player = game.get_player(playerIndex)
		player.clean_cursor()
		CloseMenus(playerIndex)
		
		for _,ent in pairs(e.entities) do
			local combinatorDataDesc = global.modCfg.combinatorPrototypes[ent.prototype.name]
			
			local compStr = GetComponentsDataSlotsFromBigEntities_Int( { ent } )
			
			local dataSlots = StringToDataSlots(componentsStr)
			
			SpawnCompositeCombinatorComponents_Int(ent, dataSlots)
		end
	end
end

function OnPlayerAltSelectedArea(e)
	if e.item == "composite-combinator-str" then
		local player = game.get_player(e.player_index)
		ShowSelectionStr(player, e.entities)
	end
end



-- Main

function OnCombinatorBuilt(entity, combinatorDataDesc)
	for _,item in pairs(global.state.waitingForUnghosting) do
		if not item.combinatorGhost.valid then -- Ghost should not exist at this point
			if entity.position.x == item.ghostLocation.x and entity.position.y == item.ghostLocation.y then
				SpawnCompositeCombinatorComponentsBySlots(entity, item.dataSlots) -- hell yeah
				global.state.waitingForUnghosting[_] = nil 
				return
			end
		end
	end
	
	local strIndex = remote.call(combinatorDataDesc.callbacksRemote, "PickBuildString", entity)

	SpawnCompositeCombinatorComponents(entity, combinatorDataDesc, strIndex)
end

function OnEntityBuiltSimple(entity)
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[entity.prototype.name]
	if combinatorDataDesc ~= nil then
		OnCombinatorBuilt(entity, combinatorDataDesc)
	end
end

--[[

Blueprinting flow is:

Whichever ghost built first (combinator or construction data) - addTickTask("Unbound construction data or composite combinator")
Second ghost - modify tick task pinpoiting by location
Then on tick remove construction data ghost, save data of combinator ghost in global
Then when built by robot - usual OnBuilt, except we use data from cosntructionData, not via PickBuildString str

]]--

function OnPlayerBuiltEntity(e)
	local entity = e.created_entity
	if entity.name == "entity-ghost" then
		local ghostName = entity.ghost_name
		local combinatorDataDesc = global.modCfg.combinatorPrototypes[ghostName]
		
		if ghostName == "composite-combinator-construction-data" or combinatorDataDesc ~= nil then
			local unboundEntsTask = global.state.tickTasks["UCDoCC"]
			local addTask = false
			local entityPos = entity.position
			if unboundEntsTask == nil then
				addTask = true
				unboundEntsTask = { }
			end
			local addSubTask = true
				
			if ghostName == "composite-combinator-construction-data" then
				for _, subTask in pairs(unboundEntsTask) do
					if subTask.constructionData == nil and subTask.combinator ~= nil and subTask.combinator.position.x == entityPos.x and subTask.combinator.position.y == entityPos.y then
						subTask.constructionData = entity
						subTask.state = 3
						addSubTask = false
						break
					end
				end
				if addSubTask then
					table.insert(unboundEntsTask, { constructionData = entity, combinator = nil, isReady = false, state = 1, age = 1 })
				end
			elseif combinatorDataDesc ~= nil then
				for _, subTask in pairs(unboundEntsTask) do
					if subTask.constructionData ~= nil and subTask.combinator == nil and subTask.constructionData.position.x == entityPos.x and subTask.constructionData.position.y == entityPos.y then
						subTask.combinator = entity
						subTask.state = 3
						addSubTask = false
						break
					end
				end
				if addSubTask then
					table.insert(unboundEntsTask, { constructionData = nil, combinator = entity, isReady = false, state = 2, age = 1 })
				end
			end
			
			if addTask then
				addTickTask("UCDoCC", unboundEntsTask)
			end
		end
	end
	OnEntityBuiltSimple(entity)
end

function OnEntityMinedSimple(entity)
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[entity.prototype.name]
	if combinatorDataDesc == nil then
		return
	end
	
	local entityState = global.state.combinatorEntities[entity.unit_number]
	if entityState == nil then
		error('Mined entity is not in global.state.combinatorEntities, but is of global.modCfg.combinatorPrototypes Should not happen')
	end
	
	DeleteComponents(entity, entityState)
end

function OnPlayerMinedEntity(e)
	OnEntityMinedSimple(e.entity)
end

function OnRobotMinedEntity(e)
	OnEntityMinedSimple(e.entity)
end

function OnEntityDied(e)
	OnEntityDiedOrDestroyed(e.entity, false)
end

function OnScriptRaisedDestroy(e)
	OnEntityDiedOrDestroyed(e.entity, true)
end

function OnEntityDiedOrDestroyed(entity, isScript)
	local entityName = entity.prototype.name
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[entityName]
	if combinatorDataDesc ~= nil then
		local entityState = global.state.combinatorEntities[entity.unit_number]
		if entityState == nil then
			error('Died entity is not in global.state.combinatorEntities, but is of global.modCfg.combinatorPrototypes Should not happen')
		end
		
		DeleteComponents(entity, entityState)
		EraseEntityData(entity)
	end
	
	local componentDataDesc = global.modCfg.componentsDataDescByComponentName[entityName]
	if componentDataDesc ~= nil then
		local entiyId = entity.unit_number 
		-- TODO: optimize
		for _,combinatorEntityState in pairs(global.state.combinatorEntities) do
			if combinatorEntityState.components ~= nil and not combinatorEntityState.deletingComponents then
				for _,component in pairs(combinatorEntityState.components) do
					if component.componentEntity.valid and component.componentEntity.unit_number == entiyId then
						msg(1, "DES: "..component.componentEntity.unit_number)
					end
				end
				if combinatorEntityState.dataSlotsStorage ~= nil and combinatorEntityState.dataSlotsStorage.valid and combinatorEntityState.dataSlotsStorage.unit_number == entityId then
					msg(1, "DES: "..combinatorEntityState.dataSlotsStorage.unit_number)
				end
			end
		end
		
	end
end

function OnRobotPreMined(e)

end



function OnPlayerRotatedEntity(e)
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[e.entity.prototype.name]
	if not combinatorDataDesc then
		return
	end
	
	RearrangeAccordingToRotation(e.entity, e.previous_direction, e.entity.direction)
end

function OnPlayerSetupBlueprint(e)

end

function OnPlayerDeconstructedArea(e)

end


function OnRobotBuiltEntity(e)
	msg(1, 'bui')
	OnEntityBuiltSimple(e.created_entity)
end

function OnPlayerConfiguredBlueprint(e)

end

function OnEntityCloned(e)

end

function OnAreaCloned(e)

end






local de = defines.events

if settings.startup['composite-combinators-dev-mode'].value then

script.on_event(de.on_player_selected_area, OnPlayerSelectedArea)
script.on_event(de.on_player_alt_selected_area, OnPlayerAltSelectedArea)
script.on_event(de.on_gui_click, OnGuiClick)
script.on_event(de.on_gui_text_changed, OnGuiTextChanged)
script.on_event(de.on_gui_checked_state_changed, OnCheckedStateChanged)
script.on_event(de.on_selected_entity_changed, OnSelectedEntityChanged)
script.on_event(de.on_gui_closed, OnGuiClosed)

end

script.on_event(de.on_tick, OnTick)

script.on_event(de.on_player_joined_game, OnPlayerJoinedGame)
script.on_event(de.on_player_left_game, OnPlayerLeftGame)

script.on_event(de.on_player_rotated_entity, OnPlayerRotatedEntity)
script.on_event(de.on_built_entity, OnPlayerBuiltEntity)
script.on_event(de.on_player_mined_entity, OnPlayerMinedEntity)
script.on_event(de.on_robot_built_entity, OnRotobBuiltEntity)
script.on_event(de.on_entity_died, OnEntityDied)
script.on_event(de.script_raised_destroy, OnScriptRaisedDestroy)
script.on_event(de.on_player_setup_blueprint, OnPlayerSetupBlueprint)
script.on_event(de.on_player_deconstructed_area, OnPlayerDeconstructedArea)
script.on_event(de.on_player_configured_blueprint, OnPlayerConfiguredBlueprint)
script.on_event(de.on_entity_cloned, OnEntityCloned)
script.on_event(de.on_area_cloned, OnAreaCloned)
script.on_event(de.on_robot_built_entity, OnRobotBuiltEntity)
script.on_event(de.on_robot_pre_mined, OnRobotPreMined)
script.on_event(de.on_robot_mined_entity, OnRobotMinedEntity)

--- #endregion