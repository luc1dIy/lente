local flags = require("data/flags")
local order, mods = flags.order, flags.mods

local format = string.format
local libraryFormat = format("> library %%i/%i", #order)
local modFormat = format("> mod %%i/%i", #mods)

print("$ pre-loading a few libraries...")
local start = os.clock()

for i = 1, #order do
    require(order[i])
    print(format(libraryFormat, i))
end

print("$ loading mods...")

for i = 1, #mods do
    require(mods[i])
    print(format(modFormat, i))
end

print(format("$ loaded fully in %fs", os.clock() - start))

local input = require("libs/input")

while true do
    -- TODO some other event loops, probably.
    input:listen()
end