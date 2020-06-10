local services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UIS = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui")
}

local Carti = {
    LP = services.Players.LocalPlayer,
    Mouse = services.Players.LocalPlayer:GetMouse(),
    Camera = workspace.CurrentCamera
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/zypherlib.lua"))()
local settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/settings.lua"))()

services.UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Insert and not gpe then 
        services.CoreGui.Poggers.Enabled = not services.CoreGui.Poggers.Enabled
    end
end)

-- if retard does script.Disabled lol
local function getsenvv(scr)
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

