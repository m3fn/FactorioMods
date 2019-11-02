function split2 (inputstr, sep) -- i've died here
	local t={}
	local bLastEmptyREGEXAVOID = 0
	-- on windows7 sp1, i5-4690
	-- if remove luaBUGAVOID and just set bLastEmptyREGEXAVOID in place - we will get .. attention to when DU22 is executed 'WO DU WO SHAME WTF DIS DU22'
	-- WTFFF???
	local luaBUGAVOID = 0 
	for str in string.gmatch(inputstr, "([^"..sep.."]*)") do -- fuck this shit
		game.players[1].print("WO: "..str..'WUT'..string.len(str))
		if string.len(str) == 0 then
			game.players[1].print("SHAME")
			if bLastEmptyREGEXAVOID == 1 then
				game.players[1].print("DU22")
				table.insert(t, str)
			else 
				game.players[1].print("WTF: ")
			end
			if bLastEmptyREGEXAVOID ~= 1 then 
				game.players[1].print("DIS: "..str)
				luaBUGAVOID = 1
			end
		end
		
		if string.len(str) ~= 0 then
			bLastEmptyREGEXAVOID = 0
			game.players[1].print("DU: "..str)
			table.insert(t, str)
		end
		
		if luaBUGAVOID then
			bLastEmptyREGEXAVOID = 1
		end
	end
	return t
end

function split5(self, delimiter) -- infinite recursion or just a hang dunno, also second call never actually reaches the first line IDK what to do
  	game.players[1].print('ENTER SPL3: ')
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  local iteration = 1
  	game.players[1].print('DELI: '..delim_from )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
	game.players[1].print('GU: '..string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
				if not delim_to then break end
iteration = iteration +1
if iteration > 9999 then break end -- pls send help.............................
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end


function split3 (str, d) -- this is the one that works, O M G !
	local res = { }
	
	if str == '' then
		return res
	end
	
	-- game.players[1].print(d.."SPLIT_INPUT: "..str)
	
	local resi = 1
	local i = 1
	local from = 1
	
	while i <= string.len (str) do
		if (str:sub(i,i) == d) then -- I reaaally hate this languagewwwwwwwWWWWW!!!!!11111
			toAdd = ''
			
			while from < i do
				toAdd = toAdd..str:sub(from,from)
				from = from + 1
			end
			
			-- game.players[1].print("ADD: "..toAdd)
			res[resi] = toAdd
			resi = resi + 1
			from = from + 1
			i = i + 1
		end
		
		i = i + 1
	end
	
	toAdd = ''

	while from < (i) do
		--game.players[1].print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA: "..from)
		--game.players[1].print("AAA: "..str:sub(from,from))
		toAdd = toAdd..str:sub(from,from)
		from = from + 1
	end
	
	res[resi] = toAdd
	resi = resi + 1 -- because fuck you
	from = from + 1
	
	-- game.players[1].print(d.."SPLIT_OUTPUT: "..inspect(res))

	return res
end



-- by gist.github.com/hazpotts/
function SpiralCoordinates(id)
	local x
	local y
    if id == 1 then
        x = 0
        y = 0
    else
        local idSqrt = math.sqrt(id); -- find the square root of the id
        local lowSqrt = math.floor(idSqrt) -- round the square root down
        local highSqrt = math.ceil(idSqrt) -- round the square root up
        if lowSqrt == highSqrt then -- if they are the same it's the last position
            lowSqrt = lowSqrt - 2; -- to calculate previous odd square root
        end
        if lowSqrt % 2 == 0 then -- if in the second half of the ring the low root is even, need to find the previous odd because centered rings are odd number sided squares
            lowSqrt = lowSqrt - 1;
        end
        if highSqrt % 2 == 0 then -- same but for first half and high root
            highSqrt = highSqrt + 1;
        end

        local previousRingEnd = math.pow(lowSqrt, 2); -- square root rounded down and then squared finds the number at the end of the previous ring
        local ringEnd = math.pow(highSqrt, 2); -- the same but for the end of the current ring
        local ringPosition = id - previousRingEnd; -- (15-9 = 6) taking the previous ring from the id finds the position around the current ring
        local ringTotal = ringEnd - previousRingEnd; -- (25-9 = 16) taking the previous ring from the current finds the total count around the current ring
        local sideLengthMinusOne = ringTotal / 4; -- 16/4 = 4
        local halfSideLengthMO = sideLengthMinusOne / 2; -- 4/2 = 2
        local side = ringPosition / ringTotal;
        
        --[[
         * This calculates what side it's on
         * and it's position along that side.
         * Corner positions count as being the last on the side
         * hence the minus 1 on side length, because the first
         * corner of each side counted for the previous side.
         * Corners could be calculated from either side that they
         * are a part of.
        ]]--

        if side <= 0.25 then -- right hand side
            x = halfSideLengthMO;
            y = halfSideLengthMO - ringPosition;
        elseif side <= 0.5 then -- bottom
            x = halfSideLengthMO - (ringPosition - sideLengthMinusOne);
            y = -halfSideLengthMO;
        elseif side <= 0.75 then -- left hand side
            x = -halfSideLengthMO;
            y = -halfSideLengthMO + (ringPosition - (sideLengthMinusOne*2));
        elseif side > 0.75 then -- top
            x = -halfSideLengthMO + (ringPosition - (sideLengthMinusOne*3));
            y = halfSideLengthMO;
        end
    end

    return { x = x, y = y }
end

function HasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function GetValue (tab, key)
    for key2, value in pairs(tab) do
        if key2 == key then
            return value
        end
    end

    return nil
end


local allItemSignals = nil

function EntityNameToSignal(name)
    if allItemSignals == nil then
        allItemSignals = { }
        -- 'item'!, 'fluid', 'virtual'
        for _,itemPrototype in pairs(game.item_prototypes) do
            allItemSignals[itemPrototype.name] = { type = itemPrototype.type, name = itemPrototype.name }
        end
    end
    local VALUE = allItemSignals[name]
	if not VALUE then
		allItemSignals = { }
        -- 'item'!, 'fluid', 'virtual'
        for _,itemPrototype in pairs(game.item_prototypes) do
			game.players[1].print(itemPrototype.name)
            allItemSignals[itemPrototype.name] = { type = itemPrototype.type, name = itemPrototype.name }
        end
	end
	return allItemSignals[name]
end

function EntityToSignal(entity)
    return EntityNameToSignal(entity.prototype.name)
end
  
local allEntityPrototypes = nil

function SignalToEntityPrototype(signalType, signalName)
  if signalType ~= 'item' and signalType ~= 'item-with-tags' then
    return nil
  end
  if allEntityPrototypes == nil then
    allEntityPrototypes = { }
    for _,entityPrototype in pairs(game.entity_prototypes) do
      allEntityPrototypes[entityPrototype.name] = entityPrototype
    end
  end
  return allEntityPrototypes[signalName]
end


function msg(playerIndex, msgg)
    game.players[playerIndex].print(msgg)
end

-- outrageously stolen from MagmaMcFry / Factorissimo2
function FindBlueprint(player, state)
  local inventories = {player.get_inventory(defines.inventory.player_quickbar), player.get_inventory(defines.inventory.player_main)}
  for _, inv in pairs(inventories) do
    for i=1,#inv do
      local itemStack = inv[i]
      if itemStack.valid_for_read and itemStack.name == "blueprint2" then
        local setup = itemStack.is_blueprint_setup()
        if (state == "empty" and not setup) or
          (state == "setup" and setup) or
          (state == "whatever")
        then
          return itemStack
        end
      end
    end
  end
end