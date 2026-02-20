--// HIATUS HUB - FULL SCRIPT FIX TP + SCROLL + SLIDER //
--// ESP + FLY + TP | HIATUS //

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if _G.HIATUS then return end
_G.HIATUS = true

-- CONFIG
local KEY = "Freehiatus"
local DISCORD_LINK = "https://discord.gg/5J3AJvSG8s"

local ESPEnabled = false
local FlyEnabled = false
local FlySpeed = 60

-- SOUND
local function PlaySound(id)
	local s = Instance.new("Sound", workspace)
	s.SoundId = "rbxassetid://"..id
	s.Volume = 0.6
	s:Play()
	game.Debris:AddItem(s,2)
end

-- ESP
local function EnableESP()
	for _,p in pairs(Players:GetPlayers()) do
		if p.Character and not p.Character:FindFirstChild("HIATUS_ESP") then
			local h = Instance.new("Highlight")
			h.Name = "HIATUS_ESP"
			h.FillColor = Color3.fromRGB(255,0,0)
			h.FillTransparency = 0.4
			h.OutlineTransparency = 0
			h.Parent = p.Character
		end
	end
end

local function DisableESP()
	for _,p in pairs(Players:GetPlayers()) do
		if p.Character then
			local h = p.Character:FindFirstChild("HIATUS_ESP")
			if h then h:Destroy() end
		end
	end
end

-- FLY
local BG, BV, FlyConn
local function StartFly()
	local c = LocalPlayer.Character
	if not c then return end
	local hrp = c:WaitForChild("HumanoidRootPart")
	local hum = c:WaitForChild("Humanoid")
	hum.PlatformStand = true

	BG = Instance.new("BodyGyro", hrp)
	BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
	BG.P = 9e4

	BV = Instance.new("BodyVelocity", hrp)
	BV.MaxForce = Vector3.new(9e9,9e9,9e9)

	FlyConn = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		BG.CFrame = cam.CFrame
		local v = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then v += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then v -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then v -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then v += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then v += cam.CFrame.UpVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then v -= cam.CFrame.UpVector end
		BV.Velocity = v * FlySpeed
	end)
end

local function StopFly()
	if FlyConn then FlyConn:Disconnect() end
	if BG then BG:Destroy() end
	if BV then BV:Destroy() end
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
	if hum then hum.PlatformStand = false end
end

-- GUI
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "HiatusHub"

-- WELCOME
local Welcome = Instance.new("TextLabel", Gui)
Welcome.Size = UDim2.new(1,0,1,0)
Welcome.BackgroundColor3 = Color3.fromRGB(0,0,0)
Welcome.Text = "WELCOME HIATUS HUB"
Welcome.Font = Enum.Font.GothamBlack
Welcome.TextSize = 40
Welcome.TextColor3 = Color3.fromRGB(140,0,255)
TweenService:Create(Welcome,TweenInfo.new(1),{TextTransparency=1,BackgroundTransparency=1}):Play()
task.delay(1.2,function() Welcome:Destroy() end)

-- KEY MENU
local KeyFrame = Instance.new("Frame", Gui)
KeyFrame.Size = UDim2.new(0,420,0,300)
KeyFrame.Position = UDim2.new(0.5,-210,0.5,-150)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
KeyFrame.BackgroundTransparency = 0.2
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner",KeyFrame)

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1,0,0,50)
Title.Text = "HIATUS"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 30
Title.TextColor3 = Color3.fromRGB(140,0,255)
Title.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0,280,0,40)
KeyBox.Position = UDim2.new(0.5,-140,0,120)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",KeyBox)

local Validate = Instance.new("TextButton", KeyFrame)
Validate.Size = UDim2.new(0,140,0,38)
Validate.Position = UDim2.new(0.5,-70,0,175)
Validate.Text = "VALIDER"
Validate.BackgroundColor3 = Color3.fromRGB(40,0,90)
Validate.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Validate)

local Discord = Instance.new("TextButton", KeyFrame)
Discord.Size = UDim2.new(0,280,0,34)
Discord.Position = UDim2.new(0.5,-140,0,225)
Discord.Text = "COPIER DISCORD"
Discord.BackgroundColor3 = Color3.fromRGB(30,30,30)
Discord.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Discord)

Discord.MouseButton1Click:Connect(function()
	if setclipboard then setclipboard(DISCORD_LINK) end
	PlaySound(12222216)
end)

-- MAIN MENU
local Menu = Instance.new("Frame", Gui)
Menu.Size = UDim2.new(0,420,0,380)
Menu.Position = UDim2.new(0.5,-210,0.5,-190)
Menu.BackgroundColor3 = Color3.fromRGB(10,10,10)
Menu.BackgroundTransparency = 0.2
Menu.Visible = false
Menu.Active = true
Menu.Draggable = true
Instance.new("UICorner",Menu)

local MTitle = Instance.new("TextLabel", Menu)
MTitle.Size = UDim2.new(1,0,0,40)
MTitle.Text = "Hiatus Menu"
MTitle.TextColor3 = Color3.fromRGB(140,0,255)
MTitle.Font = Enum.Font.GothamBold
MTitle.BackgroundTransparency = 1

-- ESP BTN
local ESPBtn = Instance.new("TextButton", Menu)
ESPBtn.Size = UDim2.new(0,280,0,34)
ESPBtn.Position = UDim2.new(0.5,-140,0,50)
ESPBtn.Text = "ESP : OFF"
ESPBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
ESPBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",ESPBtn)

ESPBtn.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	ESPBtn.Text = "ESP : "..(ESPEnabled and "ON" or "OFF")
	if ESPEnabled then EnableESP() else DisableESP() end
end)

-- FLY BTN
local FlyBtn = Instance.new("TextButton", Menu)
FlyBtn.Size = UDim2.new(0,280,0,34)
FlyBtn.Position = UDim2.new(0.5,-140,0,90)
FlyBtn.Text = "FLY : OFF"
FlyBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
FlyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",FlyBtn)

FlyBtn.MouseButton1Click:Connect(function()
	FlyEnabled = not FlyEnabled
	FlyBtn.Text = "FLY : "..(FlyEnabled and "ON" or "OFF")
	if FlyEnabled then StartFly() else StopFly() end
end)

-- SPEED
local SpeedText = Instance.new("TextLabel", Menu)
SpeedText.Size = UDim2.new(1,0,0,20)
SpeedText.Position = UDim2.new(0,0,0,130)
SpeedText.Text = "Fly Speed : "..FlySpeed
SpeedText.TextColor3 = Color3.new(1,1,1)
SpeedText.BackgroundTransparency = 1

local Bar = Instance.new("Frame", Menu)
Bar.Size = UDim2.new(0,260,0,6)
Bar.Position = UDim2.new(0.5,-130,0,155)
Bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner",Bar)

local Dot = Instance.new("Frame", Bar)
Dot.Size = UDim2.new(0,14,0,14)
Dot.Position = UDim2.new(FlySpeed/200,-7,0.5,-7)
Dot.BackgroundColor3 = Color3.fromRGB(140,0,255)
Dot.Active = true
Instance.new("UICorner",Dot)

local Drag = false
Dot.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		Drag = true
		Menu.Draggable = false
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		Drag = false
		Menu.Draggable = true
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if Drag and i.UserInputType == Enum.UserInputType.MouseMovement then
		local x = math.clamp(i.Position.X - Bar.AbsolutePosition.X,0,Bar.AbsoluteSize.X)
		FlySpeed = math.floor(1 + (x/Bar.AbsoluteSize.X)*199)
		Dot.Position = UDim2.new(0,x-7,0.5,-7)
		SpeedText.Text = "Fly Speed : "..FlySpeed
	end
end)

-- TP LIST (SCROLLABLE)
local TPList = Instance.new("ScrollingFrame", Menu)
TPList.Size = UDim2.new(0,360,0,150)
TPList.Position = UDim2.new(0.5,-180,0,190)
TPList.CanvasSize = UDim2.new(0,0,0,0)
TPList.ScrollBarThickness = 6
TPList.BackgroundTransparency = 1

local y = 0
for _,p in pairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		local L = Instance.new("TextLabel", TPList)
		L.Size = UDim2.new(0,240,0,28)
		L.Position = UDim2.new(0,0,0,y)
		L.Text = p.Name
		L.BackgroundColor3 = Color3.fromRGB(30,30,30)
		L.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner",L)

		local B = Instance.new("TextButton", TPList)
		B.Size = UDim2.new(0,90,0,28)
		B.Position = UDim2.new(0,250,0,y)
		B.Text = "TP"
		B.BackgroundColor3 = Color3.fromRGB(140,0,255)
		B.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner",B)

		B.MouseButton1Click:Connect(function()
			if LocalPlayer.Character and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character:MoveTo(p.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
			end
		end)

		y += 32
	end
end
TPList.CanvasSize = UDim2.new(0,0,0,y)

-- MINI H
local Mini = Instance.new("TextButton", Gui)
Mini.Size = UDim2.new(0,50,0,50)
Mini.Position = UDim2.new(0,40,0.5,-25)
Mini.Text = "H"
Mini.Font = Enum.Font.GothamBlack
Mini.TextSize = 26
Mini.BackgroundColor3 = Color3.fromRGB(140,0,255)
Mini.TextColor3 = Color3.new(1,1,1)
Mini.Active = true
Mini.Draggable = true
Instance.new("UICorner",Mini)

Mini.MouseButton1Click:Connect(function()
	Menu.Visible = not Menu.Visible
end)

Validate.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		KeyFrame:Destroy()
		Menu.Visible = true
	else
		KeyBox.Text = ""
		KeyBox.PlaceholderText = "KEY INVALID"
	end
end)
