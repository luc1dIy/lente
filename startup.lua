-- lente bootstrapper.
print("$ bootstrapping lente...")

local _settings = { }
-- remote
_settings.repository = "luc1dIy/lente"
_settings.apiBase = "https://api.github.com/repos/%s/contents/%s"
_settings.path = "build/build.min.lua"
-- local
_settings.buildPath = "lente.lua"
_settings.delay = 100 * 0.05 -- 5s in ticks
_settings.debug = false -- this will disable this script
local _uri = string.format(_settings.apiBase, _settings.repository, _settings.path)

if _settings.debug then
    return
end

local exists, sleep = fs.exists, os.sleep
local decode, get = textutils.unserialiseJSON, http.get
local pcall = pcall

local latest

while not latest do
    local response, err = get(_uri)

    if (response and response.getResponsecode() ~= 200) or err then
        print("! failed to fetch latest version, trying again in " .. _settings.delay .. "t...")
    else
        local json = response.readAll()
        local ok, body = pcall(decode, json)

        if not ok then
            print("! json corrupted, trying again in " .. _settings.delay .. "t...")
        else
            latest = body
            break
        end

        response.close()
    end

    sleep(_settings.delay)
end

-- credits to http://lua-users.org/wiki/BaseSixtyFour
-- (with some minor optimisations because the java lua vm is slow)
local sub, char, find, gsub = string.sub, string.char, string.find, string.gsub
local format, join = string.format, "%s%s"

local charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local pat = format("[^%s=]", charSet)

local function B64Decode(data)
    data = gsub(data, pat, "")
    return gsub(
        gsub(data, ".", function(x)
            if (x == "=") then return "" end
            local r, f = "", (find(charSet, x) - 1)
            for i = 6, 1, -1 do
                r = format(join, r, (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0"))
            end
            return r
        end), "%d%d%d?%d?%d?%d?%d?%d?", function(x)
            if (#x ~= 8) then return "" end
            local c = 0
            for i = 1, 8 do
                c = c + (sub(x, i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return char(c)
        end)
end

local handle = fs.open(_settings.buildPath, "w")
handle:write(B64Decode(latest.content))
handle:close()

print("$ lente (hash: " .. latest.sha .. ")")
dofile(_settings.buildPath)