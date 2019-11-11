--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- funcmain.lua 
-- Purpose: 
	Very Core logic;
]]--

local coreConst = {
	strBoundary1 = '#',
	strBoundary2 = '%',
	strBoundary3 = '$',
	specialSignal = { type = "virtual", name = "signal-composite-combinators-core-technical" },
	debugMode = false
}

FuncMain = {}
FuncMain.__index = FuncMain

local function GetComponentDataDesc(entityName, fromComponents)
	if fromComponents then
		return global.modCfg.componentPrototypesByComponentName[entityName]
	else
		return global.modCfg.componentPrototypes[entityName]
	end
end

local function EntityOrComponentToSignal_Int(entity, fromComponents)
	if fromComponents then
		local entityName = entity.name
		for _,dd in pairs(global.modCfg.componentPrototypes) do
			if dd.componentEntityName == entityName then
				return EntityNameToSignal(dd.archetypeEntityName)
			end
		end
	else
		return EntityNameToSignal(entity.name)
	end
end

local function EntityOrComponentToSignal(entity, fromComponents)
	local signal = EntityOrComponentToSignal_Int(entity, fromComponents)
	
	if signal.type == 'item-with-tags' then
		signal.type = 'item'
	end
	
	return signal
end


----------------------------------------------------------------------------------------------------------------------------------
-- Flow:
-- Entities -> String
-- Application is various: on development, on blueprinting, on something else...
----------------------------------------------------------------------------------------------------------------------------------

StrBuilder = {}
StrBuilder.__index = StrBuilder

function StrBuilder:new()
   local struct = {}
   setmetatable(struct, StrBuilder)
   struct.prototypeName = nil
   struct.fromComponents = nil
   struct.components = { }
   struct.connections = { }
   return struct
end

function StrBuilder:AddComponent(prototypeName, position, direction, componentString, virtualUnitId)
	table.insert(self.components, {
		name = prototypeName,
		position = position,
		direction = direction,
		componentString = componentString,
		virtualUnitId = virtualUnitId
	})
end

function StrBuilder:AddConnection(virtualUnitId1, virtualUnitId2, connector1, connector2, wire)
	table.insert(self.connections, {
		virtualUnitId1 = virtualUnitId1,
		virtualUnitId2 = virtualUnitId2,
		connector1 = connector1,
		connector2 = connector2,
		wire = wire
	})
end

--[[
	Error codes:
		3 No entities
		-5 Unknown entity
		-10 Too big area selected (exceeded maxComponentsArchetypesAreaSize)
		-14 Invalid characters in component str (see coreConst)
		-19 exceeded maxComponentStringDataLength
		-26 Some kind of an error
		-29 exceeded maxComponents
		-44 exceeded maxComponentConnections
		
	Operating modes:
		1: Archetype  - fromComponents == false, combinator is null 					- get string from construction area with archetypes and io markers
		2: Components - fromComponents == true, combinator is composite combinator 		- get string from composite combinator and it's components
		
	TODO: strings taken each way should be 100% equal, currently different in connections block
	Length should be always equal
--]]


function StrBuilder:RefineCustomBuild()
	-- Add io markers, replace connections with zero entity id
	
	local ioMarkerDesc = GetComponentDataDesc("composite-combinator-io-marker", false)
	local createdIoMarkers = { }
	
	local total = 1
	for _, __ in pairs(self.components) do
		total = total + 1
	end
	
	local currentIoMarkerId = total
	for __,ccDef in pairs(self.connections) do
		if ccDef.virtualUnitId1 == 0 or ccDef.virtualUnitId2 == 0 then
			local isFirst = ccDef.virtualUnitId1 == 0
			local combinatorConnectorId = isFirst and ccDef.connector1 or ccDef.connector2
			
			if not createdIoMarkers[combinatorConnectorId] then
				local componentDataStr = ComponentsRegistration:IOMarkerSerializeSub(combinatorConnectorId)
				self:AddComponent(
					"composite-combinator-io-marker", 
					{ x = 0, y = 0 }, 
					0,
					componentDataStr, 
					currentIoMarkerId
				)
				createdIoMarkers[combinatorConnectorId] = currentIoMarkerId
				currentIoMarkerId = currentIoMarkerId + 1
			end
			
			if isFirst then
				ccDef.connector1 = 1
				ccDef.virtualUnitId1 = createdIoMarkers[combinatorConnectorId]
			else
				ccDef.connector2 = 1
				ccDef.virtualUnitId2 = createdIoMarkers[combinatorConnectorId]
			end
		end
	end
end

function StrBuilder:Fill(combinator, components, fromComponents)
	local combinatorEntityState = fromComponents and global.state.combinatorEntities[combinator.unit_number] or nil
	
	self.prototypeName = fromComponents and combinator.name or nil
	self.fromComponents = fromComponents
	
	local xmin = 2147483647
	local ymin = 2147483647
	
	for _,entity in pairs(components) do 
		entityDataDesc = GetComponentDataDesc(entity.name, fromComponents)
		
		if entityDataDesc == nil then
			return -5
		end
		
		if entity.position.x < xmin then
			xmin = entity.position.x
		end
		if entity.position.y < ymin then
			ymin = entity.position.y
		end
	end
	
	local nextVirtualEntId = 1
	local entIdToVirtualEntId = { }
	
	local redirectConnectionsConnectorIdToIOMarker = { }
	
	-- fake dem io markers - Build() does not work with connections of components to combinator entity 
	-- serialize composite combinator connectors as io markers
	if fromComponents then
		local connectionDefinitions = combinator.circuit_connection_definitions
		
		entityDataDesc = GetComponentDataDesc("composite-combinator-io-marker", false)
		
		for __,ccDef in pairs(connectionDefinitions) do
			if not redirectConnectionsConnectorIdToIOMarker[ccDef.target_circuit_id] then
				local componentDataStr = ComponentsRegistration:IOMarkerSerializeSub(ccDef.target_circuit_id)

				self:AddComponent(
					"composite-combinator-io-marker", 
					{ x = 0, y = 0 }, 
					0,
					componentDataStr, 
					nextVirtualEntId
				)
				
				redirectConnectionsConnectorIdToIOMarker[ccDef.target_circuit_id] = nextVirtualEntId
				entIdToVirtualEntId[entity.unit_number] = nextVirtualEntId
				nextVirtualEntId = nextVirtualEntId + 1
			end
		end
	end
	
	for _,entity in pairs(components) do 
		entityDataDesc = GetComponentDataDesc(entity.name, fromComponents)
		
		local pos = { }
		local dir
		
		if fromComponents then
			pos.x = combinatorEntityState.components[entity.unit_number].origPos.x
			pos.y = combinatorEntityState.components[entity.unit_number].origPos.y
			dir = combinatorEntityState.components[entity.unit_number].origPos.dir
		elseif entity.name == "composite-combinator-io-marker" then
			pos.x = 0 -- for the sake of equality of result for both operating modes
			pos.y = 0
			dir = 0
		else
			pos.x = entity.position.x-xmin
			pos.y = entity.position.y-ymin
			dir = entity.direction
		end
		
		self:AddComponent(
			entity.name, 
			pos, 
			dir,
			Remote:ComponentToString(entityDataDesc, entity), 
			nextVirtualEntId
		)
		
		entIdToVirtualEntId[entity.unit_number] = nextVirtualEntId
		nextVirtualEntId = nextVirtualEntId + 1
	end
	
	local connected = { }
	
	for _,entity in pairs(components) do 
		local connectionDefinitions = entity.circuit_connection_definitions
		
		for __,ccDef in pairs(connectionDefinitions) do
			local ent1id = entIdToVirtualEntId[entity.unit_number]
			local ent1circuitId = ccDef.source_circuit_id
			local ent2id
			local ent2circuitId
			if fromComponents and ccDef.target_entity.unit_number == combinator.unit_number then
				-- redirect connection from combinator to io marker
				ent2id = redirectConnectionsConnectorIdToIOMarker[ccDef.target_circuit_id]
				ent2circuitId = 1
			else
				ent2id = entIdToVirtualEntId[ccDef.target_entity.unit_number]
				ent2circuitId = ccDef.target_circuit_id
			end

			if not connected[ent2id..' '..ent1id] then
			
				self:AddConnection(
					ent1id,
					ent2id,
					ent1circuitId,
					ent2circuitId,
					ccDef.wire
				)
			
				connected[ent1id..' '..ent2id] = true
			end
		end
	end
end

function FuncMain:GetComponentsStringFromEntities_Int(combinator, components, fromComponents)
	local bdr = StrBuilder:new()
	
	-- Create str build info
	bdr:Fill(combinator, components, fromComponents)
	
	-- Create str from build info; at Build() no access to real entities is performed
	return bdr:Build()
end

function StrBuilder:Build()
	local signal
	local str = ''
	
	-- get topLeft pos, geather strings
	
	local stringsDict = { }
	local stringsDictIndex = 1
	
	if not self.components[1] then
		return 3
	end
	
	stringsDict["item"] = stringsDictIndex
	stringsDictIndex = stringsDictIndex + 1
	str = str.."item"..(coreConst.strBoundary1)
	
	stringsDict["composite-combinator-io-marker"] = stringsDictIndex
	stringsDictIndex = stringsDictIndex + 1
	str = str.."composite-combinator-io-marker"..(coreConst.strBoundary1)
	
	local orderedComponents = self.components
	
	--[[for _,entity in pairs(self.components) do 
		if entity.name == "composite-combinator-io-marker" then
			table.insert(orderedComponents, entity)
		end
	end
	
	for _,entity in pairs(self.components) do 
		if entity.name ~= "composite-combinator-io-marker" then
			table.insert(orderedComponents, entity)
		end
	end]]--
	
	local entityDataDesc
	
	local xmin = 2147483647
	local ymin = 2147483647
	
	-- put some strings in dict
	for _,entity in pairs(orderedComponents) do 
		entityDataDesc = GetComponentDataDesc(entity.name, self.fromComponents)
		
		if entityDataDesc == nil then
			return -5
		end
		
		if entity.position.x < xmin then
			xmin = entity.position.x
		end
		if entity.position.y < ymin then
			ymin = entity.position.y
		end
		
		signal = EntityOrComponentToSignal(entity, self.fromComponents)
		
		if not stringsDict[signal.type] then
			stringsDict[signal.type] = stringsDictIndex
			stringsDictIndex = stringsDictIndex + 1
			str = str..signal.type..(coreConst.strBoundary1)
		end
		if not stringsDict[signal.name] then
			stringsDict[signal.name] = stringsDictIndex
			stringsDictIndex = stringsDictIndex + 1
			str = str..signal.name..(coreConst.strBoundary1)
		end
	end
	
	str = str..(coreConst.strBoundary3)
	
	-- serialize components entities
	for _,entity in pairs(orderedComponents) do 
		entityDataDesc = GetComponentDataDesc(entity.name, fromComponents)
		
		signal = EntityOrComponentToSignal(entity, fromComponents)
		
		if entity.position.x >= limits.maxComponentsArchetypesAreaSize or entity.position.y >= limits.maxComponentsArchetypesAreaSize or 
			(entity.position.x-xmin) >= limits.maxComponentsArchetypesAreaSize or (entity.position.y-ymin) >= limits.maxComponentsArchetypesAreaSize then
			return -10
		end
		
		-- componentDataStr may vary
		local componentDataStrLen = string.len(entity.componentString)
		
		if (string.find(entity.componentString, coreConst.strBoundary1, 1, true)) or
			(string.find(entity.componentString, coreConst.strBoundary2, 1, true)) or 
			(string.find(entity.componentString, coreConst.strBoundary3, 1, true)) then
			return -14
		end
		
		if componentDataStrLen > limits.maxComponentStringDataLength or componentDataStrLen < 1 then
			return -19
		end
		
		str = str..(stringsDict[signal.type])..(coreConst.strBoundary1)..(stringsDict[signal.name])..(coreConst.strBoundary1)..componentDataStrLen..(coreConst.strBoundary1)
		str = str..entity.position.x..(coreConst.strBoundary1)..entity.position.y..(coreConst.strBoundary1)..entity.direction..(coreConst.strBoundary1)..entity.componentString..(coreConst.strBoundary2)
	end

	str = str..(coreConst.strBoundary3)

	local nextConnection = 1
	
	-- serialize connections
	for _,ccDef in pairs(self.connections) do 
		local ent1id = ccDef.virtualUnitId1
		local ent2id = ccDef.virtualUnitId2

		if not ent1id or not ent2id then
			return -26
		end

		if ent1id >= limits.maxComponents or ent2id >= limits.maxComponents then
			return -29
		end
		
		str = str..((ccDef.wire == defines.wire_type.red and "01") or "00")..(coreConst.strBoundary1)
		str = str..ent1id..(coreConst.strBoundary1)..ent2id..(coreConst.strBoundary1)
		str = str..ccDef.connector1..(coreConst.strBoundary1)..ccDef.connector2..(coreConst.strBoundary1)
		str = str..(coreConst.strBoundary2)
		
		nextConnection = nextConnection + 1
	end
	
	if nextConnection > limits.maxComponentConnections then
		return -44
	end
	
	return str
end

----------------------------------------------------------------------------------------------------------------------------------
-- Flow:
-- String -> Data Slots
-- Data Slots are less compressed than String
-- Registered Component Combinators have componentString that can be used when combinator is placed
-- Blocks: entities, connections
----------------------------------------------------------------------------------------------------------------------------------

function FuncMain:StringToDataSlots_Int(str)
	local dataSlots = { }
	local nextSlot = 1
	local nextEntId = 1
	
	local spl = split3(str, coreConst.strBoundary3)
	local dictSrc = spl[1]
	local components = spl[2]
	local connections = spl[3]
	
	spl = split3(dictSrc, coreConst.strBoundary1)
	
	local stringsDict = { }
	local stringsDictIndex = 1
	
	-- get strings from dict
	for _,node in pairs(spl) do 
		stringsDict[stringsDictIndex] = node
		stringsDictIndex = stringsDictIndex + 1
	end
	
	-- convert entities components
	spl = split3(components, coreConst.strBoundary2)
	
	local entityNumber = 1
	
	for _,node in pairs(spl) do 
		local entitySpl = split3(node, coreConst.strBoundary1)
		if not entitySpl[1] then break end
		local signalType = stringsDict[tonumber(entitySpl[1])]
		local signalName = stringsDict[tonumber(entitySpl[2])]
		local dataLen = entitySpl[3]
		local entPosX = tonumber(entitySpl[4])
		local entPosY = tonumber(entitySpl[5])
		local entDir = tonumber(entitySpl[6])
		local componentDataStr = entitySpl[7]
		
		dataSlots[nextSlot] = { signal = { type = signalType, name = signalName }, count = 37, index = nextSlot }
		nextSlot = nextSlot + 1
			
		dataSlots[nextSlot] = { 
			signal = coreConst.specialSignal, 
			count = math.floor(entPosX) + bit32.lshift(math.floor(entPosY), 8) + bit32.lshift(entDir, 16), 
			index = nextSlot
		}
		nextSlot = nextSlot + 1
		
		local entityDataDesc = global.modCfg.componentPrototypes[signalName]
		local localDataSlots = Remote:ComponentStringToDataSlots(entityDataDesc, componentDataStr)
		
		local localNextSlot = 1
		for _,slot in pairs(localDataSlots) do
			dataSlots[nextSlot] = slot
			if slot.signal.type == coreConst.specialSignal.type and slot.signal.name == coreConst.specialSignal.name then
				error("Composite-Combinators-Core::StringToDataSlots failed: dataSlots cannot contain "..coreConst.specialSignal.name)
			end
			if not slot.signal.type or not slot.signal.name or not slot.count or not slot.index then
				error("Composite-Combinators-Core::StringToDataSlots failed: invalid dataSlots from "..signalName)
			end
			nextSlot = nextSlot + 1
			localNextSlot = localNextSlot + 1
		end
		
		if localNextSlot > limits.maxComponentDataSlotsLength then
			error("Composite-Combinators-Core::StringToDataSlots failed: limits.maxComponentDataSlotsLength exceeded")
		end
		
		entityNumber = entityNumber + 1
	end
	
	if entityNumber > limits.maxDataSlotsInCompositeCombinator then
		error("Composite-Combinators-Core::StringToDataSlots failed: limits.maxDataSlotsInCompositeCombinator exceeded")
	end
	
	-- boundary
	dataSlots[nextSlot] = { signal = coreConst.specialSignal, count = -9, index = nextSlot }
	nextSlot = nextSlot + 1
	
	-- convert connections
	local nextConnection = 0
	
	spl = split3(connections, coreConst.strBoundary2)

	for _,node in pairs(spl) do 
		local connectionSpl = split3(node, coreConst.strBoundary1)
				
		local wireType = connectionSpl[1]
		if wireType == nil then
			break
		end
		local ent1Id = tonumber(connectionSpl[2])
		local ent2Id = tonumber(connectionSpl[3])
		local connection1Id = tonumber(connectionSpl[4])
		local connection2Id = tonumber(connectionSpl[5])
		
		if ent1Id >= limits.maxComponents or ent2Id >= limits.maxComponents then
			error("Composite-Combinators-Core::StringToDataSlots failed: maxComponents exceeded")
		end

		dataSlots[nextSlot] = { 
			signal = { 
				type = "item", 
				name = wireType == "01" and "red-wire" or "green-wire"
			}, 
			count = (ent1Id + bit32.lshift(ent2Id, 16)),
			index = nextSlot
		}
		nextSlot = nextSlot + 1
	
		dataSlots[nextSlot] = { 
			signal = { 
				type = "item", 
				name = "wood"
			}, 
			count = (connection1Id + bit32.lshift(connection2Id, 16)),
			index = nextSlot
		}

		nextSlot = nextSlot + 1

		nextConnection = nextConnection + 1
	end
	
	if nextConnection >= limits.maxComponentConnections then
		error("Composite-Combinators-Core::StringToDataSlots failed: limits.maxComponentConnections exceeded")
	end
	
	-- boundary
	dataSlots[nextSlot] = { signal = coreConst.specialSignal, count = -10, index = nextSlot }
	nextSlot = nextSlot + 1
	
	if nextSlot >= limits.maxDataSlotsInCompositeCombinator then
		error("Composite-Combinators-Core::StringToDataSlots failed: limits.maxDataSlotsInCompositeCombinator exceeded")
	end
	
	-- TODO: checksum
	
	return { dataSlots = dataSlots, nextSlot = nextSlot }
end


----------------------------------------------------------------------------------------------------------------------------------
-- Flow:
-- Placed Combinator entity + DataSlots in argument -> Place and connect inner Components

-- No Limits checks in this piece of code - assuming I have peace with myself and community
----------------------------------------------------------------------------------------------------------------------------------

-- Warning: enhanced 3d thiking was applied here
function FuncMain:SpawnCompositeCombinatorComponents_Int(combinator, dataSlots2)
	local surface = combinator.surface
	local combinatorDataDesc = global.modCfg.combinatorPrototypes[combinator.prototype.name]
	
	local combinatorEntityState = { 
		built = true,
		deletingComponents = false,
		components = { },
		entity = combinator
	}
	
	local srcX
	local srcY
	local origX
	local origY
	local origDir

	local logicAreaPositionMultiplier = {
		x = coreConst.debugMode and 2 or 1.0/combinatorDataDesc.compressionRatio,
		y = coreConst.debugMode and 2 or 1.0/combinatorDataDesc.compressionRatio
	}
	
	local dir = combinator.direction
	local isForwardDir = dir == 2 or dir == 4	 -- if not, build beginning from the opposite site 
	local isSwitchingDim = dir == 4 or dir == 0  -- switch x and y
	
	local baseCoordinate
	
	if isForwardDir then
		if not isSwitchingDim then
			srcX = combinatorDataDesc.componentsTopLeftOffset.x - (combinatorDataDesc.combinatorWidth/2.0)
			srcY = combinatorDataDesc.componentsTopLeftOffset.y - (combinatorDataDesc.combinatorHeight/2.0)
		else
			srcX = -combinatorDataDesc.componentsTopLeftOffset.y + (combinatorDataDesc.combinatorHeight/2.0)
			srcY = combinatorDataDesc.componentsTopLeftOffset.x - (combinatorDataDesc.combinatorWidth/2.0)
		end
	else
		if not isSwitchingDim then
			srcX = -combinatorDataDesc.componentsTopLeftOffset.x + (combinatorDataDesc.combinatorWidth/2.0)
			srcY = -combinatorDataDesc.componentsTopLeftOffset.y + (combinatorDataDesc.combinatorHeight/2.0)
		else
			srcX = combinatorDataDesc.componentsTopLeftOffset.y - (combinatorDataDesc.combinatorHeight/2.0) -- meh
			srcY = -combinatorDataDesc.componentsTopLeftOffset.x + (combinatorDataDesc.combinatorWidth/2.0)
		end
	end
	
	baseCoordinate = {
		x = combinator.position.x + srcX,
		y = combinator.position.y + srcY
	}
	
	-- internal data structure to newly created entity ids
	local entIdToEnt = { }
	local nextEntId = 1
		
	local nextEntityPrototype = nil
	
	local dataSlots = dataSlots2.dataSlots -- yeah
	local nextSlot = 1
	
	local outConnections = { }
	local ioMarkerIds = { }

	-- place components
	while true do
		local dataSlot = dataSlots[nextSlot]
		nextSlot = nextSlot + 1
		
		if dataSlot.count == -9 and dataSlot.signal.name == coreConst.specialSignal.name then
			-- Done here, make connections next
			break
		end

		nextEntityPrototype = SignalToEntityPrototype(dataSlot.signal.type, dataSlot.signal.name)

		dataSlot = dataSlots[nextSlot]
		nextSlot = nextSlot + 1

		local entityDataDesc = global.modCfg.componentPrototypes[nextEntityPrototype.name]

		if nextEntityPrototype.name == 'composite-combinator-io-marker' then
			dataSlot = dataSlots[nextSlot]
			nextSlot = nextSlot + 1
			
			outConnections[nextEntId] = {
				num = dataSlot.count
			}
			
			if ioMarkerIds[dataSlot.count] then
				error("IO markers with the same ids")
			end
			
			ioMarkerIds[dataSlot.count] = true
			
			entIdToEnt[nextEntId] = nil
			nextEntId = nextEntId + 1
			
		else
			origX = bit32.band(dataSlot.count, 0xFF)
			origY = bit32.band(bit32.rshift(dataSlot.count, 8), 0xFF)
			
			srcX = origX*logicAreaPositionMultiplier.x
			srcY = origY*logicAreaPositionMultiplier.y
			
			if isSwitchingDim then
				local t = srcX
				srcX = srcY
				srcY = t
			end
			
			--if not coreConst.debugMode and combinatorDataDesc.combinatorWidth < srcX or srcX < 0 then
			--	error("Component is out of bounds (X)")
			--end
			--if not coreConst.debugMode and combinatorDataDesc.combinatorHeight < srcY or srcY < 0 then
			--	error("Component is out of bounds (Y)")
			--end
			
			if isForwardDir then
				if not isSwitchingDim then
					srcX = baseCoordinate.x + srcX 
				else
					srcX = baseCoordinate.x - srcX
				end

				srcY = baseCoordinate.y + srcY
			else
				if not isSwitchingDim then
					srcX = baseCoordinate.x - srcX
				else
					srcX = baseCoordinate.x + srcX
				end
				
				srcY = baseCoordinate.y - srcY -- y tho
			end

			origDir = bit32.band(bit32.rshift(dataSlot.count, 16), 0xF)
			
			local curEntitiy = surface.create_entity({
				name = entityDataDesc.componentEntityName,
				position = {
					x = srcX,
					y = srcY
				},
				direction = origDir,
				force = combinator.force,
			})
			
			nextSlot = Remote:OnCombinatorSpawned(entityDataDesc, curEntitiy, dataSlots, nextSlot)
			
			entIdToEnt[nextEntId] = curEntitiy
			nextEntId = nextEntId + 1
			
			combinatorEntityState.components[curEntitiy.unit_number] = {
				componentEntity = curEntitiy,
				origPos = {
					x = origX,
					y = origY,
					dir = origDir
				}
			}
		end
		
	end
	
	-- make connections
	while true do
		local dataSlot = dataSlots[nextSlot]
		nextSlot = nextSlot + 1
		
		if dataSlot.count == -10 and dataSlot.signal.name == coreConst.specialSignal.name then
			break
		end
		
		local entIds = dataSlot.count	
		local ent1Id = tonumber(bit32.band(entIds, 0xFFFF))
		local ent2Id = tonumber(bit32.band(bit32.rshift(entIds, 16), 0xFFFF))

		local wireType = dataSlot.signal.name
		
		dataSlot = dataSlots[nextSlot]
		nextSlot = nextSlot + 1
		
		local connectionIds = dataSlot.count
		local connection1Id = tonumber(bit32.band(connectionIds, 0xFFFF))
		local connection2Id = tonumber(bit32.band(bit32.rshift(connectionIds, 16), 0xFFFF))
		
		local entity1 = entIdToEnt[ent1Id]
		local entity2 = entIdToEnt[ent2Id]
		
		if entity1 == nil then -- assuming not spawned 'composite-combinator-io-marker'
			-- connect components to composite combinator input or output
			entity1 = combinator
			connection1Id = outConnections[ent1Id].num
		end
		if entity2 == nil then 
			entity2 = combinator
			connection2Id = outConnections[ent2Id].num
		end
		
		entity1.connect_neighbour({
			wire = wireType == "red-wire" and defines.wire_type.red or defines.wire_type.green,
			target_entity = entity2,
			source_circuit_id = connection1Id,
			target_circuit_id = connection2Id
		})
		
	end
	
	-- Spawn construction data constant combinator with dataSlots to have this build information for blueprinting, etc...
	
	local dataSlotsStorage = surface.create_entity({
		name = "composite-combinator-construction-data",
		position = combinator.position,
		direction = defines.direction.north,
		force = combinator.force,
	})
	combinatorEntityState.dataSlotsStorage = dataSlotsStorage
	
	local beh = dataSlotsStorage.get_control_behavior()
	
	beh.enabled = true
	
	nextSlot = 1

	local params = { }
	while true do 
		if not dataSlots[nextSlot] then
			break
		end
		dataSlots[nextSlot].index = nextSlot -- we didn't care about index up to this point; has to be in sequence
		table.insert(params, dataSlots[nextSlot])
		nextSlot = nextSlot + 1
	end
	beh.parameters = {parameters = params} 

	global.state.combinatorEntities[combinator.unit_number] = combinatorEntityState

	-- Done!
end