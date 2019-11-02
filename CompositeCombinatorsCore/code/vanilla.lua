--[[
--------------------------------------------------------------------------------
-- Composite Combinators Core mod
--------------------------------------------------------------------------------
-- vanilla.lua 
-- Purpose:
    Add vanilla conbinators as components (using component part the API)
]]--

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

--[[
	o u t d a t e d
	Constant combinator: 17 slots
	16 slots with signals
	1 slot - enabled indication A 0 or A 1
]]

-- entity -> string 
function constantCombinatorSerialize(entity)
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
function constantCombinatorConvert(str, slots)
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
function constantCombinatorSpawned(entity, slots, nextSlot)
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
			signalName = spl[index]
			index = index + 1
			
			slots[nextSlot] = { signal = { type = signalType, name = signalName }, count = signalCount, index = nextSlot }
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
		signalName = spl[index]
		index = index + 1
	end
	signalCount = spl[index]
	index = index + 1
	
	slots[nextSlot] = { signal = { type = signalType, name = signalName }, count = signalCount, index = nextSlot }
	nextSlot = nextSlot + 1

	return nextSlot
end

--[[
	o u t d a t e d
	Arithmetic combinator: 
		1 slot: first_signal or first_constant :: Signal or int (signal=special) 
		2 slot: second_signal or second_constant :: Signal or int (signal=special)
		3 slot: signal: output_signal value: operation: "*", "/", "+", "-", "%", "^", "<<", ">>", "AND", "OR", "XOR"
]]


function arithmeticCombinatorSerialize(entity)
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

function arithmeticCombinatorConvert(str, slots)
	if slots == nil then
		return nil
	end
	convertArithmeticDeciderCommon(str, slots)
end


function arithmeticCombinatorSpawned(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	local params = entity.get_control_behavior().parameters

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.first_signal = { type = slots[nextSlot].signal.type, name = slots[nextSlot].signal.name }
	else
		params.first_constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.second_signal = slots[nextSlot].signal
	else
		params.second_constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.output_signal = slots[nextSlot].signal
	end
	params.operation = baseConst.intToCombinatorOperation[''..slots[nextSlot].count]
	nextSlot = nextSlot + 1
	
	entity.get_control_behavior().parameters = {parameters = params} 
	return nextSlot
end


--[[
	o u t d a t e d
	Decider combinator:
		1 slot: first_signal or none (signal=special)
		2 slot: second_signal or constant :: Signal or int (signal=special)
		3 slot: sinal: output_signal or none (signal=special), value = comparator: "<", ">", "=", "≥", "≤", "≠", copy_count_from_input is 16th bit
]]--

function deciderCombinatorSerialize(entity)
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

function deciderCombinatorConvert(str, slots)
	if slots == nil then
		return nil
	end
	convertArithmeticDeciderCommon(str, slots)
end

function deciderCombinatorSpawned(entity, slots, nextSlot)
	if entity == nil then
		return nil
	end
	
	local params = entity.get_control_behavior().parameters
	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.first_signal = slots[nextSlot].signal
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.second_signal = slots[nextSlot].signal
	else
		params.parameters.constant = slots[nextSlot].count
	end
	nextSlot = nextSlot + 1

	if slots[nextSlot].signal.name ~= baseConst.specialSignal.name then
		params.parameters.output_signal = slots[nextSlot].signal
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