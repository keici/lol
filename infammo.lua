local rel;

for i,v in pairs(getgc()) do
    if debug.getinfo(v).name == "reloadwep" then 
        rel = v 
    end
end

while true do
    debug.setupvalue(rel, 10, 999)
    wait()
end