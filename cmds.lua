local funcs = loadstring(game:HttpGet("https://raw.githubusercontent.com/<username>/<repo>/main/func.lua"))()
local commands = {}
local function addCommand(name, callback)
    commands[name] = callback
end

addCommand("-goto", function(args, player)
    local target = funcs.getPlayer(args[1])
    if target then
        funcs.gotoPlayer(player, target)
    end
end)

return commands
