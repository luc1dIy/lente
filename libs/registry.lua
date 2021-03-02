local registry = { }
registry._mods = { }

local hud = require("libs/hud")

function registry:getMods()
    return self._mods
end

function registry:registerMod(mod)
    self._mods[#self._mods + 1] = mod
    hud:addMod(mod)
end

return registry