--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- components.lua 
-- Purpose:
	Add combinators as components (using component part the API)
	Add techincal components
]]--

ComponentsRegistration = {}
ComponentsRegistration.__index = ComponentsRegistration

local baseConst = {
	combinatorOperationToInt = { 
		[""] = 0, 
		["*"] = 1, ["/"] = 2, ["+"] = 3, ["-"] = 4, ["%"] = 5, ["^"] = 6, ["<<"] = 7, [">>"] = 8, ["AND"] = 9, ["OR"] = 10, ["XOR"] = 11,
	},
	intToCombinatorOperation = {
		["0"] = "", 
		["1"] = "*", ["2"] = "/", ["3"] = "+", ["4"] = "-", ["5"] = "%", ["6"] = "^", ["7"] = "<<", ["8"] = ">>", ["9"] = "AND", ["10"] = "OR", ["11"] = "XOR"
	},
	combinatorComparatorToInt = {
		[""] = 0,
		["<"] = 1, [">"] = 2, ["="] = 3, ["≥"] = 4, ["≤"] = 5, ["≠"] = 6
	},
	intToCombinatorComparator = {
		["0"] = "",
		["1"] = "<", ["2"] = ">", ["3"] = "=", ["4"] = "≥", ["5"] = "≤", ["6"] = "≠"
	},
	strBoundary1 = '@',
	strBoundary2 = '[',
	strBoundary3 = ']',
	strSpecial = '^',
	specialSignal = { type = "virtual", name = "signal-composite-combinators-base-technical" }
}

local function serializeSignal2B(signal)
	return (signal.signal.type or 'nil')..(baseConst.strBoundary1)..(signal.signal.name or 'nil')..(baseConst.strBoundary1)..(signal.count or 'nil')
end

local function serializeSignal1B(signal)
	return (signal.type or 'nil')..(baseConst.strBoundary1)..(signal.name or 'nil')
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Constant component
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- entity -> string 
function ComponentsRegistration:ConstantCombinatorSerialize(entity)
	if entity == nil then
		return nil
	end
	
	local beh = entity.get_control_behavior()
	
	local str = ((beh.enabled and 1) or 0)..(baseConst.strBoundary2)
	
	for _,signals in pairs(beh.parameters) do
		for _,signal in pairs(signals) do
			if signal.signal.name then
				str = str..serializeSignal2B(signal)..(baseConst.strBoundary2)
			end
		end
	end
	
	return str
end

-- string -> slots 
function ComponentsRegistration:ConstantCombinatorConvert(str, slots)
	if slots == nil then
		return nil
	end

	local count = 0
	-- convertArithmeticDeciderCommon(str, slots)

	local spl = split3(str, baseConst.strBoundary2)
	local enabled = tonumber(spl[1])

	spl[1] = nil

	for _,node in pairs(spl) do 
		count = count + 1
	end

	local signalType
	local signalName
	local signalCount

	count = bit32.lshift(count, 16) + enabled

	local nextSlot = 1
	slots[nextSlot] = { signal = baseConst.specialSignal, count = count, index = nextSlot }
	nextSlot = nextSlot + 1

	for _,node in pairs(spl) do 
		if node ~= nil then
			local subnodes = split3(node, baseConst.strBoundary1)
			signalType = subnodes[1]
			if not signalType then break end
			signalName = subnodes[2]
			if signalType == '' then
				enabled = subnodes[2]
				break
			end
			signalCount = subnodes[3]
			slots[nextSlot] = { signal = { type = signalType, name = signalName }, count = signalCount, index = nextSlot }
			nextSlot = nextSlot + 1
		end
	end
end

-- slots -> spawn
function ComponentsRegistration:ConstantCombinatorSpawned(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	
	local beh = entity.get_control_behavior()
	
	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		error('Coorrupted data')
	end
	
	local enabled = tonumber(bit32.band(slots[nextSlot].count, 0xFFFF))
	local count = tonumber(bit32.band(bit32.rshift(slots[nextSlot].count, 16), 0xFFFF))

	beh.enabled = enabled == 1 and true or false
	nextSlot = nextSlot + 1
	
	local i = 1

	local params = { }
	while i<count do 
		if slots[nextSlot].signal.name == baseConst.specialSignal.name then
			break
		end
		local ins = { count = tonumber(slots[nextSlot].count), index = i, signal = slots[nextSlot].signal }
		table.insert(params, ins)
		nextSlot = nextSlot + 1
		i = i + 1
	end
	beh.parameters = {parameters = params} 
	
	return nextSlot
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Arithmetic and decider components common code 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function serializeArithmeticDeciderCommon(params)
	local str
	
	if params.operation == nil then
		params.operation = ''
	end
	
	if params.parameters.first_signal then
		str = serializeSignal1B(params.parameters.first_signal)
	else
		str = baseConst.strSpecial..(baseConst.strBoundary1)..(params.parameters.first_constant or 0)
	end
	str = str..(baseConst.strBoundary1) 

	if params.parameters.second_signal then
		str = str..serializeSignal1B(params.parameters.second_signal)
	else
		str = str..baseConst.strSpecial..(baseConst.strBoundary1)..(params.parameters.constant or params.parameters.second_constant or 0)
	end
	str = str..(baseConst.strBoundary1)

	return str
end

local function substituteVerySpecialSignal(signalName)
	if signalName == 'signal-each' then signalName = "signal-composite-combinators-base-each" end
	if signalName == 'signal-everything' then signalName = "signal-composite-combinators-base-everything" end
	if signalName == 'signal-anything' then signalName = "signal-composite-combinators-base-anything" end
	return signalName
end

local function unsubstituteVerySpecialSignal(signalName)
	if signalName == 'signal-composite-combinators-base-each' then signalName = "signal-each" end
	if signalName == 'signal-composite-combinators-base-everything' then signalName = "signal-everything" end
	if signalName == 'signal-composite-combinators-base-anything' then signalName = "signal-anything" end
	return signalName
end

local function convertArithmeticDeciderCommon(str, slots)
	local nextSlot = 1
	
	local spl = split3(str, baseConst.strBoundary1)
	
	local signalType
	local signalName
	local signalCount
	
	local index = 1
	local rep = 1

	while rep <= 2 do
	
		signalType = spl[index]
		index = index + 1
		
		if signalType == baseConst.strSpecial then
			signalCount = 0+tonumber(spl[index])
			index = index + 1
			slots[nextSlot] = { signal = { type = baseConst.specialSignal.type, name = baseConst.specialSignal.name }, count = signalCount, index = nextSlot }
			nextSlot = nextSlot + 1
		else
			signalName = substituteVerySpecialSignal(spl[index])
			index = index + 1
			
			slots[nextSlot] = { signal = { type = signalType, name = signalName }, count = 0, index = nextSlot }
			nextSlot = nextSlot + 1
		end
	
		rep = rep + 1
	end
	
	signalType = spl[index]
	index = index + 1
		
	if signalType == baseConst.strSpecial then
		signalType = baseConst.specialSignal.type
		signalName = baseConst.specialSignal.name
	else
		signalName = substituteVerySpecialSignal(spl[index])
		index = index + 1
	end
	signalCount = spl[index]
	index = index + 1

	slots[nextSlot] = { signal = { type = signalType, name = signalName }, count = signalCount, index = nextSlot }
	nextSlot = nextSlot + 1
	
	return nextSlot
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Arithmetic component
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ComponentsRegistration:ArithmeticCombinatorSerialize(entity)
	if entity == nil then
		return nil
	end
	local params = entity.get_control_behavior().parameters
	
	local str = serializeArithmeticDeciderCommon(params)

	if params.parameters.output_signal then
		str = str..serializeSignal1B(params.parameters.output_signal)..(baseConst.strBoundary1)..baseConst.combinatorOperationToInt[params.parameters.operation]
	else
		str = str..baseConst.strSpecial..(baseConst.strBoundary1)..baseConst.combinatorOperationToInt[params.parameters.operation]
	end
	
	return str
end

function ComponentsRegistration:ArithmeticCombinatorConvert(str, slots)
	if slots == nil then
		return nil
	end
	convertArithmeticDeciderCommon(str, slots)
end


function ComponentsRegistration:ArithmeticCombinatorSpawned(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	local params = entity.get_control_behavior().parameters

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.first_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal(slots[nextSlot].signal.name) }
	else
		params.first_constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.second_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal( slots[nextSlot].signal.name) }
	else
		params.second_constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.output_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal(slots[nextSlot].signal.name) }
	end
	params.operation = baseConst.intToCombinatorOperation[''..slots[nextSlot].count]
	nextSlot = nextSlot + 1
	
	entity.get_control_behavior().parameters = {parameters = params} 
	return nextSlot
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Decider component
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ComponentsRegistration:DeciderCombinatorSerialize(entity)
	if entity == nil then
		return nil
	end
	local params = entity.get_control_behavior().parameters
	
	local str = serializeArithmeticDeciderCommon(params)
	
	local thirdSlotValue = baseConst.combinatorComparatorToInt[''..params.parameters.comparator]

	if params.parameters.copy_count_from_input then
		thirdSlotValue = thirdSlotValue + bit32.lshift(1, 16)
	end

	if params.parameters.output_signal then
		str = str..serializeSignal1B(params.parameters.output_signal)..(baseConst.strBoundary1)..thirdSlotValue
	else
		str = str..baseConst.strSpecial..(baseConst.strBoundary1)..thirdSlotValue
	end
	
	return str
end

function ComponentsRegistration:DeciderCombinatorConvert(str, slots)
	if slots == nil then
		return nil
	end
	convertArithmeticDeciderCommon(str, slots)
end

function ComponentsRegistration:DeciderCombinatorSpawned(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	
	local params = entity.get_control_behavior().parameters
	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.first_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal(slots[nextSlot].signal.name) }
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.second_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal(slots[nextSlot].signal.name) }
	else
		params.parameters.constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.output_signal = { type = slots[nextSlot].signal.type, name = unsubstituteVerySpecialSignal(slots[nextSlot].signal.name) }
	end
	local thirdSlotValue = slots[nextSlot].count
	local dd = bit32.band(thirdSlotValue, 32767)
	params.parameters.comparator = baseConst.intToCombinatorComparator[''..dd]
	if bit32.lshift(thirdSlotValue, 16) == 1 then
		params.parameters.copy_count_from_input = true
	end
	entity.get_control_behavior().parameters = params
	nextSlot = nextSlot + 1
	return nextSlot
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- IO marker as a component
--- Not actually built as a component, but writes to string where to connect inputs and outputs, handled as a special component in func.lua
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ComponentsRegistration:IOMarkerSerializeSub(ioNum)
	return ''..ioNum
end

function ComponentsRegistration:IOMarkerSerialize(entity)
	if entity == nil then
		return nil
	end
	
	local entityId = entity.unit_number
	local dataDesc = global.state.ioEntStates[entityId] or { num = '1' }

	return ComponentsRegistration:IOMarkerSerializeSub(dataDesc.num)
end

function ComponentsRegistration:IOMarkerConvert(str, slots)
	if slots == nil then
		return nil
	end
	
	local num = tonumber(str)
	
	local nextSlot = 1
	slots[nextSlot] = { signal = { type = 'item', name = 'composite-combinator-io-marker' }, count = num, index = nextSlot }
end

function ComponentsRegistration:IOMarkerSpawn(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	error('Not supposed to be here')
end
