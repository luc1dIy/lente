return {
    order = { "libs/perip", "libs/settings" },
    requirements = { "plethora:glasses", "plethora:introspection", "plethora:sensor", "plethora:kinetic", "plethora:keyboard" },
    side = "back",
    configPath = "config",
    tick = 7 * 0.05, -- 0.05 == one tick in seconds
    mods = { "mods/leap", "mods/tracers", "mods/config" }
}