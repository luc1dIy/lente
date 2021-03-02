local hud = { }
hud._handle = require("libs/perip").canvas
hud._handle.clear()
hud._canvas = hud._handle.create()
hud._objects = { }
hud._modMap = { }
hud._current = nil

local registry = require("registry")
local input = require("input")

local setting = require("classes/setting")

local theme = require("data/theme")
local palette, offset, size = theme.palette, theme.offset, theme.size

local textColour, enabledColour, cursorColour = palette.text, palette.enabled, palette.cursor

local enums = require("data/enums")
local modType = enums.modType

local trueLen = require("utils").trueLen
local select = select

local cursor = hud._canvas.addRectangle({ x = offset.x - 2, y = offset.y }, 1, 5, cursorColour)

function hud:addMod(mod)
    local text = self._canvas.addText({ x = offset.x, y = (trueLen(self._objects) + 1) * offset.y }, mod:getName(), textColour, size)
    text.setShadow(true)

    self._objects[mod] = text
    self._modMap[#self._modMap + 1] = mod

    if trueLen(self._objects) == 1 then
        self._current = 1
        self:updateCursor()
    end
end

function hud:updateMod(mod)
    local object = self._objects[mod]

    if object then
        object.setColour(mod:isEnabled() and enabledColour or textColour)
    end
end

function hud:updateCursor()
    if self._current then
        cursor.setPosition(offset.x - 2, select(2, self._objects[self._modMap[self._current]].getPosition()))
    end
end

function hud._scrollUp()
    local nextIndex = hud._current + 1
    hud._current = nextIndex > trueLen(hud._objects) and 1 or nextIndex
    hud:updateCursor()
end

function hud._scrollDown()
    local previousIndex = hud._current - 1
    hud._current = previousIndex < 1 and trueLen(hud._objects) or previousIndex
    hud:updateCursor()
end

function hud._runCursor()
    hud._modMap[hud._current]:run()
end

input:registerKey(setting.new("hud.scrollUp", key.pageUp):getValue(), true, hud._scrollUp)
input:registerKey(setting.new("hud.scrollDown", key.pageDown):getValue(), true, hud._scrollDown)
input:registerKey(setting.new("hud.runCursor", key.grave):getValue(), true, hud._runCursor)

return hud