-- // HIATUS MENU V2 - ESP LEGAL + ANIMATIONS // --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Anti double load
if _G.HIATUS_FINAL then return end
_G.HIATUS_FINAL = true

-- =====================
-- CONFIG
-- =====================
local KEY = "Freehiatus"
local DISCORD_LINK = "https://discord.gg/5hZGrxP7uR"
local LOGO_IMAGE = "rbxassetid://IMAGE_ID_HERE"

local ESPEnabled = false

-- =====================
-- ESP (Highlight - légal)
-- =====================
local function EnableESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character and not plr.Character:FindFirstChild("HIATUS_ESP") then
			local h = Instance.new("Highlight")
			h.Name = "HIATUS_ESP"
			h.FillColor = Color3.fromRGB(255, 0, 0)
			h.OutlineColor = Color3.fromRGB(255, 255, 255)
			h.FillTransparency = 0.5
			h.OutlineTransparency = 0
			h.Parent = plr.Character
		end
	end
end

local function DisableESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			local h = plr.Character:FindFirstChild("HIATUS_ESP")
			if h then h:Destroy() end
		end
	end
end

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		if ESPEnabled then
			task.wait(0.4)
			EnableESP()
		end
	end)
end)

-- =====================
-- TWEEN HELPER
-- =====================
local function Tween(obj, props, time)
	TweenService:Create(
		obj,
		TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	):Play()
end

-- =====================
-- KEY GUI
-- =====================
local KeyGui = Instance.new("ScreenGui", CoreGui)
KeyGui.Name = "HiatusKeyGui"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 400, 0, 0)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -115)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 14)

Tween(KeyFrame, {Size = UDim2.new(0,400,0,240)}, 0.4)

local Logo = Instance.new("ImageLabel", KeyFrame)
Logo.Size = UDim2.new(0, 80, 0, 80)
Logo.Position = UDim2.new(0.5, -40, 0, 10)
Logo.BackgroundTransparency = 1
Logo.Image = LOGO_IMAGE

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,95)
Title.BackgroundTransparency = 1
Title.Text = "HIATUS"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(255,255,255)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0,260,0,38)
KeyBox.Position = UDim2.new(0.5,-130,0,140)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Text = ""
KeyBox.ClearTextOnFocus = false
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 15
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local Validate = Instance.new("TextButton", KeyFrame)
Validate.Size = UDim2.new(0,110,0,36)
Validate.Position = UDim2.new(0.1,0,1,-45)
Validate.Text = "VALIDER"
Validate.Font = Enum.Font.GothamBold
Validate.TextSize = 14
Validate.TextColor3 = Color3.fromRGB(255,255,255)
Validate.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", Validate).CornerRadius = UDim.new(0,8)

local CloseKey = Instance.new("TextButton", KeyFrame)
CloseKey.Size = UDim2.new(0,110,0,36)
CloseKey.Position = UDim2.new(0.55,0,1,-45)
CloseKey.Text = "FERMER"
CloseKey.Font = Enum.Font.GothamBold
CloseKey.TextSize = 14
CloseKey.TextColor3 = Color3.fromRGB(255,255,255)
CloseKey.BackgroundColor3 = Color3.fromRGB(90,0,0)
Instance.new("UICorner", CloseKey).CornerRadius = UDim.new(0,8)

-- =====================
-- MAIN MENU
-- =====================
local function OpenMenu()
	local Gui = Instance.new("ScreenGui", CoreGui)
	Gui.Name = "HiatusMainGui"

	local Frame = Instance.new("Frame", Gui)
	Frame.Size = UDim2.new(0,420,0,0)
	Frame.Position = UDim2.new(0.5,-210,0.5,-120)
	Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
	Frame.BorderSizePixel = 0
	Frame.Active = true
	Frame.Draggable = true
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

	Tween(Frame, {Size = UDim2.new(0,420,0,260)}, 0.4)

	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1,0,0,45)
	Title.BackgroundTransparency = 1
	Title.Text = "HIATUS - ESP"
	Title.Font = Enum.Font.GothamBlack
	Title.TextSize = 24
	Title.TextColor3 = Color3.fromRGB(255,255,255)

	local ESPBtn = Instance.new("TextButton", Frame)
	ESPBtn.Size = UDim2.new(0,260,0,45)
	ESPBtn.Position = UDim2.new(0.5,-130,0,65)
	ESPBtn.Text = "ESP : OFF"
	ESPBtn.Font = Enum.Font.GothamBold
	ESPBtn.TextSize = 16
	ESPBtn.TextColor3 = Color3.fromRGB(255,255,255)
	ESPBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	Instance.new("UICorner", ESPBtn).CornerRadius = UDim.new(0,10)

	ESPBtn.MouseButton1Click:Connect(function()
		ESPEnabled = not ESPEnabled
		ESPBtn.Text = "ESP : " .. (ESPEnabled and "ON" or "OFF")
		if ESPEnabled then EnableESP() else DisableESP() end
	end)

	-- DISCORD BUTTON
	local DiscordBtn = Instance.new("TextButton", Frame)
	DiscordBtn.Size = UDim2.new(0,260,0,38)
	DiscordBtn.Position = UDim2.new(0.5,-130,0,125)
	DiscordBtn.Text = "DISCORD"
	DiscordBtn.Font = Enum.Font.GothamBold
	DiscordBtn.TextSize = 15
	DiscordBtn.TextColor3 = Color3.fromRGB(255,255,255)
	DiscordBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0,8)

	local DiscordLink = Instance.new("TextLabel", Frame)
	DiscordLink.Size = UDim2.new(1,0,0,30)
	DiscordLink.Position = UDim2.new(0,0,0,168)
	DiscordLink.BackgroundTransparency = 1
	DiscordLink.Text = DISCORD_LINK
	DiscordLink.Font = Enum.Font.Gotham
	DiscordLink.TextSize = 13
	DiscordLink.TextColor3 = Color3.fromRGB(180,180,180)
	DiscordLink.TextWrapped = true

	DiscordBtn.MouseButton1Click:Connect(function()
		print("HIATUS | Discord :", DISCORD_LINK)
		if setclipboard then
			setclipboard(DISCORD_LINK)
		end
	end)

	local Close = Instance.new("TextButton", Frame)
	Close.Size = UDim2.new(0,120,0,34)
	Close.Position = UDim2.new(0.5,-60,1,-42)
	Close.Text = "FERMER"
	Close.Font = Enum.Font.GothamBold
	Close.TextSize = 14
	Close.TextColor3 = Color3.fromRGB(255,255,255)
	Close.BackgroundColor3 = Color3.fromRGB(90,0,0)
	Instance.new("UICorner", Close).CornerRadius = UDim.new(0,8)

	Close.MouseButton1Click:Connect(function()
		Tween(Frame, {Size = UDim2.new(0,420,0,0)}, 0.3)
		task.wait(0.3)
		Gui:Destroy()
	end)
end

-- =====================
-- EVENTS
-- =====================
Validate.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		Tween(KeyFrame, {Size = UDim2.new(0,400,0,0)}, 0.3)
		task.wait(0.3)
		KeyGui:Destroy()
		OpenMenu()
	else
		KeyBox.Text = ""
		KeyBox.PlaceholderText = "KEY INVALID"
	end
end)

CloseKey.MouseButton1Click:Connect(function()
	Tween(KeyFrame, {Size = UDim2.new(0,400,0,0)}, 0.3)
	task.wait(0.3)
	KeyGui:Destroy()
end)
