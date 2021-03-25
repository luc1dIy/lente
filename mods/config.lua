local mod = require("classes/mod")

local enums = require("data/enums")
local modType = enums.modType

local settings = require("libs/settings")

mod.new("saveConfig", "save the current config!", modType.invoke)
    :setCallback(function()
        settings:save()
    end)
mod.new("loadConfig", "load config from file!", modType.invoke)
    :setCallback(function()
        settings:load()
    end)