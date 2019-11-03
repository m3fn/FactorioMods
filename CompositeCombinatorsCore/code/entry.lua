--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- entry.lua 
-- Purpose:
	Mod config, mod init;
	Core remote interface (API);
	Base things - Add vanilla conbinators as components (using component part of that API);
]]--

limits = {
	-- Random Limitations
	-- Changes to some values can corrupt existing entities and blueprints
	maxDataSlotsInCompositeCombinator = 8192,	-- Do not make data too fat, also a value in composite-combinator-construction-data 	(may be a subject for extending)
	maxComponentStringDataLength = 8192*4,		 -- Do not make data too fat
	maxComponentDataSlotsLength = 1666,			 -- 																					(may be a subject for extending)
	maxCombinatorPrototypeWidthOrHeight = 64,	--
	maxComponents = 65535,					   -- to fit two values in 32 bit
	maxComponentConnections = 65535,			 -- TODO check
	minCompressionRatio = 2,
	maxCompressionRatio = 8,					 -- just because
	maxInputsAndOutputsTotal = 32,			   -- just because, mby factorio supports less
	maxComponentsBigSize = 255,					 -- to fit in, also enough
}

--- #region: Init / Deinit; Events

function OnInit()
	global.modCfg = { 
		combinatorPrototypes = { },
		componentsDataDesc = { },
		componentsDataDescByComponentName = { }
	}
	
	global.state = {
		ioEntStates = { },
		players = { },
		combinatorEntities = { },
		waitingForUnghosting = { },
		tickTasks = { },
		tasksCount = 0
	}
	
	global.hasTasks = false
	
	RegisterServiceComponents()
	RegisterVanillaComponents()
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

	registerCompositeCombinatorPrototype = function(entityName, compressionRatio, componentsTopLeftOffset, componentsStrings, callbacksRemote)
	
		if compressionRatio > limits.maxCompressionRatio or compressionRatio < limits.minCompressionRatio then
			error("Remote call to Composite-Combinators-Core::registerCompositeCombinatorPrototype failed: compression ratio exceeds limitations")
		end
	
		local sizes = game.entity_prototypes[entityName].selection_box
		local height = sizes.right_bottom.x - sizes.left_top.x -- this is not mistake, I feel more comfortable with south direction as basic
		local width = sizes.right_bottom.y - sizes.left_top.y

		if width > limits.maxCombinatorPrototypeWidthOrHeight or height > limits.maxCombinatorPrototypeWidthOrHeight then
			error("Remote call to Composite-Combinators-Core::registerCompositeCombinatorPrototype failed: entity size exceeds limitations")
		end

		global.modCfg.combinatorPrototypes[entityName] = { 
			name = entityName,
			compressionRatio = compressionRatio,
			combinatorWidth = width,
			combinatorHeight = height,
			componentsTopLeftOffset = componentsTopLeftOffset,
			componentsStrings = componentsStrings,
			callbacksRemote = callbacksRemote
		}

	end,
	
	-- In case of whatever inter-modding contexts;

	deletCompositeCombinatorPrototype = function (entityName)
		global.modCfg.logicCellPrototypes[entityName] = nil
	end,
	
	-- Components

	registerComponentPrototype = function(bigEntityName, componentEntityName, connectorIds, entityToStringRemote, stringToDataSlotsRemote, spawnedRemote)
		if bigEntityName == "" or bigEntityName == nil then
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
			bigEntityName = bigEntityName,
			componentEntityName = componentEntityName,
			connectorIds = connectorIds,
			entityToStringRemote = entityToStringRemote,
			stringToDataSlotsRemote = stringToDataSlotsRemote,
			spawnedRemote = spawnedRemote
		}
				
		global.modCfg.componentsDataDesc[bigEntityName] = componentDataDesc
		global.modCfg.componentsDataDescByComponentName[componentEntityName] = componentDataDesc
	end,
	
	-- deletComponentPrototype does not make sense to me
	
	-- Live editing: build components str with
	
	beginBuildComponents = function(identifier)
		error('not implemented')
	end,
	
	
	
	
	
	-- Live editing: change layout: choose one of predefined strs
	
	changeLayout = function(entityId, strId)
		return ChangeLayout(entityId, strId)
	end,
	
	-- Live editing: get combinator component to do something with programmatically
	
	getComponentEntityId = function(entityId, componentId)
		return GetComponent(entityId, componentId).componentEntity.unit_number
	end,
	
	getComponentPrototype = function(name)
		return global.modCfg.componentsDataDesc[name] or global.modCfg.componentsDataDescByComponentName[name]
	end
})

--- #endregion


--- #region Add vanilla conbinators as components


-- Interface for callbacks from Composite-Combinators-Core
remote.add_interface("Composite-Combinators-Base", { 

	--[[
		IO marker.
		Not actually built as a component, but writes to string where to connect inputs and outputs, handled in func.lua
	]]

	ioMarkerSerialize = function(entity)
		if entity == nil then
			return nil
		end
		
		local entityId = entity.unit_number
		local dataDesc = global.state.ioEntStates[entityId] or { num = '1' }

		local str = ''..dataDesc.num
		return str
	end,
	
	ioMarkerConvert = function(str, slots)
		if slots == nil then
			return nil
		end
		
		local num = tonumber(str)
		
		local nextSlot = 1
		slots[nextSlot] = { signal = { type = 'item', name = 'composite-combinator-io-marker' }, count = num, index = nextSlot }
	end,
	
	ioMarkerSpawn = function (entity, slots, nextSlot)
		if entity == nil then
			return nil
		end
		error('Not supposed to be here')
	end,
	
	constantCombinatorSerialize = constantCombinatorSerialize,
	constantCombinatorConvert = constantCombinatorConvert,
	constantCombinatorSpawned = constantCombinatorSpawned,
	arithmeticCombinatorSerialize = arithmeticCombinatorSerialize,
	arithmeticCombinatorConvert = arithmeticCombinatorConvert,
	arithmeticCombinatorSpawned = arithmeticCombinatorSpawned,
	deciderCombinatorSerialize = deciderCombinatorSerialize,
	deciderCombinatorConvert = deciderCombinatorConvert,
	deciderCombinatorSpawned = deciderCombinatorSpawned,
})
 
function RegisterServiceComponents()
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "composite-combinator-io-marker", "io", 
		{
			defines.circuit_connector_id.constant_combinator 
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "ioMarkerSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ioMarkerConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "ioMarkerSpawn"
		}
	)
	
end

function RegisterVanillaComponents()
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "constant-combinator", "composite-combinator-constant-component", 
		{ 
			defines.circuit_connector_id.constant_combinator 
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "constantCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "constantCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "constantCombinatorSpawned"
		}
	)
	
	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "arithmetic-combinator", "composite-combinator-arithmetic-component", 
		{ 
			defines.circuit_connector_id.combinator_input,
			defines.circuit_connector_id.combinator_output
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "arithmeticCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "arithmeticCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "arithmeticCombinatorSpawned"
		}
	)

	remote.call("Composite-Combinators-Core", "registerComponentPrototype", "decider-combinator", "composite-combinator-decider-component", 
		{ 
			defines.circuit_connector_id.combinator_input,
			defines.circuit_connector_id.combinator_output
		}, 
		{
			interface = "Composite-Combinators-Base",
			method = "deciderCombinatorSerialize"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "deciderCombinatorConvert"
		},
		{
			interface = "Composite-Combinators-Base",
			method = "deciderCombinatorSpawned"
		}
	)

end

--- #endregion


