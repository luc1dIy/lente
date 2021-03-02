local mod = { }
mod.__index = mod

local modType = require("data/enums.lua").modType

function mod.new(name, desc, category, modType)
    local instance = setmetatable({ }, mod)
    instance._name = name
    instance._desc = desc
    instance._category = category
    instance._modType = modType
    instance._enabled = false

    return instance
end

function mod:isEnabled()
    return self._enabled
end

function mod:setCallback(callback) 
    self._callback = callback
end

function mod:run(...)
    if self._modType == modType.passive then
        self._enabled = not self._enabled
    end

    self._callback(...)
end

return mod