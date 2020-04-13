local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" then
        if self.Name == "BURNME" then 
            return nil
        end
        if self.Name == "FallDamage" then 
            return nil
        end
    end
    return old(self, ...)
end)

setreadonly(mt, true)