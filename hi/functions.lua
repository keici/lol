local function drawsquare()
    local square = Drawing.new("Square")
    square.Thickness = 1
    square.Filled = false
    square.Transparency = 1
    square.Color = Color3.fromRGB(255, 255, 255)
    return square
end

local function drawtext()
    local text = Drawing.new("Text")
    text.Transparency = 1
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.Color = Color3.fromRGB(255, 255, 255)
    return text
end

local function drawcircle()
    local circle = Drawing.new("Circle")
    circle.Transparency = 1
    circle.Thickness = 1
    circle.Filled = false
    return circle
end

local settings = poop.settings
local services = poop.services
local Carti = poop.Carti

local function createesp(player, box, name)
    services.RunService:BindToRenderStep(player.Name, 1, function()
        if player and player.TeamColor ~= Carti.LP.TeamColor then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
                local pos, vis = Carti.Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                local top = Carti.Camera:WorldToViewportPoint(player.Character.Head.Position)
                local bottom = Carti.Camera:WorldToViewportPoint(player.Character.LeftFoot.Position)
                if vis then
                    box.Size = Vector2.new(2000/pos.Z, top.Y - bottom.Y)
                    box.Position = Vector2.new(pos.X - box.Size.X/2, pos.Y - box.Size.Y/2)

                    name.Text = player.Name
                    name.Position = Vector2.new(pos.X, (pos.Y + box.Size.Y/2) - 20)

                    box.Visible = settings.BoxESPEnabled and settings.ESPEnabled
                    name.Visible = settings.NameESPEnabled and settings.ESPEnabled
                else
                    box.Visible = false
                    name.Visible = false
                end
            else
                box.Visible = false
                name.Visible = false
            end
        else
            box.Visible = false
            name.Visible = false
        end
    end)
end

for i,v in pairs(services.Players:GetPlayers()) do
    if v ~= Carti.LP and v.TeamColor ~= Carti.LP.TeamColor then
        createesp(v, drawsquare(), drawtext())
    end
end

services.Players.PlayerAdded:Connect(function(player)
    createesp(player, drawsquare(), drawtext())
end)

services.Players.PlayerRemoving:Connect(function(player)
    services.RunService:UnbindFromRenderStep(player.Name)
end)