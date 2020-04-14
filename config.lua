local Config = {}
local wfile = writefile
local isfold = isfolder 
local isfile = isfile 
local dfile = delfile
local rfile = readfile

function Config:Create(folder, name, content)
    if not isfold(folder) then 
        makefolder(folder)
    end
    local text = "{"
    if name and content and not isfile(folder.."/"..name..".cfg") then 
        if type(content) == "table" then
            for i,v in pairs(content) do
                text = "\t"..text.."["..i.."]".." = "..tostring(v)..",\n"
            end
        end
    end
    text = text.."}"
    wfile(folder.."/"..name..".cfg", text)
end

function Config:Rename(folder, old, new)
    if isfile(folder.."/"..old..".cfg") and not isfile(folder.."/"..new..".cfg") then
        local content = rfile(folder.."/"..old..".cfg")
        dfile(folder.."/"..old..".cfg")
        wfile(folder.."/"..new..".cfg", content)
    end
end

function Config:Load(folder, file, cfg)
    if isfile(folder.."/"..file..".cfg") and cfg then
        cfg = rfile(folder.."/"..file..".cfg")
    end
end

function Config:Save(folder, file, cfg)
    if isfile(folder.."/"..file..".cfg") and cfg then 
        local content = "{"
        for i,v in pairs(cfg) do
            content = "\t"..content.."["..i.."]".." = "..tostring(v)..",\n"
        end
        content = content.."}"
        wfile(folder.."/"..file..".cfg", content)
    end
end

function Config:Delete(folder, file)
    if isfile(folder.."/"..file) then 
        dfile(folder.."/"..file..".cfg")
    end
end

return Config