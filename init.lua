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

local processInput = require("libs/input").processInput
local loadedMods = require("libs/registry"):getMods()
local sleep, tick = sleep, flags.tick

local waitForAll = parallel.waitForAll
local pullEvent = os.pullEvent

local function doTick()
    for i = 1, #loadedMods do
        local mod = loadedMods[i]

        if mod:doesTick() then
            mod:tick()
        end
    end
end

local function inputListener()
    processInput(pullEvent("key"))
end

while true do
    waitForAll(doTick, inputListener)
end