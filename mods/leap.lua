local mod, setting = require("classes/mod"), require("classes/setting")

local enums = require("data/enums")
local modType = enums.modType

local perips = require("libs/perip")
local getMetaOwner, launch = perips.getMetaOwner, perips.launch

local power = setting.new("mods.movement.leap.power", 2.5)
local yawAmplifier = setting.new("mods.movement.leap.yawAmplifier", 1.0)
local pitchAmplifier = setting.new("mods.movement.leap.pitchAmplifier", 1.0)

mod.new("leap", "propel yourself where you're looking!", modType.invoke)
    :setCallback(function()
        local meta = getMetaOwner()
        launch(meta.yaw * yawAmplifier:getValue(), meta.pitch * pitchAmplifier:getValue(), power:getValue())
    end)