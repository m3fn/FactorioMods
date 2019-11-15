--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- entry.lua 
-- Purpose:
	Mod config, mod init;
	Core remote interface (API), outbound remote calls;
	Base things - Add vanilla conbinators as components (using component part of that API);
	
	Tab is 4 spaces, prototypes use 2 spaces without tabs
	
	Glossary:
		combinator - composite combinator, referring to them as compositeCombiantor in code is a bit redundant
		combinatorPrototype, combinatorDataDesc - prototype and entity, they are added via remote calls
		componentPrototype, componentDataDesc - prototype and entity, they are added via remote calls
		component - a small entity inside of composite combinator
		componentArchetype - big component entity
		
		For example for decider combinator componentArchetype is 'decider-combinator', component 'composite-combinator-decider-component', one componentPrototype links them
		
		str, componentStr, string, combinatorStr, combinatorString - strings are used to store and manipulate combinators and components data
		DataSlots - is also used to store and manipulate combinators and components data, we could get rid of it if we could add str info to blueprint
		
		Naming may be inconsistent in some places
]]--

limits = {
	-- Random Limitations
	-- Changes to some values can corrupt existing entities and blueprints
	maxDataSlotsInCompositeCombinator = 8192,	-- Do not make data too fat, also a value in composite-combinator-construction-data 	(may be a subject for extending)
	maxComponentStringDataLength = 8192*4,		-- Do not make data too fat
	maxComponentDataSlotsLength = 1666,			-- 																						(may be a subject for extending)
	maxCombinatorPrototypeWidthOrHeight = 64,	--
	maxComponents = 65535,						-- to fit two values in 32 bit
	maxComponentConnections = 65535,			-- TODO check
	minCompressionRatio = 2,
	maxCompressionRatio = 8,					-- just because
	maxInputsAndOutputsTotal = 32,				-- just because, mby factorio supports less
	maxComponentsArchetypesAreaSize = 255,		-- to fit in, also enough
}

--- #region: Init / Deinit; Events

local RegisterServiceComponents
local RegisterVanillaComponents

function OnInit()
	global.modCfg = { 
		combinatorPrototypes = { },
		componentPrototypes = { },
		componentPrototypesByComponentName = { }
	}
	
	global.state = {
		players = { },
		ioEntStates = { },
		combinatorEntities = { },
		waitingForUnghosting = { },
		tickTasks = { },
		tasksCount = 0,
		extBuildingStrs = { }
	}
	
	global.hasTasks = false
	
	RegisterServiceComponents()
	RegisterVanillaComponents()
	
	if settings.startup['composite-combinators-dev-mode'].value then
	
		commands.add_command("CCCTest", '', UnitTest)
	
	end
end

function OnConfigChanged(data)
	EnsurePlayerStates() -- TODO REMOVE?
end

function OnLoad()
	
end

script.on_init(OnInit)
script.on_configuration_changed(OnConfigChanged)
script.on_load(OnLoad)

--- #endregion


--- #region Core remote interface

remote.add_interface("Composite-Combinators-Core", {

	-- Register composite combinator entity itself.

	registerCompositeCombinatorPrototype = function(entityName, compressionRatio, componentsTopLeftOffset, callbacksRemote, callbacksRemotePrefix)
	
		if compressionRatio > limits.maxCompressionRatio or compressionRatio < limits.minCompressionRatio then
			error("Remote call to Composite-Combinators-Core::registerCompositeCombinatorPrototype failed: compression ratio exceeds limitations")
		end
	
		local sizes = game.entity_prototypes[entityName].selection_box
		local height = sizes.right_bottom.x - sizes.left_top.x -- this is not mistake, I feel more comfortable with east direction as basic
		local width = sizes.right_bottom.y - sizes.left_top.y

		if width > limits.maxCombinatorPrototypeWidthOrHeight or height > limits.maxCombinatorPrototypeWidthOrHeight then
			error("Remote call to Composite-Combinators-Core::registerCompositeCombinatorPrototype failed: entity size exceeds limitations")
		end
		
		-- Say hello
		remote.call(callbacksRemote, callbacksRemotePrefix.."GetBuildString", nil)
		remote.call(callbacksRemote, callbacksRemotePrefix.."SaveStateInfoToSlots", nil, nil)
		remote.call(callbacksRemote, callbacksRemotePrefix.."RestoreStateInfoFromSlots", nil, nil, -1)
		
		global.modCfg.combinatorPrototypes[entityName] = { 
			name = entityName,
			compressionRatio = compressionRatio,
			combinatorWidth = width,
			combinatorHeight = height,
			componentsTopLeftOffset = componentsTopLeftOffset,
			callbacksRemote = callbacksRemote,
			callbacksRemotePrefix = callbacksRemotePrefix
		}

	end,
	
	-- In case of whatever inter-modding contexts;

	deletCompositeCombinatorPrototype = function (entityName)
		global.modCfg.logicCellPrototypes[entityName] = nil
	end,
	
	-- Components

	registerComponentPrototype = function(archetypeEntityName, componentEntityName, connectorIds, entityToStringRemote, stringToDataSlotsRemote, spawnedRemote)
		if archetypeEntityName == "" or archetypeEntityName == nil then
			error("Remote call to Composite-Combinators-Core::registerComponentPrototype failed: null or empty entity name")
		end

		if componentEntityName == "" or componentEntityName == nil then
			error("Remote call to Composite-Combinators-Core::registerComponentPrototype failed: null or empty entity componentEntityName")
		end

		for _,cid in pairs(connectorIds) do
			if cid == nil or cid < 1 or cid >= limits.maxInputsAndOutputsTotal then
				error("Remote call to Composite-Combinators-Core::registerComponentPrototype failed: one of connectorIds is invalid or out of range")
			end
		end
		
		-- Say hello
		remote.call(entityToStringRemote.interface, entityToStringRemote.method, nil, nil, -1)
		remote.call(stringToDataSlotsRemote.interface, stringToDataSlotsRemote.method, nil, nil, -1)
		remote.call(spawnedRemote.interface, spawnedRemote.method, nil, nil, -1)
		
		local componentDataDesc = {
			archetypeEntityName = archetypeEntityName,
			componentEntityName = componentEntityName,
			connectorIds = connectorIds,
			entityToStringRemote = entityToStringRemote,
			stringToDataSlotsRemote = stringToDataSlotsRemote,
			spawnedRemote = spawnedRemote
		}
				
		global.modCfg.componentPrototypes[archetypeEntityName] = componentDataDesc
		global.modCfg.componentPrototypesByComponentName[componentEntityName] = componentDataDesc
	end,
	
	-- deletComponentPrototype does not make sense to me
	
	-- Build components str with
	
	strBuilderBegin = function(identifier, combinatorPrototypeName)
		if global.state.extBuildingStrs[identifier] then
			error("Str builder with this identifier is already in progress")
		end
		global.state.extBuildingStrs[identifier] = StrBuilder:new()
		global.state.extBuildingStrs[identifier].fromComponents = false -- ?
	end,
	
	strBuilderAddComponent = function(identifier, prototypeName, position, direction, componentString, virtualUnitId)
		if not global.state.extBuildingStrs[identifier] then
			error("Str builder with this identifier is not in progress")
		end
		global.state.extBuildingStrs[identifier]:AddComponent(prototypeName, position, direction, componentString, virtualUnitId)
	end,
	
	strBuilderAddConnection = function(identifier, virtualUnitId1, virtualUnitId2, connector1, connector2, wire)
		if not global.state.extBuildingStrs[identifier] then
			error("Str builder with this identifier is not in progress")
		end
		global.state.extBuildingStrs[identifier]:AddConnection(virtualUnitId1, virtualUnitId2, connector1, connector2, wire)
	end,
	
	strBuilderCompileAndClose = function(identifier)
		if not global.state.extBuildingStrs[identifier] then
			error("Str builder with this identifier is not in progress")
		end
		global.state.extBuildingStrs[identifier]:RefineCustomBuild()
		local res = global.state.extBuildingStrs[identifier]:Build()
		global.state.extBuildingStrs[identifier] = nil
		return res
	end,
	
	strBuilderClose = function(identifier)
		global.state.extBuildingStrs[identifier] = nil
	end,
	
	-- Change layout: rebuild combinator, str obtained via GetBuildString remote callback
	changeLayout = function(combinatorId)
		return Func:ChangeLayout(combinatorId)
	end,
	
	-- Get combinator component unit id
	-- Any changes to component will be lost on blueprinting, entity direction change, changeLayout... before call to refreshDataSlots
	getComponentEntityId = function(combinatorId, componentId)
		return Func:GetComponentData(combinatorId, componentId).componentEntity.unit_number
	end,
	
	getComponentPrototype = function(componentOrArchetypeName)
		return global.modCfg.componentPrototypes[componentOrArchetypeName] or global.modCfg.componentPrototypesByComponentName[componentOrArchetypeName]
	end,
	
	refreshDataStorageSlots = function(combinatorId)
		return Func:RefreshDataStorageSlots(combinatorId)
	end,
})

--- #endregion


--- #region External calls

Remote = {}
Remote.__index = Remote

function Remote:ComponentToString(entityDataDesc, entity)
	return remote.call(entityDataDesc.entityToStringRemote.interface, entityDataDesc.entityToStringRemote.method, entity)
end

function Remote:ComponentStringToDataSlots(entityDataDesc, componentDataStr)
	local localDataSlots = { }
	remote.call(entityDataDesc.stringToDataSlotsRemote.interface, entityDataDesc.stringToDataSlotsRemote.method, componentDataStr, localDataSlots)
	return localDataSlots
end

function Remote:OnCombinatorSpawned(entityDataDesc, entity, dataSlots, nextSlot)
	return remote.call(entityDataDesc.spawnedRemote.interface, entityDataDesc.spawnedRemote.method, entity, dataSlots, nextSlot)
end

function Remote:GetBuildString(combinatorDataDesc, entity)
	return remote.call(combinatorDataDesc.callbacksRemote, combinatorDataDesc.callbacksRemotePrefix.."GetBuildString", entity)
end

function Remote:SaveStateInfoToSlots(combinatorDataDesc, combinator)
	return remote.call(combinatorDataDesc.callbacksRemote, combinatorDataDesc.callbacksRemotePrefix.."SaveStateInfoToSlots", combinator)
end

function Remote:RestoreStateInfoFromSlots(combinatorDataDesc, combinator, slots, nextSlot)
	return remote.call(combinatorDataDesc.callbacksRemote, combinatorDataDesc.callbacksRemotePrefix.."RestoreStateInfoFromSlots", combinator, slots, nextSlot)
end

--- #endregion


--- #region Add vanilla conbinators as components

-- Interface for callbacks from Composite-Combinators-Core
remote.add_interface("Composite-Combinators-Base", { 
	IOMarkerSerialize 				= function (...) return ComponentsRegistration:IOMarkerSerialize						(...) end,
	IOMarkerConvert 				= function (...) return ComponentsRegistration:IOMarkerConvert							(...) end,
	IOMarkerSpawn 					= function (...) return ComponentsRegistration:IOMarkerSpawn							(...) end,
	ConstantCombinatorSerialize 	= function (...) return ComponentsRegistration:ConstantCombinatorSerialize				(...) end,
	ConstantCombinatorConvert 		= function (...) return ComponentsRegistration:ConstantCombinatorConvert				(...) end,
	ConstantCombinatorSpawned 		= function (...) return ComponentsRegistration:ConstantCombinatorSpawned				(...) end,
	ArithmeticCombinatorSerialize 	= function (...) return ComponentsRegistration:ArithmeticCombinatorSerialize			(...) end,
	ArithmeticCombinatorConvert 	= function (...) return ComponentsRegistration:ArithmeticCombinatorConvert				(...) end,
	ArithmeticCombinatorSpawned 	= function (...) return ComponentsRegistration:ArithmeticCombinatorSpawned				(...) end,
	DeciderCombinatorSerialize 		= function (...) return ComponentsRegistration:DeciderCombinatorSerialize				(...) end,
	DeciderCombinatorConvert 		= function (...) return ComponentsRegistration:DeciderCombinatorConvert					(...) end,
	DeciderCombinatorSpawned 		= function (...) return ComponentsRegistration:DeciderCombinatorSpawned					(...) end,
	
	-- Additional but necessary, if any other combinator will be implemented by any other mod - it is up to them
	IOMarkerBuildString				= function (...) return ComponentsRegistration:IOCombinatorBuildString					(...) end,
	DeciderCombinatorBuildString	= function (...) return ComponentsRegistration:DeciderCombinatorBuildString				(...) end,
	ArithmeticCombinatorBuildString = function (...) return ComponentsRegistration:ArithmeticCombinatorBuildString			(...) end,
	ConstantCombinatorBuildString	= function (...) return ComponentsRegistration:ConstantCombinatorBuildString			(...) end,
})

RegisterServiceComponents = function()
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "composite-combinator-io-marker", "io", 
		{
			defines.circuit_connector_id.constant_combinator 
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "IOMarkerSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "IOMarkerConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "IOMarkerSpawn"
		}
	)
end

RegisterVanillaComponents = function()
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "constant-combinator", "composite-combinator-constant-component", 
		{ 
			defines.circuit_connector_id.constant_combinator 
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "ConstantCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ConstantCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ConstantCombinatorSpawned"
		}
	)
	
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "arithmetic-combinator", "composite-combinator-arithmetic-component", 
		{ 
			defines.circuit_connector_id.combinator_input,
			defines.circuit_connector_id.combinator_output
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "ArithmeticCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ArithmeticCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ArithmeticCombinatorSpawned"
		}
	)

	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "decider-combinator", "composite-combinator-decider-component", 
		{ 
			defines.circuit_connector_id.combinator_input,
			defines.circuit_connector_id.combinator_output
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "DeciderCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "DeciderCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "DeciderCombinatorSpawned"
		}
	)

end

--- #endregion


