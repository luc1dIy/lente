local flags = require("../data/flags.lua")

local requirements = flags.requirements

local perip = peripheral.wrap(flags.side)
assert(perip, "! no neural interface detected.")

local hasModule = perip.hasModule
assert(hasModule, "! peripheral is missing hasModule method? is this a neural interface?")

for i = 1, #requirements do
    local module = requirements[i]
    assert(hasModule(module), "! missing module: " .. module)
end

print("$ peripheral check complete.")
return perip