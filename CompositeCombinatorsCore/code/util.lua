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

local function RecreateAllSignals()
	allItemSignals = { }
	-- 'item'!, 'fluid', 'virtual'
	for _,itemPrototype in pairs(game.item_prototypes) do
		local type = itemPrototype.type
		if type == 'item-with-tags' then
			type = 'item'
		end
		allItemSignals[itemPrototype.name] = { type = itemPrototype.type, name = itemPrototype.name }
	end
end

function EntityNameToSignal(name)
    if allItemSignals == nil then
        RecreateAllSignals()
    end
    local val = allItemSignals[name]
	if not val then
		RecreateAllSignals()
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