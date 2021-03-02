local mod = { }
mod._name = nil
mod._desc = nil
mod._modType = nil
mod._enabled = nil

mod.__index = mod

local registry = require("libs/registry.lua")
local hud = require("libs/hud.lua")

local modType = require("data/enums.lua").modType

function mod.new(name, desc, modType)
    local instance = setmetatable({ }, mod)
    instance._name = name
    instance._desc = desc
    instance._modType = modType
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

function mod:setCallback(callback) 
    self._callback = callback
end

function mod:run(...)
    if self._modType == modType.passive then
        self._enabled = not self._enabled
        hud:updateMod(self)
    end

    self._callback(...)
end

return mod