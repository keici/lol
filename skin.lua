local plr = game.Players.LocalPlayer
local client = getsenv(plr.PlayerGui.Client)
local mt = getrawmetatable(game)
local old = mt.__namecall
local t = plr.SkinFolder.TFolder:Clone()
local ct = plr.SkinFolder.CTFolder:Clone()
plr.SkinFolder.TFolder:Destroy()
plr.SkinFolder.CTFolder:Destroy()
t.Parent = plr.SkinFolder
ct.Parent = plr.SkinFolder
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}
	if method == "InvokeServer" and self.Name == "Hugh" then
		return nil
	end
	if method == "FireServer" then
		if string.len(self.Name) == 38 then 
			return nil
		end
		if self.Name == "DataEvent" then 
			if args[1][2] == "CT" or args[1][2] == "Both" then 
				plr.SkinFolder.CTFolder[args[1][3]].Value = string.split(args[1][4][1], "_")[2]
			end
			if args[1][2] == "T" or args[1][2] == "Both" then 
				plr.SkinFolder.TFolder[args[1][3]].Value = string.split(args[1][4][1], "_")[2]
			end
		end
	end
	return old(self, unpack(args))
end)
setreadonly(mt, true)
local Skin = {}

for i,v in pairs(game.ReplicatedStorage.Skins:GetChildren()) do
	for a,b in pairs(v:GetChildren()) do
		table.insert(Skin, {v.Name.. "_".. b.Name})
	end
	table.insert(Skin, {v.Name.. "_Stock"})
end
for i,v in pairs(game.ReplicatedStorage.Gloves:GetChildren()) do 
	if v.Name == "Wraps" or v.Name == "Guts" or v.Name == "MMA" or v.Name == "Wetland" or v.Name == "Ghoul Hex" or v.Name == "Phantom Hex" or v.Name == "Spector Hex" or v.Name == "Orange Hex" or v.Name == "Purple Hex" or v.Name == "Green Hex" then 
		table.insert(Skin,{"Handwraps_"..v.Name})
	end
	if v.Name == "Scapter" or v.Name == "Patch" or v.Name == "Digital" or v.Name == "Crystal" then
		table.insert(Skin,{"Fingerless Glove_"..v.Name})
	end
	if v.Name == "Hazard" or v.Name == "Hallows" or v.Name == "Majesty" or v.Name == "Royal" or v.Name == "Weeb" or v.Name == "CottonTail" or v.Name == "RSL" then 
		table.insert(Skin,{"Sports Glove_"..v.Name})
	end
	if v.Name == "Grim" or v.Name == "Wisk" or v.Name == "Molten" or v.Name == "Kringle" or v.Name == "Racer" then 
		table.insert(Skin,{"Strapped Glove_"..v.Name})
	end
end
table.insert(Skin,{"CTKnife_Stock"})
table.insert(Skin,{"TKnife_Stock"})
client.CurrentInventory = Skin