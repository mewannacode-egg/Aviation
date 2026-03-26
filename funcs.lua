local funcs = {}

local Players = game:GetService("Players")

function funcs:GetPlayer(str)
	str = string.lower(str)

	for _, plr in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(plr.Name), str, 1, true)
		or string.find(string.lower(plr.DisplayName), str, 1, true) then
			return plr
		end
	end
end

function funcs:Goto(from, to)
	if not (from.Character and to.Character) then return end

	local hrp1 = from.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = to.Character:FindFirstChild("HumanoidRootPart")

	if hrp1 and hrp2 then
		hrp1.CFrame = hrp2.CFrame + Vector3.new(0, 3, 0)
	end
end

return funcs
