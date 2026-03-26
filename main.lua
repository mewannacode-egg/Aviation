local cmds = require(script.Parent.cmds)

local prefix = "-"

local function runCommand(message)
    if message:sub(1, #prefix) ~= prefix then return end

    local args = {}
    for word in message:sub(#prefix + 1):gmatch("%S+") do
        table.insert(args, word)
    end

    local cmdName = table.remove(args, 1)
    cmdName = string.lower(cmdName or "")

    local cmd = cmds[cmdName]
    if cmd then
        cmd(args)
    else
        warn("unknown command:", cmdName)
    end
end

-- example trigger (you can replace this with your GUI input)
game:GetService("Players").LocalPlayer.Chatted:Connect(runCommand)
