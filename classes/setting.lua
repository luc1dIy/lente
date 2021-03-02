local setting = { }
setting._node = nil
setting._default = nil
setting._value = nil
setting._allowed = nil

setting.__index = setting

local settings = require("libs/settings.lua")

local assert, type = assert, type
local format = string.format

local SAVE_MISMATCH = "! saved setting %s is of an illegal type: expected %s, got %s -- defaulting..."
local TYPE_MISMATCH = "expected %s, got %s."

function setting.new(node, default)
    local instance = setmetatable({ }, setting)
    instance._node = node
    instance._default = default
    instance._value = instance._default
    instance._allowed = type(instance._default)

    local savedValue = settings:getValue(instance._node)

    if savedValue then
        local savedType = type(savedValue)
        if savedType ~= instance._allowed then
            print(format(SAVE_MISMATCH, instance._node, instance._allowed, savedType))
        else
            instance._value = savedValue
        end
    end

    settings:updateValue(instance._node, instance._value)
    return instance
end

function setting:getNode()
    return self._node
end

function setting:getValue()
    return self._value
end

function setting:setValue(value)
    local valueType = type(value)
    assert(valueType == self._allowed, format(TYPE_MISMATCH, self._allowed, valueType))

    self._value = value
    settings:updateValue(self._node, self._value)
end

return setting