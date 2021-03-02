local utils = { }

local byte, sub = string.byte, string.sub

function utils.trueLen(t)
    local len = 0

    for _, __ in pairs(t) do
        len = len + 1
    end

    return len
end

function utils.getTotalBytes(str)
    local total = 0

    for i = 1, #str do
        total = total + byte(sub(str, i, i))
    end

    return total
end

return utils