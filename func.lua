local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local funcs = {}

function funcs.getPlayer(name)
    name = string.lower(name)

    for _, plr in ipairs(Players:GetPlayers()) do
        if string.lower(plr.Name):sub(1, #name) == name then
            return plr
        end
    end

    return nil
end

function funcs.gotoPlayer(targetName)
    local target = funcs.getPlayer(targetName)
    if not target then
        return false, "player not found"
    end

    local myChar = LocalPlayer.Character
    local targetChar = target.Character

    if not myChar or not targetChar then
        return false, "character not loaded"
    end

    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")

    if not myRoot or not targetRoot then
        return false, "missing root"
    end

    -- teleport behind target (3 studs)
    myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)

    return true
end

return funcs
