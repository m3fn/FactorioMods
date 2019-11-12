--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- func.lua 
-- Purpose: 
	Core logic;
]]--

--- #region: Func Interface

Func = {}
Func.__index = Func

--[[ On rotation change ]]--
local RearrangeAccordingToRotation
function Func:RearrangeAccordingToRotation(combinator, prevRotation, nextRotation)
	return RearrangeAccordingToRotation(combinator, prevRotation, nextRotation)
end

local EraseCombinatorData
function Func:EraseCombinatorData(combinator)
	return EraseCombinatorData(combinator)
end

--[[ Remove (destroy) combinator components and data about them ]]--
local DeleteComponents
function Func:DeleteComponents(combinator)
	return DeleteComponents(combinator)
end

--[[ Main spawn function ]]--
local SpawnCompositeCombinatorComponents
function Func:SpawnCompositeCombinatorComponents(combinator, combinatorDataDesc, str)
	return SpawnCompositeCombinatorComponents(combinator, combinatorDataDesc, str)
end

local GetOneComponentStr
function Func:GetOneArchetypeEntityStr(archetypeEntities)
	return GetOneArchetypeEntityStr(archetypeEntities)
end

local GetComponentsStringFromArchetypes
function Func:GetComponentsStringFromArchetypes(entities)
	return GetComponentsStringFromArchetypes(entities)
end

local GetComponentsStringFromComponents
function Func:GetComponentsStringFromComponents(combinator)
	return GetComponentsStringFromComponents(combinator)
end

local GetComponentData
function Func:GetComponentData(combinatorId, componentId)
	return GetComponentData(combinatorId, componentId)
end

local ChangeLayout
function Func:ChangeLayout(combinatorId)
	return ChangeLayout(combinatorId)
end

local RefreshDataStorageSlots
function Func:RefreshDataStorageSlots(combinatorId)
	return RefreshDataStorageSlots(combinatorId)
end

local SpawnCompositeCombinatorComponentsBySlots
function Func:SpawnCompositeCombinatorComponentsBySlots(combinator, dataSlots)
	return SpawnCompositeCombinatorComponentsBySlots(combinator, dataSlots)
end

--- #endregion




local function DeleteComponents_Int(combinator, combinatorState)
	combinatorState.deletingComponents = true
	for _,componentData in pairs(combinatorState.components) do
		componentData.componentEntity.destroy() -- ({raise_destroy = true})
	end
	combinatorState.components = { }
	for _, dataSlotsStorage in pairs(combinatorState.dataSlotsStorageCopies) do
		dataSlotsStorage.destroy()
	end
	combinatorState.dataSlotsStorageCopies = nil
	combinatorState.deletingComponents = false
end

local function GetCombinatorComponents(combinator)
	local res = { }
	local combinatorDataDesc = global.state.combinatorEntities[combinator.unit_number]
	for _,component in pairs(combinatorDataDesc.components) do
		table.insert(res, component.componentEntity)
	end
	return res
end

DeleteComponents = function(combinator, combinatorState)
	local combinatorState = global.state.combinatorEntities[combinator.unit_number]
	DeleteComponents_Int(combinator, combinatorState)
end

EraseCombinatorData = function(combinator)
	global.state.combinatorEntities[combinator.unit_number] = nil
end

ChangeLayout = function(combinatorId)
	local combinatorEntityState = global.state.combinatorEntities[combinatorId]
	local combinatorEntity = combinatorEntityState.entity
	
	DeleteComponents_Int(combinatorEntity, combinatorEntityState)
	
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[combinatorEntity.prototype.name]

	local str = Remote:GetBuildString(combinatorDataDesc, combinatorEntity)

	SpawnCompositeCombinatorComponents(combinatorEntity, combinatorDataDesc, str)
end

RearrangeAccordingToRotation = function(combinator, prevRotation, nextRotation)
	-- ChangeLayout(combinator.unit_number, 1) -- TODO
end

GetComponentData = function(combinatorId, componentId)
	local combinatorEntityState = global.state.combinatorEntities[combinatorId]
	local i = 1
	for _,component in pairs(combinatorEntityState.components) do
		if i == componentId then
			return component
		end
		i = i + 1
	end
end


GetComponentsStringFromArchetypes = function(archetypeEntities)
	return FuncMain:GetComponentsStringFromEntities_Int(nil, archetypeEntities, false)
end

GetComponentsStringFromComponents = function(combinator)
	local components = GetCombinatorComponents(combinator)

	return FuncMain:GetComponentsStringFromEntities_Int(combinator, components, true)
end

SpawnCompositeCombinatorComponentsBySlots = function(combinator, dataSlots)
	local dataSlots2 = {
		dataSlots = dataSlots,
		nextSlot = -1
	}
	FuncMain:SpawnCompositeCombinatorComponents_Int(combinator, dataSlots2)
end

SpawnCompositeCombinatorComponents = function(combinator, combinatorDataDesc, componentsStr)
	if componentsStr == nil then
		error("componentsStr is nil.")
	end
	
	-- One more func for str -> built could made better performance, but I am not willing to create AND support it
	local dataSlots = FuncMain:StringToDataSlots_Int(componentsStr)
	
	FuncMain:SpawnCompositeCombinatorComponents_Int(combinator, dataSlots)
end

GetOneArchetypeEntityStr = function(archetypeEntities)
	for _,entity in pairs(archetypeEntities) do 
		local componentDataDesc = global.modCfg.componentPrototypes[entity.name]
		
		local componentDataStr = Remote:ComponentToString(componentDataDesc, entity)
		
		return componentDataStr
	end
end

RefreshDataStorageSlots = function(combinatorId)
	local combinatorEntityState = global.state.combinatorEntities[combinatorId]

	if combinatorEntityState == nil then
		error("global.state.combinatorEntities has to info about passed entity")
	end
	
	local combinatorEntity = combinatorEntityState.entity
	local str = Func:GetComponentsStringFromComponents(combinatorEntity)
	
	-- We could just update data slots entity, but this breaks consistency that signals that are currently on wire are reset on entity settings change
	-- this is inevitable case for ChangeLayout, so we do this here as well
	-- reset wire signals only for some cases will look strange for user
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[combinatorEntity.prototype.name]
	
	DeleteComponents_Int(combinatorEntity, combinatorEntityState)
	SpawnCompositeCombinatorComponents(combinatorEntity, combinatorDataDesc, str)
end