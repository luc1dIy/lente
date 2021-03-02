local registry = { }
registry._mods = { }
registry._categories = { }

local toLoad = require("../data/flags.lua").mods

function registry:getMods()
    return self._mods
end

function registry:getModByName(name)
    for i = 1, #self._mods do
        local mod = self._mods[i]

        if mod:getName() == name then
            return mod
        end
    end
end

for _, path in pairs(toLoad) do
    local mod = require(path)
    self._mods[#self._mods + 1] = mod
end

return registry