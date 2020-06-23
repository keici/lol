getgenv().poop = {}

poop.services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    UIS = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    Http = game:GetService("HttpService")
}

poop.Carti = {
    LP = poop.services.Players.LocalPlayer,
    Mouse = poop.services.Players.LocalPlayer:GetMouse(),
    Camera = workspace.CurrentCamera
}

poop.Yo = {
    chatremote = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
}

poop.links = {
    tr = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=",
    detlan = "https://translate.yandex.net/api/v1.5/tr.json/detect?key=",
    trkey = "trnsl.1.1.20170410T181107Z.c28a1db45d8068d6.901d5ce86397ef466ed8dda0bbc6582bc840cda7", -- thx aim :D
    emojis = "https://emoji-api.com/emojis",
    emojikey = "access_key=78bbd9ae0e6f81f89e6eedf375ec4fb77c2a40b5"
}

poop.languages = {afrikaans = "af",albanian = "sq",amharic = "am",arabic = "ar",armenian = "hy",azerbaijani = "az",bashkir = "ba",basque = "eu",belarusian = "be",bengal = "bn",bosnian = "bs",bulgarian = "bg",burmese = "my",catalan = "ca",cebuano = "ceb",chinese = "zh",croatian = "hr",czech = "cs",danish = "da",dutch = "nl",english = "en",esperanto = "eo",estonian = "et",finnish = "fi",french = "fr",galician = "gl",georgian = "ka",german = "de",greek = "el",gujarati = "gu",creole = "ht",hebrew = "he",hillmari = "mrj",hindi = "hi",hungarian = "hu",icelandic = "is",indonesian = "id",irish = "ga",italian = "it",japanese = "ja",javanese = "jv",kannada = "kn",kazakh = "kk",khmer = "km",kirghiz = "ky",korean = "ko",laotian = "lo",latin = "la",latvian = "lv",lithuanian = "lt",luxembourg = "lb",macedonian = "mk",malagasy = "mg",malayalam = "ml",malay = "ms",maltese = "mt",maori = "mi",marathi = "mr",mari = "mhr",mongolian = "mn",nepalese = "ne",norwegian = "no",papiamento = "pap",persian = "fa",polish = "pl",portuguese = "pt",punjabi = "pa",romanian = "ro",russian = "ru",scottish = "gd",serbian = "sr",sinhalese = "si",slovak = "sk",slovenian = "sl",spanish = "es",sundanese = "su",swahili = "sw",swedish = "sv",tagalog = "tl",tajik = "tg",tamil = "ta",tartar = "tt",telugu = "te",thai = "th",turkish = "tr",udmurt = "udm",ukrainian = "uk",urdu = "ur",uzbek = "uz",vietnamese = "vi",welsh = "cy",xhosa = "xh",yiddish = "yi"}
poop.languagelist = {}

for i,v in pairs(poop.languages) do
    table.insert(poop.languagelist, i)
end

poop.getsenvv = function(scr) -- script.Disabled meme
    for i,v in pairs(getgc()) do
        if getfenv(v).script == scr then
            return getfenv(v) or {}
        end
    end
end

--load in main functions
loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/functions.lua"))()

poop.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/zypherlib.lua"))()
poop.settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/keici/lol/master/hi/settings.lua"))()
poop.main = poop.library:CreateMain("Poggers")

poop.aim =  poop.main:CreateCategory("Aim") -- aim


poop.esp = poop.main:CreateCategory("ESP") -- ESP

poop.eplayers = poop.esp:CreateSection("Players")
poop.eplayers:Create("Toggle", "Enable ESP", function(state) poop.settings.ESPEnabled = state end)
poop.eplayers:Create("Toggle", "Box ESP", function(state) poop.settings.BoxESPEnabled = state end)
poop.eplayers:Create("Toggle", "Name ESP", function(state) poop.settings.NameESPEnabled = state end)

poop.misc = poop.main:CreateCategory("Misc") -- misc

poop.chats = poop.misc:CreateSection("Chat")
poop.chats:Create("Toggle", "Enable", function(state) poop.settings.ChatEnabled = state end)
poop.chats:Create("Dropdown", "Language", function(val) poop.settings.ChatLanguage = poop.languages[val] end, {options = poop.languagelist, search = true})
poop.chats:Create("Textbox", "Message", function(val) if poop.settings.ChatEnabled then poop.Yo.chatremote:FireServer(translate(val, poop.settings.ChatLanguage),"All") end end, {text = "Poggers"})
poop.chats:Create("Dropdown", "Emojis", function(val) if poop.settings.ChatEnabled then poop.Yo.chatremote:FireServer(val,"All") end end, {options = getemojis()})

-- ui toggler
poop.services.UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Insert and not gpe then 
        poop.services.CoreGui.Poggers.Enabled = not poop.services.CoreGui.Poggers.Enabled
    end
end)


