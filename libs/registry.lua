local registry = { }
registry._mods = { }

local toLoad = require("data/flags").mods

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

function registry:registerMod(mod)
    self._mods[#self._mods + 1] = mod
end

return registry