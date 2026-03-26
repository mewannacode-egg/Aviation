local funcs = {}

local Players = game:GetService("Players")

function funcs:GetPlayer(str)
	str = string.lower(str)

	for _, player in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(player.Name), str, 1, true)
		or string.find(string.lower(player.DisplayName), str, 1, true) then
			return player
		end
	end
end

function funcs:Goto(fromPlayer, toPlayer)
	if not (fromPlayer.Character and toPlayer.Character) then return end

	local hrp1 = fromPlayer.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = toPlayer.Character:FindFirstChild("HumanoidRootPart")

	if hrp1 and hrp2 then
		hrp1.CFrame = hrp2.CFrame + Vector3.new(0, 3, 0)
	end
end

return funcs
