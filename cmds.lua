return function(funcs)

	local cmds = {}
	cmds.Prefix = "-"

	cmds.List = {

		goto = {
			Code = [[
				local targetName = args[1]
				if not targetName then return end

				local targets = funcs:GetPlayers(args[1], player)

                for _, target in ipairs(targets) do
	                funcs:Goto(player, target)
                end
			
				end
			]]
		},

		fly = {
			Code = [[
				local speed = tonumber(args[1]) or 40
				funcs:StartFly(player, speed)
			]]
		},

		unfly = {
			Code = [[
				funcs:StopFly(player)
			]]
		},

	}

	function cmds:Run(player, msg)
		if msg:sub(1,1) ~= self.Prefix then return end

		local args = {}
		for word in msg:gmatch("%S+") do
			table.insert(args, word)
		end

		local cmdName = args[1]:sub(2):lower()
		table.remove(args, 1)

		local cmd = self.List[cmdName]
		if not cmd then return end

		local src = [[
			return function(player, args, funcs)
		]] .. cmd.Code .. [[
			end
		]]

		local fn = loadstring(src)()
		fn(player, args, funcs)
	end

	return cmds
end
