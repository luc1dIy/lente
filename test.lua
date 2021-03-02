
local test = require("./classes/setting.lua")
    .new("test", { 1, 2, 3 })

print(test)
print(test:getValue())
test:setValue{ 1 , 2 , 3 }