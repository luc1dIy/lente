local order = require("data/flags").order

local format = string.format
local stageFormat = format("> stage %%i/%i", #order)

print("$ loading...")
local start = os.clock()

for i = 1, #order do
    local module = order[i]
    print(format(stageFormat, i))
    require(module)
end

print(format("$ loaded in %fs", os.clock() - start))