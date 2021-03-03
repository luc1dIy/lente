local configPath = require("data/flags").configPath

local settings = { }
settings._values = { }

local pcall = pcall
local toJSON, fromJSON = textutils.serialiseJSON, textutils.unserialiseJSON
local format = string.format

local open = fs.open

function settings:save()
    local ok, handle = pcall(open, configPath, "w")
   
    if not ok then
        print(format("! couldn't access config file?\n%s", handle))
        return
    end

    local ok, err = pcall(handle.write, handle, toJSON(self._values))
    
    if not ok then
        print(format("! failed to save config?\n%s", err))
    else
        handle:close()
    end
end

function settings:load()
    local ok, handle = pcall(open, configPath, "r")
    
    if not ok then
        print(format("! couldn't access config file?\n%s", handle))
        return
    end

    if not handle then
        print("! no config file found -- defaulting...")
        self:save()
        return
    end

    local ok, contents = pcall(handle.readAll, handle)

    if not ok then
        print(format("! failed to read config?\n%s", contents))
        return
    end

    local ok, parsed = pcall(fromJSON, contents)
    
    if not ok or not parsed then
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