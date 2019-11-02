



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



function msg(playerIndex, msgg)
    game.players[playerIndex].print(msgg)
end