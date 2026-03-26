return function(funcs)

	local cmds = {}
	cmds.Prefix = "-"

	cmds.Commands = {

		goto = {
			Code = [[
				local targetName = args[1]
				if not targetName then return end

				local target = funcs:GetPlayer(targetName)
				if target then
					funcs:Goto(player, target)
				end
			]]
		}

	}

	function cmds:Run(player, message)
		if message:sub(1,1) ~= self.Prefix then return end

		local args = {}
		for word in message:gmatch("%S+") do
			table.insert(args, word)
		end

		local cmdName = args[1]:sub(2):lower()
		table.remove(args, 1)

		local cmd = self.Commands[cmdName]
		if not cmd then return end

		local source = [[
			return function(player, args, funcs)
		]] .. cmd.Code .. [[
			end
		]]

		local func = loadstring(source)()
		func(player, args, funcs)
	end

	return cmds
end
