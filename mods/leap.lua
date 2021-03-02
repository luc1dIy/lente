local mod, setting = require("classes/mod.lua"), require("classes/setting.lua")

local enums = require("data/enums.lua")
local category, modType = enums.category, enums.modType

local launch = require("libs/perip.lua").launch

local leapPowerNode = "mods.movement.leap.power"
local leapPowerX = setting.new(leapPowerNode .. "X", 0.0)
local leapPowerY = setting.new(leapPowerNode .. "Y", 0.5)
local leapPowerZ = setting.new(leapPowerNode .. "Z", 1.5)

local leap =
    mod.new("leap", "propel yourself through the air!", category.invoke, modType.invoke)
leap
    :setCallback(function() 
        launch(leapPowerX:getValue(), leapPowerY:getValue(), leapPowerZ:getValue())
    end)

return leap