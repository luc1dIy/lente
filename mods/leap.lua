local mod, setting = require("../classes/mod.lua"), require("../classes/setting.lua")

local enums = require("../data/enums.lua")
local modType = enums.modType

local perips = require("../libs/perip.lua")
local getMetaOwner, launch = perips.getMetaOwner, perips.launch

local power = setting.new("mods.movement.leap.power", 2.5)

local leap =
    mod.new("leap", "propel yourself where you're looking!", modType.invoke)
leap
    :setCallback(function()
        local meta = getMetaOwner()
        launch(meta.yaw, meta.pitch, power:getValue())
    end)