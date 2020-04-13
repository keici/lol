local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local Camera = workspace.CurrentCamera
local target;

local function get_nearest()
	local small = math.huge
	local closest = nil
	for i,v in pairs(plrs:GetPlayers()) do
		if v ~= plr and v.TeamColor ~= plr.TeamColor then
			if v.Character and v.Character:FindFirstChildOfClass("Humanoid") and v.Character.Humanoid.Health ~= 0 then
				local pos = Camera:WorldToScreenPoint(v.Character.Head.Position)
				local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
				if small > magnitude then
					small = magnitude
					closest = v
				end
			end
		end
	end
	return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    if get_nearest().Character then
        target = get_nearest().Character
    end
end)

local mt = getrawmetatable(game)
local oldcall = mt.__namecall
local oldin = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if t == mouse and tostring(k) == "Hit" then
        if target and target:FindFirstChild("Head") then
            return target.Head.CFrame
        end
    end
    return oldin(t, k)
end)

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
    local args = {...}
    
	if method == "FindPartOnRayWithIgnoreList" then 
		args[1] = Ray.new(workspace.CurrentCamera.CFrame.Position, (target.Head.CFrame.p - workspace.CurrentCamera.CFrame.Position).unit * 1000
    end
    
	return oldcall(self, unpack(args))
end)
setreadonly(mt, true)