local funcs = require(script.Parent.function)

local cmds = {}

cmds["goto"] = function(args)
    local target = args[1]
    if not target then return end

    local success, err = funcs.gotoPlayer(target)
    if not success then
        warn("[goto]:", err)
    end
end

return cmds
