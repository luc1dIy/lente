local mod = require("classes/mod")

local enums = require("data/enums")
local modType = enums.modType

local settings = require("libs/settings")

mod.new("save_config", "save the current config!", modType.invoke)
    :setCallback(function()
        settings:save()
    end)
mod.new("load_config", "load config from file!", modType.invoke)
    :setCallBack(function()
        settings:load()
    end)