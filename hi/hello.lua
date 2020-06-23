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

poop.getsenvv = function(scr) -- script.Disabled meme
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

poop.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/zypherlib.lua"))()
poop.settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/settings.lua"))()
poop.main = poop.library:CreateMain("Poggers")

poop.esp = poop.main:CreateCategory("ESP") -- ESP
poop.eplayers = poop.esp:CreateSection("Players")
poop.eplayers:Create("Toggle", "Enable ESP", function(state) poop.settings.ESPEnabled = state end)
poop.eplayers:Create("Toggle", "Box ESP", function(state) poop.settings.BoxESPEnabled = state end)
poop.eplayers:Create("Toggle", "Name ESP", function(state) poop.settings.NameESPEnabled = state end)


poop.services.UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Insert and not gpe then 
        poop.services.CoreGui.Poggers.Enabled = not poop.services.CoreGui.Poggers.Enabled
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/functions.lua"))()