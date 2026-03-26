local funcs = require(script.Parent.funcs)

local cmds = {}

cmds.Prefix = "-"

cmds.List = {

	goto = {
		Description = "Teleport to a player",
		
		Run = function(player, args)
			local targetName = args[1]
			if not targetName then return end

			local target = funcs:GetPlayerFromString(targetName)
			if target then
				funcs:GotoPlayer(player, target)
			end
		end
	}

}

function cmds:Execute(player, message)
	if string.sub(message, 1, 1) ~= self.Prefix then return end

	local args = {}
	for word in string.gmatch(message, "%S+") do
		table.insert(args, word)
	end

	local commandName = string.sub(args[1], 2)
	table.remove(args, 1)

	local command = self.List[commandName]
	if not command then return end

	local code = [[
		return function(player, args, command)
			command.Run(player, args)
		end
	]]

	local func = loadstring(code)()
	func(player, args, command)
end

return cmds
