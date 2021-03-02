local input = { }
input._keys = { }

local pullEvent = os.pullEvent

function input:registerKey(key, ignoreHeld, callback)
    self._keys[#self._keys + 1] = { key = key, ignoreHeld = ignoreHeld, callback = callback }
end

function input._listener()
    while true do
        local _, key, held = pullEvent("key")

        for i = 1, #input._keys do
            local entry = input._keys[i]

            if entry.key == key and (entry.ignoreHeld and not held) then
                entry.callback(key, held)
            end
        end
    end
end

coroutine.wrap(input._listener)()

return input