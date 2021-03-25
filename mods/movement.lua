local mod, setting = require("classes/mod"), require("classes/setting")

local enums = require("data/enums")
local modType = enums.modType

local perips = require("libs/perip")
local getMetaOwner = perips.getMetaOwner
local scan, launch = perips.scan, perips.launch

-- leap
local power = setting.new("mods.movement.leap.power", 2.5)
local yawAmplifier = setting.new("mods.movement.leap.yawAmplifier", 1.0)
local pitchAmplifier = setting.new("mods.movement.leap.pitchAmplifier", 1.0)

mod.new("leap", "propel yourself where you're looking!", modType.invoke)
    :setCallback(function()
        local meta = getMetaOwner()
        launch(meta.yaw * yawAmplifier:getValue(), meta.pitch * pitchAmplifier:getValue(), power:getValue())
    end)

-- noFall (https://plethora.madefor.cc/examples/fly.html)
local abs, min = math.abs, math.min

local minPosMotion = setting.new("mods.movement.noFall.minPosMotion", 0.5)
local minNegMotion = setting.new("mods.movement.noFall.minNegMotion", 0.0)

mod.new("noFall", "negates falldamage!", modType.passive, true)
    :setTickCallback(function(self) 
        if not self:isEnabled() then
            return
        end

        local motionY = (getMetaOwner().motionY - 0.138) / 0.8

        if motionY > minPosMotion:getValue() or motionY < minNegMotion:getValue() then
            launch(0, mY < 0 and -90 or 90, min(4, abs(motionY)))
        end
    end)