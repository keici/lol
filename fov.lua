local function getsenvv(scr)
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

getsenvv(game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client).defaultfov = 120
