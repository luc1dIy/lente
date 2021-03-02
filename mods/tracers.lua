local mod = require("classes/mod")

local enums = require("data/enums")
local modType = enums.modType

local perips = require("libs/perip")

local createCanvas = perips.canvas3d().create
local sense = perips.sense

local trueLen = require("libs/utils").trueLen

local playerId = perips.getMetaOwner().id

local relative = { 0, -0.5, 0 }
local lineColour = require("data/theme").palette.tracers

local removeCanvas

mod.new("tracers", "trace foes down!", modType.passive, true)
    :setTickCallback(function(self) 
        if not self:isEnabled() then
            if removeCanvas then
                removeCanvas()
            end

            return
        end

        if removeCanvas then
            removeCanvas()
        end
        
        local canvas = createCanvas(relative)
        removeCanvas = canvas.remove()
        
        local addLine = canvas.addLine

        local nearby = sense()

        for i = 1, #nearby do
            local entity = nearby[i]

            if entity.id ~= playerId then
                addLine(relative, { entity.x, entity.y, entity.z }, 3, lineColour)
            end
        end
    end)