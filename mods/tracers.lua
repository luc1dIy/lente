local mod, setting = require("classes/mod"), require("classes/setting")

local enums = require("data/enums")
local modType = enums.modType

local perips = require("libs/perip")
local sense = perips.sense

local playerId = perips.getMetaOwner().id

local power = setting.new("mods.movement.leap.power", 2.5)

local tracers =
    mod.new("leap", "propel yourself where you're looking!", modType.passive)