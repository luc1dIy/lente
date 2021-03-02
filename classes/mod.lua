local mod = { }
mod._name = nil
mod._desc = nil
mod._modType = nil
mod._enabled = nil

mod.__index = mod

local registry = require("libs/registry")

local modType = require("data/enums").modType

function mod.new(name, desc, modType, ticks)
    local instance = setmetatable({ }, mod)
    instance._name = name
    instance._desc = desc
    instance._modType = modType
    instance._ticks = ticks
    instance._enabled = false

    registry:registerMod(instance)
    return instance
end

function mod:getName()
    return self._name
end

function mod:getDesc()
    return self._desc
end

function mod:getType()
    return self._modType
end

function mod:isEnabled()
    return self._enabled
end

function mod:doesTick()
    return self._ticks
end

function mod:setCallback(callback) 
    self._callback = callback
end

function mod:setTickCallback(callback)
    self._tickCallback = callback
end

function mod:run()
    if self._modType == modType.passive then
        self._enabled = not self._enabled
        hud:updateMod(self)
        return
    end

    self._callback(self)
end

function mod:tick()
    self._tickCallback(self)
end

return mod