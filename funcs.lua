local funcs = {}

local Players = game:GetService("Players")

--Player targetting
function funcs:GetPlayers(str, sender)
	local Players = game:GetService("Players")
	str = string.lower(str)

	local isRandom = false

	if str == "random/" then
		isRandom = true
	end

	if isRandom then
		local pool = {}

		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= sender then
				table.insert(pool, plr)
			end
		end

		if #pool > 0 then
			return {pool[math.random(1, #pool)]}
		end

		return {}
	end

	local targets = {}

	for _, plr in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(plr.Name), str, 1, true)
		or string.find(string.lower(plr.DisplayName), str, 1, true) then
			table.insert(targets, plr)
		end
	end

	return targets
end

---functions for commands---
function funcs:Goto(from, to)
	if not (from.Character and to.Character) then return end

	local hrp1 = from.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = to.Character:FindFirstChild("HumanoidRootPart")

	if hrp1 and hrp2 then
		hrp1.CFrame = hrp2.CFrame + Vector3.new(0, 3, 0)
	end
end

return funcs
