local funcs = require(script.Parent.function)

local cmds = {}

cmds["goto"] = function(args)
    local targetName = args[1]

    if not targetName then
        warn("no target provided")
        return
    end

    local success, err = funcs.gotoPlayer(targetName)

    if not success then
        warn("[goto error]:", err)
    end
end

return cmds
