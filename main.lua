local base = "https://raw.githubusercontent.com/mewannacode-egg/Aviation/main/"

local requestFunc = (syn and syn.request)
	or (http_request)
	or (request)
	or (fluxus and fluxus.request)
	or function(tbl)
		return {Body = game:HttpGet(tbl.Url)}
	end

local function get(url)
	local res = requestFunc({
		Url = url,
		Method = "GET"
	})
	return res.Body
end

local funcs = loadstring(get(base .. "funcs.lua"))()
local cmdsLoader = loadstring(get(base .. "cmds.lua"))()

local cmds = cmdsLoader(funcs)

local Players = game:GetService("Players")

for _, plr in ipairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		cmds:Run(plr, msg)
	end)
end

Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		cmds:Run(plr, msg)
	end)
end)
