local order = require("data/flags.lua").order

local format = string.format
local stageFormat = format("> stage %%i/%i: %%s", #LOAD_FIRST)

print("$ loading...")
local start = os.clock()

for i = 1, #order do
    local module = order[i]
    print(format(stageFormat, i, module))
    import(module)
end

print(format("$ loaded in %fs", os.clock() - start))