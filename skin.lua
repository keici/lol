local Players = game:GetService("Players")
local RepStor = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Client = getsenv(Player.PlayerGui.Client)
local MT = getrawmetatable(game)
local OldN = MT.__namecall
local Skins = {}

for i,v in pairs(RepStor.Gloves:GetChildren()) do
	if v.Name ~= "Models" and v:IsA("Folder") then
		for i2,v2 in pairs(v:GetChildren()) do
			table.insert(Skins, {v.Name.."_"..v2.Name})
		end
	end
end

for i,v in pairs(RepStor.Skins:GetChildren()) do
	for i2,v2 in pairs(v:GetChildren()) do
		table.insert(Skins, {v.Name.."_"..v2.Name})
	end	
end

table.insert(Skins,{"CTKnife_Stock"})
table.insert(Skins,{"TKnife_Stock"})

setreadonly(MT, false)

MT.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	if method == "InvokeServer" then
		if self.Name == "Hugh" then
			return nil
		end
	end
	if method == "FireServer" then
		if string.len(self.Name) == 38 then 
			return nil
		end
		if self.Name == "DataEvent" and args[1][4] then 
			if args[1][2] == "CT" or args[1][2] == "Both" then 
				Player.SkinFolder.CTFolder[args[1][3]].Value = string.split(args[1][4][1], "_")[2]
			end
			if args[1][2] == "T" or args[1][2] == "Both" then 
				Player.SkinFolder.TFolder[args[1][3]].Value = string.split(args[1][4][1], "_")[2]
			end
		end
	end

	return OldN(self, unpack(args))
end)

setreadonly(MT, true)

Client.CurrentInventory = Skins
