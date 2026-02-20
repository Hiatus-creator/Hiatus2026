--// HIATUS MENU V2 - CLEAN EDITION //-- 
--// ESP LEGAL + FLY + SPEED + TP | Creator: HIATUS //--

-- =====================
-- SERVICES
-- =====================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- =====================
-- ANTI DOUBLE LOAD
-- =====================
if _G.HIATUS_FINAL then return end
_G.HIATUS_FINAL = true

-- =====================
-- CONFIG
-- =====================
local KEY = "Freehiatus"
local DISCORD_LINK = "https://discord.gg/5hZGrxP7uR"
local LOGO_IMAGE = "rbxassetid://LOGO_IMAGE_ID"

local ESPEnabled = false
local FlyEnabled = false
local FlySpeed = 60

-- =====================
-- TWEEN HELPER
-- =====================
local function Tween(obj, props, time)
	TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- =====================
-- ESP FUNCTIONS
-- =====================
local function EnableESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character and not plr.Character:FindFirstChild("HIATUS_ESP") then
			local h = Instance.new("Highlight")
			h.Name = "HIATUS_ESP"
			h.FillColor = Color3.fromRGB(255,0,0)
			h.OutlineColor = Color3.fromRGB(255,255,255)
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

-- =====================
-- FLY SYSTEM
-- =====================
local BodyGyro, BodyVelocity, FlyConnection
local function StartFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:WaitForChild("HumanoidRootPart")
	local hum = char:WaitForChild("Humanoid")
	hum.PlatformStand = true
	BodyGyro = Instance.new("BodyGyro", hrp)
	BodyGyro.P = 9e4
	BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
	BodyVelocity = Instance.new("BodyVelocity", hrp)
	BodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)

	FlyConnection = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		BodyGyro.CFrame = cam.CFrame
		local move = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += cam.CFrame.UpVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= cam.CFrame.UpVector end
		BodyVelocity.Velocity = move * FlySpeed
	end)
end

local function StopFly()
	if FlyConnection then FlyConnection:Disconnect() end
	if BodyGyro then BodyGyro:Destroy() end
	if BodyVelocity then BodyVelocity:Destroy() end
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.PlatformStand = false
	end
end

-- =====================
-- KEY GUI
-- =====================
local KeyGui = Instance.new("ScreenGui", CoreGui)
KeyGui.Name = "HiatusKeyGui"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,420,0,0)
KeyFrame.Position = UDim2.new(0.5,-210,0.5,-140)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
KeyFrame.BackgroundTransparency = 0.2
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,16)
Tween(KeyFrame,{Size=UDim2.new(0,420,0,300)},0.4)

-- LOGO
local Logo = Instance.new("ImageLabel", KeyFrame)
Logo.Size = UDim2.new(0,90,0,90)
Logo.Position = UDim2.new(0.5,-45,0,10)
Logo.BackgroundTransparency = 1
Logo.Image = LOGO_IMAGE

-- TITLE
local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,110)
Title.BackgroundTransparency = 1
Title.Text = "HIATUS"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(128,0,255)

-- KEY BOX
local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0,280,0,40)
KeyBox.Position = UDim2.new(0.5,-140,0,165)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", KeyBox)

-- VALIDATE
local Validate = Instance.new("TextButton", KeyFrame)
Validate.Size = UDim2.new(0,140,0,38)
Validate.Position = UDim2.new(0.5,-70,0,220)
Validate.Text = "VALIDER"
Validate.BackgroundColor3 = Color3.fromRGB(30,30,30)
Validate.TextColor3 = Color3.fromRGB(255,255,255)
Validate.Font = Enum.Font.GothamBold
Instance.new("UICorner", Validate)

-- DISCORD BOUTON EN BAS
local DiscordBtn = Instance.new("TextButton", KeyFrame)
DiscordBtn.Size = UDim2.new(0,280,0,36)
DiscordBtn.Position = UDim2.new(0.5,-140,0,260)
DiscordBtn.Text = "COPIER DISCORD"
DiscordBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
DiscordBtn.TextColor3 = Color3.fromRGB(255,255,255)
DiscordBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", DiscordBtn)

DiscordBtn.MouseButton1Click:Connect(function()
	if setclipboard then setclipboard(DISCORD_LINK) end
end)

local DiscordText = Instance.new("TextLabel", KeyFrame)
DiscordText.Size = UDim2.new(1,0,0,30)
DiscordText.Position = UDim2.new(0,0,0,295)
DiscordText.Text = DISCORD_LINK
DiscordText.BackgroundTransparency = 1
DiscordText.TextColor3 = Color3.fromRGB(180,180,180)
DiscordText.TextSize = 13
DiscordText.TextWrapped = true

-- =====================
-- MAIN MENU
-- =====================
local function OpenMenu()
	local Gui = Instance.new("ScreenGui", CoreGui)
	Gui.Name = "HiatusMainGui"

	local Frame = Instance.new("Frame", Gui)
	Frame.Size = UDim2.new(0,420,0,0)
	Frame.Position = UDim2.new(0.5,-210,0.5,-180)
	Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
	Frame.BackgroundTransparency = 0.2
	Frame.Active = true
	Frame.Draggable = true
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)
	Tween(Frame,{Size=UDim2.new(0,420,0,400)},0.4)

	-- TITRE MENU
	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1,0,0,40)
	Title.Text = "HIATUS MENU"
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.GothamBlack
	Title.TextSize = 24
	Title.TextColor3 = Color3.fromRGB(128,0,255)

	-- ESP BTN
	local ESPBtn = Instance.new("TextButton", Frame)
	ESPBtn.Size = UDim2.new(0,280,0,40)
	ESPBtn.Position = UDim2.new(0.5,-140,0,55)
	ESPBtn.Text = "ESP : OFF"
	ESPBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	ESPBtn.TextColor3 = Color3.fromRGB(255,255,255)
	ESPBtn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", ESPBtn)
	ESPBtn.MouseButton1Click:Connect(function()
		ESPEnabled = not ESPEnabled
		ESPBtn.Text = "ESP : "..(ESPEnabled and "ON" or "OFF")
		if ESPEnabled then EnableESP() else DisableESP() end
	end)

	-- FLY BTN
	local FlyBtn = Instance.new("TextButton", Frame)
	FlyBtn.Size = UDim2.new(0,280,0,40)
	FlyBtn.Position = UDim2.new(0.5,-140,0,105)
	FlyBtn.Text = "FLY : OFF"
	FlyBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	FlyBtn.TextColor3 = Color3.fromRGB(255,255,255)
	FlyBtn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", FlyBtn)
	FlyBtn.MouseButton1Click:Connect(function()
		FlyEnabled = not FlyEnabled
		FlyBtn.Text = "FLY : "..(FlyEnabled and "ON" or "OFF")
		if FlyEnabled then StartFly() else StopFly() end
	end)

	-- FLY SPEED
	local SpeedLabel = Instance.new("TextLabel", Frame)
	SpeedLabel.Size = UDim2.new(1,0,0,30)
	SpeedLabel.Position = UDim2.new(0,0,0,160)
	SpeedLabel.BackgroundTransparency = 1
	SpeedLabel.Text = "Fly Speed : "..FlySpeed
	SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)

	local SpeedBox = Instance.new("TextBox", Frame)
	SpeedBox.Size = UDim2.new(0,120,0,34)
	SpeedBox.Position = UDim2.new(0.5,-60,0,195)
	SpeedBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
	SpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
	SpeedBox.Text = tostring(FlySpeed)
	Instance.new("UICorner", SpeedBox)
	SpeedBox.FocusLost:Connect(function()
		local v = tonumber(SpeedBox.Text)
		if v and v >= 10 and v <= 300 then
			FlySpeed = v
			SpeedLabel.Text = "Fly Speed : "..FlySpeed
		end
	end)

	-- TP JOUEUR
	local YPos = 240
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local PlayerLabel = Instance.new("TextLabel", Frame)
			PlayerLabel.Size = UDim2.new(0,180,0,28)
			PlayerLabel.Position = UDim2.new(0,10,0,YPos)
			PlayerLabel.BackgroundColor3 = Color3.fromRGB(30,30,30)
			PlayerLabel.TextColor3 = Color3.fromRGB(255,255,255)
			PlayerLabel.Text = plr.Name
			PlayerLabel.Font = Enum.Font.GothamBold
			Instance.new("UICorner", PlayerLabel)

			local TPBtn = Instance.new("TextButton", Frame)
			TPBtn.Size = UDim2.new(0,80,0,28)
			TPBtn.Position = UDim2.new(0,200,0,YPos)
			TPBtn.BackgroundColor3 = Color3.fromRGB(128,0,255)
			TPBtn.TextColor3 = Color3.fromRGB(255,255,255)
			TPBtn.Text = "TP"
			TPBtn.Font = Enum.Font.GothamBold
			Instance.new("UICorner", TPBtn)
			TPBtn.MouseButton1Click:Connect(function()
				local char = LocalPlayer.Character
				local target = plr.Character
				if char and target and target:FindFirstChild("HumanoidRootPart") then
					char:SetPrimaryPartCFrame(target.HumanoidRootPart.CFrame + Vector3.new(0,3,0))
				end
			end)

			YPos += 35
		end
	end

	-- PETIT CARRE H VIOLET
	local MiniBtn = Instance.new("TextButton", Gui)
	MiniBtn.Size = UDim2.new(0,40,0,40)
	MiniBtn.Position = UDim2.new(0,50,0,50)
	MiniBtn.BackgroundColor3 = Color3.fromRGB(50,0,128)
	MiniBtn.Text = "H"
	MiniBtn.TextColor3 = Color3.fromRGB(255,255,255)
	MiniBtn.Font = Enum.Font.GothamBlack
	Instance.new("UICorner", MiniBtn)
	MiniBtn.Active = true
	MiniBtn.Draggable = true
	MiniBtn.MouseButton1Click:Connect(function()
		Frame.Visible = not Frame.Visible
	end)
end

-- =====================
-- VALIDATE KEY
-- =====================
Validate.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		KeyGui:Destroy()
		OpenMenu()
	else
		KeyBox.Text = ""
		KeyBox.PlaceholderText = "KEY INVALID"
	end
end)
