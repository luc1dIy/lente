local mod, setting = require("classes/mod.lua"), require("classes/setting.lua")

local enums = require("data/enums.lua")
local category, modType = enums.category, enums.modType

local scan = require("libs/perip.lua").scan

local blocks = require("data/theme.lua").palette.blocks

local scanNode = "mods.visual.scan."
local maxCacheSize = setting.new(scanNode .. "maxCacheSize", 100)
local toggleResetsCache = setting.new(scanNode .. "toggleResetsCache", false)

local cache = { }

local xray =
    mod.new("xray", "show specific blocks through walls! ", category.visual, modType.passive)
xray
    :setCallback(function() 
        
    end)

return xray