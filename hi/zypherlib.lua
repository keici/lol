--[[

	  _____                  _
	 |__  /  _   _   _ __   | |__     ___   _ __
	   / /  | | | | | '_ \  | '_ \   / _ \ | '__|
	  / /_  | |_| | | |_) | | | | | |  __/ | |
	 /____|  \__, | | .__/  |_| |_|  \___| |_|
			 |___/  |_|
			 

	Credits:
		xTheAlex14#3200 -- The UILib
		Candy#9786 -- Docs
]]

local lib = {}

function lib:Create(what, propri)
	local instance = Instance.new(what)

	for i, v in next, propri do
		if instance[i] and propri ~= "Parent" then
			instance[i] = v
		end
	end

	return instance
end

local mouse = game.Players.LocalPlayer:GetMouse()

function lib:CreateMain(projName)
    if game:GetService("CoreGui"):FindFirstChild(projName) then
		return
    end
	
    local objects = {}
    local firstCategory = true
    
    objects.Screengui = lib:Create("ScreenGui", {
        Name = projName,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
		ResetOnSpawn = false,
    })

    objects.Motherframe = lib:Create("Frame", {
        Name = "Motherframe",
        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -400, 0.5, -225),
        Size = UDim2.new(0, 700, 0, 460),
    })

    local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		objects.Motherframe:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),'Out','Linear',0.01,true)
    end
    
	objects.Motherframe.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = objects.Motherframe.Position
			repeat wait() until input.UserInputState == Enum.UserInputState.End
			dragging = false
		end
    end)
    
	objects.Motherframe.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
    end)
    
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

    objects.Upline = lib:Create("Frame", {
        Name = "Upline",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 700, 0, 4),
        ZIndex = 10,
    })

    objects.Uplinegradient = lib:Create("UIGradient", {
        Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 183, 183)), ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 248, 248)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(125, 92, 164))}
    })

    objects.Sidebar = lib:Create("Frame", {
        Name = "Sidebar",
        BackgroundColor3 = Color3.fromRGB(39, 38, 46),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 4),
        Size = UDim2.new(0, 150, 0, 456),
    })

    objects.Sidecategories = lib:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 15),
        Size = UDim2.new(0, 150, 0, 320),
    })

    objects.Categorieshandler = lib:Create("Frame", {
        Name = "Categories",
        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
        BackgroundTransparency = 1.000,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 150, 0, 4),
        Size = UDim2.new(0, 550, 0, 456),
    })
    objects.Categorieshandler.ClipsDescendants = true

	local Categorieshandlerpagelayout = lib:Create("UIPageLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        EasingDirection = Enum.EasingDirection.InOut,
        EasingStyle = Enum.EasingStyle.Quad,
        ScrollWheelInputEnabled = false,
        TweenTime = 0.700,
	})

	Categorieshandlerpagelayout.Parent = objects.Categorieshandler
	Categorieshandlerpagelayout = nil

    objects.Categoriesselector = lib:Create("ImageLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0, 7, 0, 15),
        Size = UDim2.new(0, 136, 0, 32),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(49, 49, 59),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.060,
    })

    categoriesdistance = 35
    categoriescounter = 0

    function objects:CreateCategory(Name, Image)
        local categories = {}

        if Image then
		categories.imagebutton = lib:Create("ImageButton", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 6, 0, categoriescounter),
            Size = UDim2.new(0, 30, 0, 30),
            ZIndex = 4,
            AutoButtonColor = false,
            Image = "http://www.roblox.com/asset/?id="..Image,
        })
        elseif not Image then
            categories.imagebutton = lib:Create("ImageButton", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Position = UDim2.new(0, -20, 0, categoriescounter),
                ImageTransparency = 1,
                Size = UDim2.new(0, 30, 0, 30),
                ZIndex = 4,
                AutoButtonColor = false,
            })            
        end
        
		categoriescounter = categoriescounter+categoriesdistance

		categories.button = lib:Create("TextButton", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 35, 0, 0),
            Size = UDim2.new(0, 70, 0, 30),
            ZIndex = 4,
            Font = Enum.Font.GothamBold,
            Text = Name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 18.000,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        categories.container = lib:Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 550, 0, 456),
            BackgroundTransparency = 1,
        })

        categories.scrollingframe = lib:Create("ScrollingFrame", {
            Active = true,
            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1.33849028e-07, 0),
            Size = UDim2.new(1, 0, -0.008772064, 460),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 1,
        })

        categories.containerhider = lib:Create("Frame", {
            Name = "Hider",
            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 550, 0, 456),
            BackgroundTransparency = 0,
            ZIndex = 2,
        })

        local SectionsUIListLayout = lib:Create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 20),
        })

        SectionsUIListLayout.Parent = categories.scrollingframe
        SectionsUIListLayout = nil

        local SectionsUIPadding = lib:Create("UIPadding", {
            PaddingLeft = UDim.new(0, 25),
            PaddingTop = UDim.new(0, 20),
        })

        SectionsUIPadding.Parent = categories.scrollingframe
        SectionsUIPadding = nil

        if firstCategory then
            categories.containerhider.BackgroundTransparency = 1
            categories.container.BackgroundTransparency = 0
        end
        
        if Image then

		categories.imagebutton.MouseButton1Click:connect(function()
			objects.Categoriesselector:TweenPosition(categories.imagebutton.Position + UDim2.new(0,1,0,15), "Out", "Linear", 0.08)
			for i,v in pairs(objects.Categorieshandler:GetChildren()) do
                if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(v.ScrollingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				end
			end
			game:GetService("TweenService"):Create(categories.containerhider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            game:GetService("TweenService"):Create(categories.container, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
            game:GetService("TweenService"):Create(categories.scrollingframe, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

			objects.Categorieshandler["UIPageLayout"]:JumpTo(categories.container)
		end)

		categories.button.MouseButton1Click:connect(function()
			objects.Categoriesselector:TweenPosition(categories.imagebutton.Position + UDim2.new(0,1,0,15), "Out", "Linear", 0.08)
			for i,v in pairs(objects.Categorieshandler:GetChildren()) do
                if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(v.ScrollingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				end
			end
			game:GetService("TweenService"):Create(categories.containerhider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            game:GetService("TweenService"):Create(categories.container, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
            game:GetService("TweenService"):Create(categories.scrollingframe, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

			objects.Categorieshandler["UIPageLayout"]:JumpTo(categories.container)
        end)
    
        else

            categories.imagebutton.MouseButton1Click:connect(function()
                objects.Categoriesselector:TweenPosition(categories.imagebutton.Position + UDim2.new(0,27,0,15), "Out", "Linear", 0.08)
                for i,v in pairs(objects.Categorieshandler:GetChildren()) do
                    if v:IsA("Frame") then
                        game:GetService("TweenService"):Create(v.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                        game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                        game:GetService("TweenService"):Create(v.ScrollingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    end
                end
                game:GetService("TweenService"):Create(categories.containerhider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(categories.container, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                game:GetService("TweenService"):Create(categories.scrollingframe, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    
                objects.Categorieshandler["UIPageLayout"]:JumpTo(categories.container)
            end)
    
            categories.button.MouseButton1Click:connect(function()
                objects.Categoriesselector:TweenPosition(categories.imagebutton.Position + UDim2.new(0,27,0,15), "Out", "Linear", 0.08)
                for i,v in pairs(objects.Categorieshandler:GetChildren()) do
                    if v:IsA("Frame") then
                        game:GetService("TweenService"):Create(v.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                        game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                        game:GetService("TweenService"):Create(v.ScrollingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    end
                end
                game:GetService("TweenService"):Create(categories.containerhider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(categories.container, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                game:GetService("TweenService"):Create(categories.scrollingframe, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    
                objects.Categorieshandler["UIPageLayout"]:JumpTo(categories.container)
            end)
        end

        function categories:CreateSection(Name)
            local sections = {}
            
            sections.container = lib:Create("ImageLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Size = UDim2.new(0, 500, 0, 40),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(39, 38, 46),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.100,
            })

            sections.containername = lib:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 3),
                Size = UDim2.new(0, 200, 0, 28),
                Font = Enum.Font.GothamBold,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 18.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,30)
            categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,40)

            sections.containerthings = lib:Create("ImageLabel", {
                Active = true,
                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                BackgroundTransparency = 1.000,
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                BorderSizePixel = 0,
                Selectable = true,
                Size = UDim2.new(0, 500, 0, 0),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Color3.fromRGB(29, 29, 35),
                ImageTransparency = 1.000,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.100,
            })

            local ctuilist = lib:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10),
            })
            ctuilist.Parent = sections.containerthings
            ctuilist = nil

            local ctuipadd = lib:Create("UIPadding", {
                PaddingLeft = UDim.new(0, 10)
            })
            ctuipadd.Parent = sections.containerthings
            ctuipadd = nil 

            counter = 0
            
            pcall(function()
                for i,v in pairs(sections.containerthings:GetChildren()) do 
                    if not v:IsA("UIListLayout") or not v:IsA("UIPadding") then
                        counter = counter + 1
                    end
                end

                if counter ~= 1 then 
                    sections.containerthings.Size = sections.containerthings.Size - UDim2.new(0,0,0,10)
                    sections.container.Size = sections.container.Size - UDim2.new(0,0,0,10)
                end
            end)

            function sections:Create(Type, Name, CallBack, Others)
				local things = {}
				things.value = nil

                if Type then 
                    if string.lower(Type) == "button" or string.lower(Type) == "btn" then
                        things.buttonframe = lib:Create("Frame", {
                            Name = "Button",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Size = UDim2.new(0, 480, 0, 30), 
                        })
                        things.button = lib:Create("ImageButton", {
                            Name = "Button",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Size = UDim2.new(0, 480, 0, 30),
                            AutoButtonColor = false,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            Position = UDim2.new(0,240,0,15),
                            SliceScale = 0.080,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                        })

                        things.buttontext = lib:Create("TextLabel", {
                            Name = "ButtonText",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.300000012, 0, 0, 0),
                            Size = UDim2.new(0, 200, 1, 0),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                        })

                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,40)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,40)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,40)

                        things.buttonframe.Parent = sections.containerthings
                        things.button.Parent = things.buttonframe
                        things.buttontext.Parent = things.button

                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)
                        

                        things.button.MouseButton1Click:Connect(function()
                            if Others then
                                if Others.animated then
                                    game:GetService("TweenService"):Create(things.button, TweenInfo.new(0.1), {Size = UDim2.new(0, 460, 0, 28)}):Play()
                                    wait(.1)
                                    game:GetService("TweenService"):Create(things.button, TweenInfo.new(0.1), {Size = UDim2.new(0, 480, 0, 30)}):Play()
                                end
                            end
                            
                            if CallBack then 
                                CallBack()
                            end
                        end)

                    elseif string.lower(Type) == "toggle" or string.lower(Type) == "switch" then
                        things.toggleb = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 11, 0, 80),
                            Size = UDim2.new(0, 480, 0, 35),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.toggletext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 4, 0, 2),
                            Size = UDim2.new(0, 200, 0, 30),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })

                        things.toggle = lib:Create("ImageLabel", {
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 416, 0, 2),
                            Selectable = true,
                            Size = UDim2.new(0, 56, 0, 26),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(20, 20, 20),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.toggleonoff = lib:Create("ImageLabel", { 
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 2, 0, 3),
                            Size = UDim2.new(0, 26, 0, 20),
                            Image = "rbxassetid://3570695787",
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.060,
                        })

                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,45)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,45)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,45)

                        things.toggleb.Parent = sections.containerthings
                        things.toggletext.Parent = things.toggleb
                        things.toggle.Parent = things.toggletext
                        things.toggleonoff.Parent = things.toggle

                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                        if Others then 
                            if Others.default then 
                                things.value = true
                                game:GetService("TweenService"):Create(things.toggleonoff, TweenInfo.new(0.05), {Position = UDim2.new(1, -28,0, 3)}):Play()
                                if CallBack then
                                    CallBack(things.value)
                                end
                            end
                        end

                        things.toggleb.MouseButton1Click:Connect(function()
                            things.value = not things.value

                            if CallBack then
                                CallBack(things.value)
                            end

                            if things.value then 
                                game:GetService("TweenService"):Create(things.toggleonoff, TweenInfo.new(0.1), {Position = UDim2.new(1, -28,0, 3)}):Play()
                            else
                                game:GetService("TweenService"):Create(things.toggleonoff, TweenInfo.new(0.1), {Position = UDim2.new(0, 2,0, 3)}):Play()
                            end
                        end)
                    elseif string.lower(Type) == "slider" then 
                        things.sliderback = lib:Create("ImageLabel", {
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 11, 0, 125),
                            Selectable = true,
                            Size = UDim2.new(0, 480, 0, 50),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.slidertext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 4, 0, 2),
                            Size = UDim2.new(0, 200, 0, 30),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })

                        things.slider = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 0, 0, 30),
                            Size = UDim2.new(0, 464, 0, 10),
                            AutoButtonColor = false,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(20, 20, 20),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                            ZIndex = 2,
                        })

                        things.sliderinner = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 0, 0.1, 0),
                            Size = UDim2.new(0, 0, 1, -2),
                            ZIndex = 4,
                            Image = "rbxassetid://3570695787",
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        local min = Others.min or 0
                        local max = Others.max or 1

                        things.slideramount = lib:Create("TextBox", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 436, 0, 0),
                            Size = UDim2.new(0, 30, 1, 0),
                            Font = Enum.Font.GothamBold,
                            Text = tostring(min),
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                        })

                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,60)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,60)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,60)

                        things.sliderback.Parent = sections.containerthings
                        things.slidertext.Parent = things.sliderback
                        things.slider.Parent = things.slidertext
                        things.slideramount.Parent = things.slidertext
                        things.sliderinner.Parent = things.slider

                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                        things.value = 0

                        if Others then
                            if Others.default and Others.default <= max then
                                things.slideramount.Text = Others.default
                                things.value = Others.default
                                local s = Others.default / Others.max
                                game:GetService("TweenService"):Create(things.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(s, 0, 1, -2)}):Play()
                                if CallBack then
                                    CallBack(things.value)
                                end
                            end
                        end

                        things.slider.MouseButton1Down:Connect(function()
                            local moveconnection = game:GetService("RunService").Heartbeat:Connect(function()
                                local s = math.clamp(mouse.X - things.slider.AbsolutePosition.X,0,things.slider.AbsoluteSize.X) / things.slider.AbsoluteSize.X
                                if Others.precise then
                                things.value = string.format("%.1f", min + ((max-min) * s))
                                else
                                things.value = math.floor(min + ((max-min) * s))
                                end
                                things.slideramount.Text = tostring(things.value)

                                if CallBack then
                                    CallBack(things.value)
                                end

                                game:GetService("TweenService"):Create(things.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(s, 0, 1, -2)}):Play()
                            end)
                            game:GetService("UserInputService").InputEnded:Connect(function(Check)
                                if Check.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if moveconnection then
                                        moveconnection:Disconnect()
                                        moveconnection = nil
                                    end
                                end
                            end)
                            
                        end)

                        if Others then
                            if Others.changablevalue then
                            things.slideramount:GetPropertyChangedSignal("Text"):Connect(function()
                                if not moveconnection then  
                                    things.slideramount.Text = string.gsub(things.slideramount.Text,"[^%-%d]","")
                                    local value = tonumber(things.slideramount.Text)
                                    if value ~= nil and value >= min and value <= max then
                                        local new = value / max
                                        things.value = value
                                        if CallBack then
                                            CallBack(things.value)
                                        end
                                        game:GetService("TweenService"):Create(things.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(new, 0, 1, -2)}):Play()
                                    elseif value ~= nil and value < min then 
                                        value = min
                                        local new = value / max
                                        things.slideramount.Text = min
                                        things.value = value
                                        if CallBack then
                                            CallBack(things.value)
                                        end
                                        game:GetService("TweenService"):Create(things.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(new, 0, 1, -2)}):Play()
                                    elseif value ~= nil and value > max then
                                        value = max
                                        local new = value / max
                                        things.slideramount.Text = max
                                        things.value = value
                                        if CallBack then
                                            CallBack(things.value)
                                        end
                                        game:GetService("TweenService"):Create(things.sliderinner, TweenInfo.new(0.05), {Size = UDim2.new(new, 0, 1, -2)}):Play()
                                    end
                                end
                            end)
                            things.slideramount.FocusLost:Connect(function()
                                if things.slideramount.Text == "" then
                                    things.slideramount.Text = min
                                    things.value = min
                                end
                            end)
                            end
                        end

                    elseif string.lower(Type) == "textbox" then
                        if Others then 
                            if Others.text then 
                                things.value = Others.text
                            end
                        end

                        things.textboxb = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 480, 0, 35),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.100,
                        })

                        things.textboxtext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 4, 0, 2),
                            Size = UDim2.new(0, 200, 0, 30),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })
                        
                        things.textboxbb = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 292, 0, 2),
                            Size = UDim2.new(0, 180, 0, 26),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(20, 20, 20),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.textbox = lib:Create("TextBox", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0.0500000007, 0, 0.0384615399, 0),
                            Size = UDim2.new(0.899999976, 0, 0.899999976, 0),
                            Font = Enum.Font.GothamBold,
                            Text = things.value,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 2,
                        })

                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,45)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,45)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,45)

                        things.textboxb.Parent = sections.containerthings
                        things.textboxtext.Parent = things.textboxb
                        things.textboxbb.Parent = things.textboxtext
                        things.textbox.Parent = things.textboxbb

                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)
                        
						things.textbox.FocusLost:Connect(function()
							things.value = things.textbox.Text

                            if CallBack then
                                CallBack(things.value)
                            end
                        end)
                    elseif string.lower(Type) == "keybind" then
                        things.keybindb = lib:Create("ImageLabel", {
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 11, 0, 80),
                            Selectable = true,
                            Size = UDim2.new(0, 480, 0, 35),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })
                        things.keybindtext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 4, 0, 2),
                            Size = UDim2.new(0, 200, 0, 30),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })
                        things.keybind = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 375, 0, 2),
                            Size = UDim2.new(0, 97, 0, 26),
                            AutoButtonColor = false,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(20, 20, 20),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })
                        things.keybindvalue = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.344246238, 0, 0, 0),
                            Size = UDim2.new(0, 30, 1, 0),
                            Font = Enum.Font.GothamBold,
                            Text = "...",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 16
                        })
                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,45)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,45)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,45)

                        things.keybindb.Parent = sections.containerthings
                        things.keybindtext.Parent = things.keybindb
                        things.keybind.Parent = things.keybindtext
                        things.keybindvalue.Parent = things.keybind

                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                        local c
                        local bind

                        if Others then
                            if Others.default then 
                                bind = Others.default
                                things.keybindvalue.Text = bind.Name
                            end
                        end

                        things.keybind.MouseButton1Click:Connect(function()
                            things.keybindvalue.Text = "..."
                            c = game:GetService("UserInputService").InputBegan:Connect(function(i)
                                if i.UserInputType.Name == "Keyboard" and i.KeyCode ~= Enum.KeyCode.Backspace then
                                    things.keybindvalue.Text = i.KeyCode.Name
                                    bind = i.KeyCode
                                    if c then
                                        c:Disconnect()
                                        c = nil
                                    end
                                elseif i.KeyCode == Enum.KeyCode.Backspace then
                                    things.keybindvalue.Text = "..."
                                    bind = nil
                                    if c then
                                        c:Disconnect()
                                        c = nil
                                    end
                                end
                            end)
                        end)

                        game:GetService("UserInputService").InputBegan:Connect(function(i, GPE)
							if bind and i.KeyCode == bind and not GPE and not c then
								if CallBack then
									CallBack(i.KeyCode)
								end
							end
						end)
                    elseif string.lower(Type) == "dropdown" then
                        
                        if Others and not Others.search then
                            if Others then
                                if Others.default then
                                    things.value = Others.default
                                elseif not Other.default and Others.options then
                                    things.value = Others.options[1]
                                end
                            end

                            local options

                            if Others then
                                if Others.options then
                                    options = Others.options
                                end
                            end 

                            things.dropdown = lib:Create("ImageButton", {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                Position = UDim2.new(0, 11, 0, 40),
                                Size = UDim2.new(0, 480, 0, 30),
                                AutoButtonColor = false,
                                Image = "rbxassetid://3570695787",
                                ImageColor3 = Color3.fromRGB(29, 29, 35),
                                ScaleType = Enum.ScaleType.Slice,
                                SliceCenter = Rect.new(100, 100, 100, 100),
                                SliceScale = 0.080,
                            })

                            things.arrow = lib:Create("ImageLabel", {
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0.940401852, 0, 0.0333333351, 0),
                                Rotation = 90.000,
                                Selectable = true,
                                Size = UDim2.new(0, 28, 0, 28),
                                Image = "http://www.roblox.com/asset/?id=5053304305",
                            })

                            things.selected = lib:Create("TextLabel", {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 1.000,
                                BorderSizePixel = 0,
                                Position = UDim2.new(0.300000012, 0, 0, 0),
                                Size = UDim2.new(0, 200, 1, 0),
                                Font = Enum.Font.GothamBold,
                                Text = tostring(things.value),
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 18.000,
                            })

                            things.listb = lib:Create("ImageLabel", {
                                Visible = false,
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                Position = UDim2.new(0, 0, 0, 33),
                                Selectable = true,
                                Size = UDim2.new(0, 480, 0, 120),
                                ZIndex = 2,
                                Image = "rbxassetid://3570695787",
                                ImageColor3 = Color3.fromRGB(29, 29, 35),
                                ImageTransparency = 0.100,
                                ScaleType = Enum.ScaleType.Slice,
                                SliceCenter = Rect.new(100, 100, 100, 100),
                                SliceScale = 0.080,
                            })
                            things.list = lib:Create("ScrollingFrame", {
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(29, 29, 35),
                                BackgroundTransparency = 1.000,
                                BorderSizePixel = 0,
                                Size = UDim2.new(1, 0, 1, 0),
                                ZIndex = 2,
                                ScrollBarThickness = 4,
                                ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
                                CanvasSize = UDim2.new(1,0,1,0)
                            })

                            local tlistlayout = lib:Create("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 0)
                            })

                            tlistlayout.Parent = things.list
                            tlistlayout = nil

                            sections.container.Size = sections.container.Size + UDim2.new(0,0,0,40)
                            sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,40)
                            categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,40)

                            things.dropdown.Parent = sections.containerthings
                            things.arrow.Parent = things.dropdown
                            things.selected.Parent = things.dropdown
                            things.listb.Parent = things.dropdown
                            things.list.Parent = things.listb

                            things.dropdownopen = false

                            sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                                for i,v in next, options do
                                    local button = lib:Create("ImageButton", {
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        BackgroundTransparency = 1.000,
                                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                                        Size = UDim2.new(0, 480, 0, 30),
                                        ZIndex = 2,
                                        AutoButtonColor = false,
                                        Image = "rbxassetid://3570695787",
                                        ImageColor3 = Color3.fromRGB(29, 29, 35),
                                        ImageTransparency = 0.900,
                                        ScaleType = Enum.ScaleType.Slice,
                                        SliceCenter = Rect.new(100, 100, 100, 100),
                                        SliceScale = 0.080,
                                    })

                                    local buttontext = lib:Create("TextLabel", {
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        BackgroundTransparency = 1.000,
                                        BorderSizePixel = 0,
                                        Position = UDim2.new(0.300000012, 0, 0, 0),
                                        Size = UDim2.new(0, 200, 1, 0),
                                        ZIndex = 2,
                                        Font = Enum.Font.GothamBold,
                                        Text = v,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        TextSize = 18.000,
                                    })

                                    button.Parent = things.list
                                    buttontext.Parent = button

                                    button.MouseButton1Click:Connect(function()
                                        if things.dropdownopen then
                                            things.dropdownopen = not things.dropdownopen
                                            things.selected.Text = v
                                            things.value = v

                                            if things.dropdownopen then 
                                                things.listb.Visible = true
                                                game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
                                                game:GetService("TweenService"):Create(things.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                                            else
                                                things.listb.Visible = false
                                                game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
                                            end

                                            if CallBack then
                                                CallBack(things.value)
                                            end
                                        end
                                    end)
                                end

                            things.dropdown.MouseButton1Click:Connect(function()
                                things.dropdownopen = not things.dropdownopen

                                if things.dropdownopen then 
                                    things.listb.Visible = true
                                    game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
                                    game:GetService("TweenService"):Create(things.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                                else
                                    things.listb.Visible = false
                                    game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
                                end
                                
                            end)
                        elseif Others and Others.search then
                            if Others then
                                if Others.default then
                                    things.value = Others.default
                                elseif not Others.default and Others.options then
                                    things.value = Others.options[1]
                                end
                            end

                            local options

                            if Others then
                                if Others.options then
                                    options = Others.options
                                end
                            end

                            things.dropdown = lib:Create("ImageButton", {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                Position = UDim2.new(0, 11, 0, 40),
                                Size = UDim2.new(0, 480, 0, 30),
                                AutoButtonColor = false,
                                Image = "rbxassetid://3570695787",
                                ImageColor3 = Color3.fromRGB(29, 29, 35),
                                ScaleType = Enum.ScaleType.Slice,
                                SliceCenter = Rect.new(100, 100, 100, 100),
                                SliceScale = 0.080,
                            })

                            things.arrow = lib:Create("ImageLabel", {
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                BorderSizePixel = 0,
                                Position = UDim2.new(0.940401852, 0, 0.0333333351, 0),
                                Rotation = 90.000,
                                Selectable = true,
                                Size = UDim2.new(0, 28, 0, 28),
                                Image = "http://www.roblox.com/asset/?id=5053304305",
                            })

                            things.selected = lib:Create("TextBox", {
                                Active = false,
                                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                                BackgroundTransparency = 1.000,
                                BorderSizePixel = 0,
                                Position = UDim2.new(0.300000012, 0, 0, 0),
                                Selectable = false,
                                Size = UDim2.new(0, 200, 1, 0),
                                Font = Enum.Font.GothamBold,
                                Text = tostring(things.value),
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextSize = 18.000,
                            })

                            things.listb = lib:Create("ImageLabel", {
                                Visible = false,
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                                BackgroundTransparency = 1.000,
                                BorderColor3 = Color3.fromRGB(27, 42, 53),
                                Position = UDim2.new(0, 0, 0, 33),
                                Selectable = true,
                                Size = UDim2.new(0, 480, 0, 120),
                                ZIndex = 2,
                                Image = "rbxassetid://3570695787",
                                ImageColor3 = Color3.fromRGB(29, 29, 35),
                                ImageTransparency = 0.100,
                                ScaleType = Enum.ScaleType.Slice,
                                SliceCenter = Rect.new(100, 100, 100, 100),
                                SliceScale = 0.080,
                            })
                            things.list = lib:Create("ScrollingFrame", {
                                Active = true,
                                BackgroundColor3 = Color3.fromRGB(29, 29, 35),
                                BackgroundTransparency = 1.000,
                                BorderSizePixel = 0,
                                Size = UDim2.new(1, 0, 1, 0),
                                ZIndex = 2,
                                ScrollBarThickness = 4,
                                ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
                                CanvasSize = UDim2.new(1,0,1,0)
                            })

                            local tlistlayout = lib:Create("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 0)
                            })

                            tlistlayout.Parent = things.list
                            tlistlayout = nil

                            sections.container.Size = sections.container.Size + UDim2.new(0,0,0,40)
                            sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,40)
                            categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,40)

                            things.dropdown.Parent = sections.containerthings
                            things.arrow.Parent = things.dropdown
                            things.selected.Parent = things.dropdown
                            things.listb.Parent = things.dropdown
                            things.list.Parent = things.listb

                            things.dropdownopen = false

                            sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                                for i,v in next, options do
                                    local button = lib:Create("ImageButton", {
                                        Name = string.lower(v),
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        BackgroundTransparency = 1.000,
                                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                                        Size = UDim2.new(0, 480, 0, 30),
                                        ZIndex = 2,
                                        AutoButtonColor = false,
                                        Image = "rbxassetid://3570695787",
                                        ImageColor3 = Color3.fromRGB(29, 29, 35),
                                        ImageTransparency = 0.900,
                                        ScaleType = Enum.ScaleType.Slice,
                                        SliceCenter = Rect.new(100, 100, 100, 100),
                                        SliceScale = 0.080,
                                    })

                                    local buttontext = lib:Create("TextLabel", {
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        BackgroundTransparency = 1.000,
                                        BorderSizePixel = 0,
                                        Position = UDim2.new(0.300000012, 0, 0, 0),
                                        Size = UDim2.new(0, 200, 1, 0),
                                        ZIndex = 2,
                                        Font = Enum.Font.GothamBold,
                                        Text = v,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        TextSize = 18.000,
                                    })

                                    button.Parent = things.list
                                    buttontext.Parent = button

                                    button.MouseButton1Click:Connect(function()
                                        if things.dropdownopen then
                                            things.dropdownopen = not things.dropdownopen
                                            things.selected.Text = v
                                            things.value = v

                                            if things.dropdownopen then 
                                                things.listb.Visible = true
                                                game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
                                                game:GetService("TweenService"):Create(things.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                                            else
                                                things.listb.Visible = false
                                                game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
                                            end

                                            if CallBack then
                                                CallBack(things.value)
                                            end
                                        end
                                    end)
                                end

                            things.dropdown.MouseButton1Click:Connect(function()
                                things.dropdownopen = not things.dropdownopen

                                if things.dropdownopen then 
                                    things.listb.Visible = true
                                    game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
                                    game:GetService("TweenService"):Create(things.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                                else
                                    things.listb.Visible = false
                                    game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
                                end
                                
                            end)

                            
                            local search = {}

                            for i,v in pairs(things.list:GetChildren()) do
                                if v:IsA("ImageButton") then
                                    table.insert(search, tostring(v.Name))
                                end
                            end

                            local Found = {}

                            function Edit()
                                for i in pairs(Found) do
                                    Found[i] = nil
                                end
                                for i,v in pairs(things.list:GetChildren()) do
                                    if not v:IsA("UIListLayout") then
                                        v.Visible = false
                                    end
                                end
                                things.selected.Text = string.lower(things.selected.Text)
                            end

                            function Search()
                                for i,v in pairs(search) do
                                    if string.find(v, things.selected.Text) then
                                        table.insert(Found, v)
                                    end
                                end
                                for a,b in pairs(things.list:GetChildren()) do
                                    for c,d in pairs(Found) do
                                        if d == b.Name then
                                            b.Visible = true
                                        end
                                    end
                                end
                                local Results = {}
                                local num
                                for a,b in pairs(things.list:GetChildren()) do
                                    if not b:IsA("UIListLayout") and b.Visible == true then
                                        table.insert(Results, b)
                                        for c,d in pairs(Results) do
                                            num = c
                                        end
                                    end
                                end
                                if num ~= nil then
                                    pcall(function()
                                        num = num/4
                                    end)
                                    things.list.CanvasSize = UDim2.new(0, 0, num, 0)
                                    num = 0
                                end
                            end
                            
                            local SearchLock = true
                            things.selected.Changed:connect(function()
                                if not SearchLock then
                                    Edit()
                                    Search()
                                end
                                if things.selected.Text == "" then
                                    Nil()
                                    things.list.CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)
                                end
                            end)

                            function Nil()
                                for i,v in pairs(things.list:GetChildren()) do
                                    if not v:IsA("UIListLayout") and v.Visible == false then
                                        things.list.CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)
                                        v.Visible = true
                                    end 
                                end
                            end

                            things.selected.FocusLost:connect(function()
                                SearchLock = true
                                if things.selected.Text == "" then
                                    things.list.CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)
                                    SearchLock = true
                                    Nil()
                                    things.selected.Text = "Search..."
                                end
                            end)

                            things.selected.Focused:connect(function()
                                SearchLock = false
                                things.dropdownopen = true

                                if things.dropdownopen then 
                                    things.listb.Visible = true
                                    game:GetService("TweenService"):Create(things.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
                                    game:GetService("TweenService"):Create(things.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, things.list["UIListLayout"].AbsoluteContentSize.Y)}):Play()
                                end
                            end)
                        end
                    elseif string.lower(Type) == "colorpicker" then
                        things.colorpickerb = lib:Create("ImageLabel", {
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 11, 0, 125),
                            Selectable = true,
                            Size = UDim2.new(0, 480, 0, 35),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.colorpickertext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 4, 0, 2),
                            Size = UDim2.new(0, 200, 0, 30),
                            Font = Enum.Font.GothamBold,
                            Text = Name,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 18.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })
                        things.colorpickerbutton = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 416, 0, 2),
                            Size = UDim2.new(0, 56, 0, 26),
                            AutoButtonColor = false,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(255, 0, 4),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.080,
                        })

                        things.colorpickerframe = lib:Create("Frame", {
                            Name = "colorframe",
                            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 708, 0, 0),
                            Size = UDim2.new(0, 0, 0, 205),                            
                        })
                        things.colorpickerframe.ClipsDescendants = true

                        things.colorpickerupline = lib:Create("Frame", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 0, 4),
                        })

                        things.colorpickeruplinegradient = lib:Create("UIGradient", {
                            Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 183, 183)), ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 248, 248)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(125, 92, 164))},
                        })

                        things.rback = lib:Create("ImageLabel", {
                            Active = true,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 35, 0, 165),
                            Selectable = true,
                            Size = UDim2.new(0, 50, 0, 20),
                            ZIndex = 2,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.rvalue = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 18, 0, 3),
                            Size = UDim2.new(0, 25, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "255",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 11.000,
                        })

                        things.rtext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 4, 0, 3),
                            Size = UDim2.new(0, 15, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "R:",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14.000,
                        })

                        things.gback = lib:Create("ImageLabel", {
                            Active = true,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.5, 0, 0, 165),
                            Selectable = true,
                            Size = UDim2.new(0, 50, 0, 20),
                            ZIndex = 2,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.gvalue = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 18, 0, 3),
                            Size = UDim2.new(0, 25, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "255",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 11.000,
                        })

                        things.gtext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 4, 0, 3),
                            Size = UDim2.new(0, 15, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "G:",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14.000,
                            TextWrapped = true,
                        })

                        things.bback = lib:Create("ImageLabel", {
                            Active = true,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 155, 0, 165),
                            Selectable = true,
                            Size = UDim2.new(0, 50, 0, 20),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.bvalue = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 18, 0, 3),
                            Size = UDim2.new(0, 25, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "255",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 11.000,
                        })

                        things.btext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 4, 0, 3),
                            Size = UDim2.new(0, 15, 0, 15),
                            ZIndex = 2,
                            Font = Enum.Font.GothamBold,
                            Text = "B:",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14.000,
                        })

                        things.sback = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.0469999984, 0, 0, 10),
                            Size = UDim2.new(0, 140, 0, 140),
                            ZIndex = 2,
                            Image = "rbxassetid://4695575676",
                            ImageColor3 = Color3.fromRGB(46, 46, 54),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(128, 128, 128, 128),
                            SliceScale = 0.040,
                        })

                        things.sat = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BorderColor3 = Color3.fromRGB(221, 221, 221),
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 140, 0, 140),
                            AutoButtonColor = false,
                            Image = "http://www.roblox.com/asset/?id=5113592272",
                            ImageColor3 = Color3.fromRGB(255, 0, 0),
                        })

                        things.light = lib:Create("ImageLabel", {
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 1, 0),
                            Image = "http://www.roblox.com/asset/?id=5113600420",
                        })

                        things.ring = lib:Create("ImageLabel", {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 140, 0, 0),
                            Size = UDim2.new(0, 10, 0, 10),
                            SizeConstraint = Enum.SizeConstraint.RelativeYY,
                            ZIndex = 5,
                            Image = "rbxassetid://244221613",
                            ImageColor3 = Color3.fromRGB(0, 0, 0),
                        })

                        things.rainbowback = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 160, 0, 10),
                            Size = UDim2.new(0, 20, 0, 140),
                            ZIndex = 2,
                            Image = "rbxassetid://4695575676",
                            ImageColor3 = Color3.fromRGB(46, 46, 54),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(128, 128, 128, 128),
                            SliceScale = 0.040,
                        })

                        things.rainbow = lib:Create("ImageButton", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 20, 0, 140),
                            Image = "http://www.roblox.com/asset/?id=5118428654",
                        })

                        things.rainbowlocation = lib:Create("Frame", {
                            BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 20, 0, 2),
                        })

                        things.rainbowtoggle = lib:Create("ImageButton", {
                            Active = false,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.0529999994, 0, 0, 180),
                            Selectable = false,
                            Size = UDim2.new(0, 172, 0, 20),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.rainbowtoggletext = lib:Create("TextLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            Position = UDim2.new(0, 1, 0, 2),
                            Size = UDim2.new(-0.529476523, 200, 0, 16),
                            Font = Enum.Font.GothamBold,
                            Text = "Rainbow",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14.000,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })

                        things.rainbowtoggleback = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 118, 0, 0),
                            Size = UDim2.new(0, 50, 0, 16),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(20, 20, 20),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.rainbowtoggleonoff = lib:Create("ImageLabel", {
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 2, 0, 2),
                            Size = UDim2.new(0, 20, 0, 12),
                            ZIndex = 2,
                            Image = "rbxassetid://3570695787",
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })

                        things.colorpickerframe.Parent = objects.Motherframe
                        things.colorpickerupline.Parent = things.colorpickerframe
                        things.colorpickeruplinegradient.Parent = things.colorpickerupline
                        things.rback.Parent = things.colorpickerframe
                        things.rtext.Parent = things.rback
                        things.rvalue.Parent = things.rback
                        things.gback.Parent = things.colorpickerframe
                        things.gtext.Parent = things.gback
                        things.gvalue.Parent = things.gback
                        things.bback.Parent = things.colorpickerframe
                        things.btext.Parent = things.bback
                        things.bvalue.Parent = things.bback
                        things.sback.Parent = things.colorpickerframe
                        things.sat.Parent = things.sback
                        things.light.Parent = things.sat
                        things.ring.Parent = things.sat
                        things.rainbowback.Parent = things.colorpickerframe
                        things.rainbow.Parent = things.rainbowback
                        things.rainbowlocation.Parent = things.rainbow
                        things.rainbowtoggle.Parent = things.colorpickerframe
                        things.rainbowtoggletext.Parent = things.rainbowtoggle
                        things.rainbowtoggleback.Parent = things.rainbowtoggletext
                        things.rainbowtoggleonoff.Parent = things.rainbowtoggleback


                        sections.container.Size = sections.container.Size + UDim2.new(0,0,0,45)
                        sections.containerthings.Size = sections.containerthings.Size + UDim2.new(0,0,0,45)
                        categories.scrollingframe.CanvasSize = categories.scrollingframe.CanvasSize + UDim2.new(0,0,0,45)

                        things.colorpickerb.Parent = sections.containerthings
                        things.colorpickertext.Parent = things.colorpickerb
                        things.colorpickerbutton.Parent = things.colorpickertext

                        things.colorpickeropen = false
                        
                        sections.containerthings.Position = UDim2.new(0, 0, 1, -sections.containerthings.Size.Y.Offset-6)

                        things.colorpickerbutton.MouseButton1Click:Connect(function()
                            things.colorpickeropen = not things.colorpickeropen

                            for i,v in pairs(objects.Motherframe:GetChildren()) do
                                if v.Name == "colorframe" then
                                    game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 205)}):Play()
                                end
                            end

                            if things.colorpickeropen then 
                                game:GetService("TweenService"):Create(things.colorpickerframe, TweenInfo.new(0.3), {Size = UDim2.new(0, 190, 0, 205)}):Play()
                            end
                        end)


                        local colorbase = Color3.new(1,0,0)
                        things.value = colorbase
                        local Saturation = 1
                        local Darkness = 0
                        local colourPickColour = colorbase

                        local function UpdateColorPicker()

                            colourPickColour = colorbase
                        
                            if Darkness == 1 then
                                colourPickColour = Color3.new(0,0,0)
                                return
                            end
                        
                            if Saturation < 1 then
                                local r = math.clamp(1 + (colourPickColour.r - 1) * Saturation, 0, 1)
                                local g = math.clamp(1 + (colourPickColour.g - 1) * Saturation, 0, 1)
                                local b = math.clamp(1 + (colourPickColour.b - 1) * Saturation, 0, 1)
                                colourPickColour = Color3.new( r, g, b )
                            end
                        
                            if Darkness > 0 then 
                                local r = math.clamp(colourPickColour.r * (1 - Darkness ), 0, 1)
                                local g = math.clamp(colourPickColour.g * (1 - Darkness ), 0, 1)
                                local b = math.clamp(colourPickColour.b * (1 - Darkness ), 0, 1)
                                colourPickColour = Color3.new(r,g,b)
                            end
                            
                            things.rvalue.Text = tostring(math.floor(colourPickColour.r * 255))
                            things.gvalue.Text = tostring(math.floor(colourPickColour.g * 255))
                            things.bvalue.Text = tostring(math.floor(colourPickColour.b * 255))
                            
                            things.value = colourPickColour

                            if CallBack then
                                CallBack(things.value)
                            end

                            things.colorpickerbutton.ImageColor3 = colourPickColour
                        end

                        if Others then
                            if Others.default then
                                local r,g,b = math.floor(Others.default.r * 255),math.floor(Others.default.g * 255),math.floor(Others.default.b * 255)
                                colorbase = Color3.fromRGB(r,g,b)
                                things.sat.ImageColor3 = colorbase
                                UpdateColorPicker()
                            end
                        end

                        local function setPickerColor(y)
                            local rY = y - things.rainbow.AbsolutePosition.Y;
                            local cY = math.clamp(rY, 0, things.rainbow.AbsoluteSize.Y - things.rainbowlocation.AbsoluteSize.Y);
                            local offset = (y - things.rainbow.AbsolutePosition.Y) - things.rainbowlocation.AbsoluteSize.Y
                            local scale = offset / things.rainbow.AbsoluteSize.Y
                            game:GetService("TweenService"):Create(things.rainbowlocation, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, 0, cY)}):Play()
                            local color = Color3.fromHSV(math.clamp(scale, 0, 1), 1, 1)
                            local r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)
                            colorbase = Color3.fromRGB(r,g,b)
                            
                            things.sat.ImageColor3 = colorbase
                            UpdateColorPicker()
                        end

                        local function setPickerLight(x,y)
                            Saturation = x / 140
                            Darkness = y / 140
                            
                            game:GetService("TweenService"):Create(things.ring, TweenInfo.new(0.1), {Position = UDim2.new(0, x, 0, y)}):Play()
                            
                            UpdateColorPicker()
                        end

                        local rc
                        local cc

                        game:GetService("UserInputService").InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                if(cc) then
                                    cc:Disconnect()
                                    cc = nil
                                end
                                if(rc) then 
                                    rc:Disconnect()
                                    rc = nil
                                end
                            end
                        end)

                        things.rainbow.MouseButton1Down:Connect(function()
                            if not rainbow then 
                                rc = game:GetService("RunService").Heartbeat:Connect(function()
                                    setPickerColor(mouse.Y)
                                end)
                            end
                        end)

                        things.sat.MouseButton1Down:Connect(function()
                            cc = game:GetService("RunService").Heartbeat:Connect(function()
                                local v = game:GetService("GuiService"):GetGuiInset()
                                local y = math.clamp(mouse.Y - things.sat.AbsolutePosition.Y - v.y + 34, 0, 140 )
                                local x = math.clamp(mouse.X - things.sat.AbsolutePosition.X - v.x, 0, 140 )
                                setPickerLight(x,y)
                            end)
                        end)

                        local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
                        local rainbow = false
                        things.rainbowtoggle.MouseButton1Click:Connect(function()
                            rainbow = not rainbow
                            if rainbow then 
                                game:GetService("TweenService"):Create(things.rainbowtoggleonoff, TweenInfo.new(0.1), {Position = UDim2.new(0, 28,0, 2)}):Play()
                                local counter = 0
                                repeat wait() 
                                    local color = Color3.fromHSV(zigzag(counter),1,1)
                                    local r = color.r * 255
                                    local b = color.b * 255
                                    local g = color.g * 255
                                    if counter >= 1.01 then
                                        counter = -0.05
                                    end
                                    colorbase = Color3.fromRGB(r,g,b)
                                    game:GetService("TweenService"):Create(things.rainbowlocation, TweenInfo.new(0.1), {Position = UDim2.new(0, 0, counter, 0)}):Play()
                                    counter = counter + 0.01
                                    things.sat.ImageColor3 = colorbase
                                    UpdateColorPicker()
                                until rainbow == false
                            else
                                game:GetService("TweenService"):Create(things.rainbowtoggleonoff, TweenInfo.new(0.1), {Position = UDim2.new(0, 2,0, 2)}):Play()
                            end
                        end)

                    end
                end

                return things 
            end

            sections.container.Parent = categories.scrollingframe
            sections.containername.Parent = sections.container
            sections.containerthings.Parent = sections.container

            return sections
        end
        
        categories.imagebutton.Parent = objects.Sidecategories
        categories.button.Parent = categories.imagebutton
        categories.container.Parent = objects.Categorieshandler
        categories.containerhider.Parent = categories.container
        categories.scrollingframe.Parent = categories.container

        firstCategory = false

        return categories
    end

    objects.Screengui.Parent = game:GetService("CoreGui")
    objects.Motherframe.Parent = objects.Screengui
    objects.Upline.Parent = objects.Motherframe
    objects.Uplinegradient.Parent = objects.Upline
    objects.Sidebar.Parent = objects.Motherframe
    objects.Sidecategories.Parent = objects.Sidebar
    objects.Categorieshandler.Parent = objects.Motherframe
    objects.Categoriesselector.Parent = objects.Sidebar

    return objects
end

return lib