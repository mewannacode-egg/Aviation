local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local COMMAND_PREFIX = "-"

local function loadCommands()
    local url = "https://raw.githubusercontent.com/mewannacode-egg/Aviation/main/cmds.lua"
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and type(result) == "table" then
        return result
    else
        warn("Failed to load commands:", result)
        return {}
    end
end

local Commands = loadCommands()

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        if string.sub(msg, 1, #COMMAND_PREFIX) == COMMAND_PREFIX then
            local split = string.split(msg, " ")
            local cmdName = split[1] 
            local args = {unpack(split, 2)} 

            if Commands[cmdName] then
                local success, err = pcall(function()
                    Commands[cmdName](args, player)
                end)
                if not success then
                    warn("Error running command "..cmdName..": "..tostring(err))
                end
            end
        end
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(msg)
        if string.sub(msg, 1, #COMMAND_PREFIX) == COMMAND_PREFIX then
            local split = string.split(msg, " ")
            local cmdName = split[1]
            local args = {unpack(split, 2)}
            if Commands[cmdName] then
                local success, err = pcall(function()
                    Commands[cmdName](args, player)
                end)
                if not success then
                    warn("Error running command "..cmdName..": "..tostring(err))
                end
            end
        end
    end)
end

print("Admin command system loaded. Prefix: "..COMMAND_PREFIX)
