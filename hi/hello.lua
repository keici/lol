getgenv().poop = {}

poop.services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UIS = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui")
}

poop.Carti = {
    LP = poop.services.Players.LocalPlayer,
    Mouse = poop.services.Players.LocalPlayer:GetMouse(),
    Camera = workspace.CurrentCamera
}

poop.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/zypherlib.lua"))()
poop.settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/settings.lua"))()

poop.getfeature = function(name)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/features/"..name..".lua"))()
end

poop.main = poop.library:CreateMain("Poggers")

poop.esp = poop.main:CreateCategory("ESP")
poop.eplayers = poop.esp:CreateSection("Players")



poop.services.UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Insert and not gpe then 
        services.CoreGui.Poggers.Enabled = not services.CoreGui.Poggers.Enabled
    end
end)

-- if retard does script.Disabled lol
poop.getsenvv = function(scr)
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

local bruh = poop.getfeature("esp")