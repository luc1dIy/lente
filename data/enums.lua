local enums = { }

local function addEnum(enumName, ...)
    local enum = { }

    for index, name in pairs{ ... } do
        enum[name] = index
        enum[index] = name
    end

    enums[enumName] = enum
end

addEnum("modType",
    "invoke",
    "passive"
)

return enums