local funcs = {}
local Players = game:GetService("Players")

function funcs.getPlayer(name)
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name):sub(1, #name) == string.lower(name) then
            return player
        end
    end
    return nil
end

function funcs.gotoPlayer(player, target)
    if player and target and player.Character and target.Character then
        local myRoot = player.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")

        if myRoot and targetRoot then
            myRoot.CFrame = targetRoot.CFrame + (targetRoot.CFrame.LookVector * -2)
        end
    end
end

return funcs
