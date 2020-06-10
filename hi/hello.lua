local services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UIS = game:GetService("UserInputService"),
    RunService = game:GetService("RunService")
}

local Carti = {
    LP = services.Players.LocalPlayer,
    Mouse = services.Players.LocalPlayer:GetMouse(),
    Camera = workspace.CurrentCamera
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/zypherlib.lua"))()
local settings = loadstring(game:HttpGet(""))()

local function getsenvv(scr)
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

