local utils = { }

local byte, sub = string.byte, string.sub

function utils.getTotalBytes(str)
    local total = 0

    for i = 1, #str do
        total = total + byte(sub(str, i, i))
    end

    return total
end

return utils