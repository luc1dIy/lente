local mod = require("classes/mod")

local enums = require("data/enums")
local modType = enums.modType

local perips = require("libs/perip")

local handle = perips.canvas3d()
local canvas = handle.create()

local addLine = canvas.addLine
local sense = perips.sense

local trueLen = require("libs/utils").trueLen

local playerId = perips.getMetaOwner().id

local relative = { 0, -0.5, 0 }
local lineColour = require("data/theme").palette.tracers
local lines = { }

local function clearLines()
    for _, remove in pairs(lines) do
        remove()
    end

    lines = { }
end

mod.new("tracers", "trace foes down!", modType.passive, true)
    :setTickCallback(function(self) 
        if not self:isEnabled() then
            if trueLen(lines) ~= 0 then
                clearLines()
            end

            return
        end

        clearLines()
        
        local nearby = sense()

        for i = 1, #nearby do
            local entity = nearby[i]

            if entity.id ~= playerId then
                lines[#lines + 1] = addLine(relative, { entity.x, entity.y, entity.z }, 3, lineColour).remove
            end
        end
    end)