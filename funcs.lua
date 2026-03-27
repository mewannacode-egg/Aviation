local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local funcs = {}

---PLAYER TARGETING---
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

---COMMANDS---

--GOTO
function funcs:Goto(from, to)
	if not (from.Character and to.Character) then return end

	local hrp1 = from.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = to.Character:FindFirstChild("HumanoidRootPart")

	if hrp1 and hrp2 then
		hrp1.CFrame = hrp2.CFrame + Vector3.new(0, 3, 0)
	end
end

--FLY
funcs.ActiveFlys = {}

function funcs:StartFly(player, speed)
	speed = speed or 40
	local char = player.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	if self.ActiveFlys[player] then return end

	local flyPart = Instance.new("Part")
	flyPart.Name = "FlyController"
	flyPart.Transparency = 1
	flyPart.CanCollide = false
	flyPart.Anchored = true
	flyPart.CFrame = hrp.CFrame
	flyPart.Parent = char

	local flying = true
	self.ActiveFlys[player] = {
		Part = flyPart,
		Flying = true
	}

	coroutine.wrap(function()
		while flying and self.ActiveFlys[player] and self.ActiveFlys[player].Flying do
			local move = hum.MoveDirection
			if move.Magnitude > 0 then
				local camCFrame = workspace.CurrentCamera.CFrame
				local forward = Vector3.new(camCFrame.LookVector.X,0,camCFrame.LookVector.Z).Unit
				local right = Vector3.new(camCFrame.RightVector.X,0,camCFrame.RightVector.Z).Unit

				local dir = (forward * move.Z + right * move.X)
				if dir.Magnitude > 0 then dir = dir.Unit end

				flyPart.CFrame = flyPart.CFrame + dir * speed * RunService.Heartbeat:Wait()
			else
				RunService.Heartbeat:Wait()
			end
			hrp.CFrame = flyPart.CFrame
		end
	end)()
end

--UNFLY
function funcs:StopFly(player)
	if self.ActiveFlys[player] then
		self.ActiveFlys[player].Flying = false
		if self.ActiveFlys[player].Part then
			self.ActiveFlys[player].Part:Destroy()
		end
		self.ActiveFlys[player] = nil
	end
end

-- WALKSPEED
funcs.ActiveWalkspeed = {}

function funcs:SetWalkspeed(player, speed)
	speed = tonumber(speed) or 40

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if self.ActiveWalkspeed[player] then
		self.ActiveWalkspeed[player].Running = false
	end

	local data = {
		Running = true
	}

	self.ActiveWalkspeed[player] = data

	coroutine.wrap(function()
		while data.Running and player.Parent do
			local character = player.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid.WalkSpeed = speed
				end
			end
			task.wait(0.1)
		end
	end)()
end

--UNWALKSPEED
function funcs:Unwalkspeed(player)
	if self.ActiveWalkspeed[player] then
		self.ActiveWalkspeed[player].Running = false
		self.ActiveWalkspeed[player] = nil
	end

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = 16
	end
end

--FLING
function funcs:Fling(player, target)
	if not player.Character or not target.Character then return end

	local char = player.Character
	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")

	local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")

	if not root or not hum or not targetRoot then return end

	local originalCFrame = root.CFrame

	hum:ChangeState(Enum.HumanoidStateType.Physics)
	hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)

	pcall(function()
		LocalPlayer.MaximumSimulationRadius = math.huge
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
	end)

	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bv.Velocity = Vector3.zero
	bv.Parent = root

	local bav = Instance.new("BodyAngularVelocity")
	bav.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bav.AngularVelocity = Vector3.new(1e6, 1e6, 1e6)
	bav.Parent = root

	local startTime = tick()
	local lastReset = 0
	local connection

	connection = RunService.Heartbeat:Connect(function()
		if not targetRoot or not targetRoot.Parent then
			connection:Disconnect()
			return
		end

		local offset = Vector3.new(
			math.random(1,5)/100,
			math.random(1,5)/100,
			math.random(1,5)/100
		)

		root.CFrame = targetRoot.CFrame * CFrame.new(0, 0.5, 0) + offset

		if tick() - lastReset >= 1 then
			lastReset = tick()

			root.CFrame = originalCFrame
			task.wait() 
			root.CFrame = targetRoot.CFrame
		end

		if targetRoot.AssemblyLinearVelocity.Magnitude <= 300 then
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end

		if tick() - startTime > 2 then
			connection:Disconnect()
		end
	end)

	task.wait(2)

	if connection then
		connection:Disconnect()
	end

	if bv then bv:Destroy() end
	if bav then bav:Destroy() end

	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero

	root.CFrame = originalCFrame

	hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
end

return funcs
