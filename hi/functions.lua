function drawsquare()
    local square = Drawing.new("Square")
    square.Thickness = 1
    square.Filled = false
    square.Transparency = 1
    square.Color = Color3.fromRGB(255, 255, 255)
    return square
end

function drawtext()
    local text = Drawing.new("Text")
    text.Transparency = 1
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.Color = Color3.fromRGB(255, 255, 255)
    return text
end

function drawcircle()
    local circle = Drawing.new("Circle")
    circle.Transparency = 1
    circle.Thickness = 1
    circle.Filled = false
    return circle
end

local settings = poop.settings
local services = poop.services
local links = poop.links
local Carti = poop.Carti

function createesp(player, box, name)
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

function translatetoen(m)
	local str 
	local getlang = syn.request({
		Url = links.detlan..links.trkey.."&text="..services.Http:UrlEncode(m),
		Method = "GET"
	})
	local lang = services.Http:JSONDecode(getlang.Body).lang
	if lang then
		local message = syn.request({
			Url = links.tr..links.trkey.."&text="..services.Http:UrlEncode(m).."&lang="..lang.."-en",
			Method = "GET"
		})
		str = services.Http:JSONDecode(message.Body).text[1]
	end
	return str or ""
end

function translate(m, n)
	local message = syn.request({
		Url = links.tr..links.trkey.."&text="..services.Http:UrlEncode(m).."&lang=en-"..n,
		Method = "GET"
	})
	return services.Http:JSONDecode(message.Body).text[1]
end

function emojiutf(emoji)
	local str = ""
	local a = emoji:gsub("%w", "")
	for i,v in utf8.codes(a) do
		str = str..v..","
	end
	str = str:sub(1, -1)
	return str
end

function getemojis()
	local emojis = {}

	local get = syn.request({
		Url = links.emojis.."?"..links.emojikey,
		Method = "GET"
	})

	for i,v in pairs(services.Http:JSONDecode(get.Body)) do
		for i2,v2 in pairs(v) do
			if i2 == "character" then
				table.insert(emojis, v2)
			end
		end
	end

	return emojis
end

function utfemoji(num)
	return utf8.char(num)
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