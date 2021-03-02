local flags = require("data/flags")
local order, mods = flags.order, flags.mods

local format = string.format
local libraryFormat = format("> library %%i/%i", #order)
local modFormat = format("> mod %%i/%i", #mods)

local wrap = coroutine.wrap

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
local loadedMods = require("libs/registry"):getMods()
local sleep, tick = sleep, flags.tick

local function doTick()
    while true do
        for i = 1, #loadedMods do
            local mod = loadedMods[i]

            if mod:doesTick() then
                mod:tick()
            end
        end

        sleep(tick)
    end
end

coroutine.wrap(doTick)()
input.listen()