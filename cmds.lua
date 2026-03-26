local funcs = local funcs = loadstring(game:HttpGet("https://raw.githubusercontent.com/mewannacode-egg/Aviation/main/func.lua"))()
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
