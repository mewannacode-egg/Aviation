local Players = game:GetService("Players")

local cmds = require(script.Parent.cmds)

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		cmds:Execute(player, msg)
	end)
end)
