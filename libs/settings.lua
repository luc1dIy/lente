local json = require("json")
local fs = io
fs.exists = require("fs").existsSync
local textutils = { serialiseJSON = json.encode, unserialiseJSON = json.decode }
--

local configPath = require("data/flags.lua").configPath

local settings = { }
settings._registered = { }
settings._values = { }

local pcall = pcall
local toJSON, fromJSON = textutils.serialiseJSON, textutils.unserialiseJSON
local format = string.format

local ok, value = pcall(fs.open, configPath, fs.exists(configPath) and "rw" or "w+")
assert(ok, string.format("! couldn't access config file?\n%s", value))
settings._handle = value

function settings:save()
    local ok, err = pcall(self._handle.write, self._handle, toJSON(self._values))
    
    if not ok then
        print(format("! failed to save config?\n%s", err))
    end
end

function settings:load()
    local contents = self._handle:read()

    if not contents then
        print("! no config file found -- defaulting...")
        self:save()
        return
    end

    local ok, parsed = pcall(fromJSON, contents)
    
    if not ok then
        print("! config file corrupted -- defaulting...")
        self:save()
    else
        self._values = parsed
    end
end

function settings:getValue(node)
    return self._values[node]
end

function settings:updateValue(node, value)
    self._values[node] = value
    self:save()
end

settings:load()
return settings