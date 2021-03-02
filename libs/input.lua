local input = { }
input._keys = { }

function input:registerKey(key, ignoreHeld, callback)
    self._keys[#self._keys + 1] = { key = key, ignoreHeld = ignoreHeld, callback = callback }
end

function input.processInput(_, key, held)
    for i = 1, #input._keys do
        local entry = input._keys[i]

        if entry.key == key and (entry.ignoreHeld and not held) then
            entry.callback(key, held)
        end
    end
end

return input