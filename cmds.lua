local funcs = loadstring(game:HttpGet("https://raw.githubusercontent.com/<username>/<repo>/main/func.lua"))()
local commands = {}
local function addCommand(name, callback)
    commands[name] = callback
end



return commands
