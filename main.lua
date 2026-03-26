local base = "https://raw.githubusercontent.com/mewannacode-egg/Aviation/main/"

local funcs = loadstring(game:HttpGet(base .. "funcs.lua"))()
local cmdsLoader = loadstring(game:HttpGet(base .. "cmds.lua"))()

local cmds = cmdsLoader(funcs)

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		cmds:Run(player, msg)
	end)
end)
