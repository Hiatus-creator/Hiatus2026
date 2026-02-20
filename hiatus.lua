--// HIATUS HUB - FULL SCRIPT //--
--// ESP + FLY + TP + KEY SYSTEM //--

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

if _G.HIATUS_LOADED then return end
_G.HIATUS_LOADED = true

-- CONFIG
local KEY = "Freehiatus"
local DISCORD = "https://discord.gg/5J3AJvSG8s"

-- VALUES
local ESP_ON = false
local FLY_ON = false
local FlySpeed = 60

-- UTILS
local function tween(o,p,t)
	TweenService:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p):Play()
end

local function clickSound(parent)
	local s = Instance.new("Sound",parent)
	s.SoundId = "rbxassetid://12221967"
	s.Volume = 0.5
	s:Play()
	game:GetService("Debris"):AddItem(s,2)
end

-- ESP
local function applyESP()
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

local function removeESP()
	for _,p in pairs(Players:GetPlayers()) do
		if p.Character then
			local h = p.Character:FindFirstChild("HIATUS_ESP")
			if h then h:Destroy() end
		end
	end
end

-- FLY
local BG,BV,FC
local function startFly()
	local c = LP.Character
	if not c then return end
	local hrp = c:WaitForChild("HumanoidRootPart")
	local hum = c:WaitForChild("Humanoid")
	hum.PlatformStand = true

	BG = Instance.new("BodyGyro",hrp)
	BG.P = 9e4
	BG.MaxTorque = Vector3.new(9e9,9e9,9e9)

	BV = Instance.new("BodyVelocity",hrp)
	BV.MaxForce = Vector3.new(9e9,9e9,9e9)

	FC = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		BG.CFrame = cam.CFrame
		local m = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then m += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then m -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then m -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then m += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then m += cam.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then m -= cam.CFrame.UpVector end
		BV.Velocity = m * FlySpeed
	end)
end

local function stopFly()
	if FC then FC:Disconnect() end
	if BG then BG:Destroy() end
	if BV then BV:Destroy() end
	if LP.Character and LP.Character:FindFirstChild("Humanoid") then
		LP.Character.Humanoid.PlatformStand = false
	end
end

-- ================= KEY GUI =================
local KeyGui = Instance.new("ScreenGui",CoreGui)

local KF = Instance.new("Frame",KeyGui)
KF.Size = UDim2.new(0,420,0,0)
KF.Position = UDim2.new(0.5,-210,0.5,-150)
KF.BackgroundColor3 = Color3.fromRGB(15,15,15)
KF.BackgroundTransparency = 0.15
KF.Active = true
KF.Draggable = true
Instance.new("UICorner",KF).CornerRadius = UDim.new(0,16)
tween(KF,{Size=UDim2.new(0,420,0,330)},0.4)

local Title = Instance.new("TextLabel",KF)
Title.Size = UDim2.new(1,0,0,60)
Title.Text = "HIATUS"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 34
Title.TextColor3 = Color3.fromRGB(140,0,255)
Title.BackgroundTransparency = 1

local Lizard = Instance.new("TextLabel",KF)
Lizard.Size = UDim2.new(1,0,0,40)
Lizard.Position = UDim2.new(0,0,0,50)
Lizard.Text = "🦎"
Lizard.TextSize = 32
Lizard.BackgroundTransparency = 1

local Box = Instance.new("TextBox",KF)
Box.Size = UDim2.new(0,260,0,40)
Box.Position = UDim2.new(0.5,-130,0,120)
Box.PlaceholderText = "Enter Key"
Box.BackgroundColor3 = Color3.fromRGB(25,25,25)
Box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Box)

local Val = Instance.new("TextButton",KF)
Val.Size = UDim2.new(0,140,0,38)
Val.Position = UDim2.new(0.5,-70,0,175)
Val.Text = "VALIDER"
Val.BackgroundColor3 = Color3.fromRGB(35,35,35)
Val.TextColor3 = Color3.new(1,1,1)
Val.Font = Enum.Font.GothamBold
Instance.new("UICorner",Val)

local Dbtn = Instance.new("TextButton",KF)
Dbtn.Size = UDim2.new(0,260,0,36)
Dbtn.Position = UDim2.new(0.5,-130,0,230)
Dbtn.Text = "COPIER DISCORD"
Dbtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Dbtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Dbtn)

Dbtn.MouseButton1Click:Connect(function()
	clickSound(Dbtn)
	if setclipboard then setclipboard(DISCORD) end
end)

-- ================= MENU =================
local function openMenu()
	local Gui = Instance.new("ScreenGui",CoreGui)

	-- welcome
	local W = Instance.new("TextLabel",Gui)
	W.Size = UDim2.new(1,0,1,0)
	W.Text = "WELCOME HIATUS HUB"
	W.Font = Enum.Font.GothamBlack
	W.TextSize = 40
	W.TextColor3 = Color3.fromRGB(140,0,255)
	W.BackgroundTransparency = 1
	tween(W,{TextTransparency=1},2)
	task.delay(2,function() W:Destroy() end)

	-- mini H
	local H = Instance.new("TextButton",Gui)
	H.Size = UDim2.new(0,50,0,50)
	H.Position = UDim2.new(0,40,0,200)
	H.Text = "H"
	H.Font = Enum.Font.GothamBlack
	H.TextSize = 26
	H.BackgroundColor3 = Color3.fromRGB(140,0,255)
	H.TextColor3 = Color3.new(1,1,1)
	H.Active = true
	H.Draggable = true
	Instance.new("UICorner",H)

	-- main menu
	local M = Instance.new("Frame",Gui)
	M.Size = UDim2.new(0,460,0,420)
	M.Position = UDim2.new(0.5,-230,0.5,-210)
	M.BackgroundColor3 = Color3.fromRGB(15,15,15)
	M.BackgroundTransparency = 0.15
	M.Active = true
	M.Draggable = true
	Instance.new("UICorner",M)

	H.MouseButton1Click:Connect(function()
		clickSound(H)
		M.Visible = not M.Visible
	end)

	-- close
	local X = Instance.new("TextButton",M)
	X.Size = UDim2.new(0,28,0,28)
	X.Position = UDim2.new(1,-36,0,8)
	X.Text = "X"
	X.BackgroundColor3 = Color3.fromRGB(140,0,255)
	X.TextColor3 = Color3.new(1,1,1)
	X.Font = Enum.Font.GothamBlack
	Instance.new("UICorner",X)
	X.MouseButton1Click:Connect(function()
		clickSound(X)
		M.Visible = false
	end)

	-- title
	local MT = Instance.new("TextLabel",M)
	MT.Size = UDim2.new(1,0,0,40)
	MT.Text = "Hiatus Menu"
	MT.TextColor3 = Color3.fromRGB(140,0,255)
	MT.Font = Enum.Font.GothamBlack
	MT.BackgroundTransparency = 1

	-- ESP BTN
	local ESPB = Instance.new("TextButton",M)
	ESPB.Size = UDim2.new(0,280,0,36)
	ESPB.Position = UDim2.new(0.5,-140,0,50)
	ESPB.Text = "ESP : OFF"
	ESPB.BackgroundColor3 = Color3.fromRGB(30,30,30)
	ESPB.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",ESPB)

	ESPB.MouseButton1Click:Connect(function()
		clickSound(ESPB)
		ESP_ON = not ESP_ON
		ESPB.Text = "ESP : "..(ESP_ON and "ON" or "OFF")
		if ESP_ON then applyESP() else removeESP() end
	end)

	-- FLY BTN
	local FLYB = Instance.new("TextButton",M)
	FLYB.Size = UDim2.new(0,280,0,36)
	FLYB.Position = UDim2.new(0.5,-140,0,95)
	FLYB.Text = "FLY : OFF"
	FLYB.BackgroundColor3 = Color3.fromRGB(30,30,30)
	FLYB.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",FLYB)

	FLYB.MouseButton1Click:Connect(function()
		clickSound(FLYB)
		FLY_ON = not FLY_ON
		FLYB.Text = "FLY : "..(FLY_ON and "ON" or "OFF")
		if FLY_ON then startFly() else stopFly() end
	end)

	-- SPEED TEXT
	local ST = Instance.new("TextLabel",M)
	ST.Size = UDim2.new(1,0,0,20)
	ST.Position = UDim2.new(0,0,0,135)
	ST.Text = "Fly Speed : "..FlySpeed
	ST.TextColor3 = Color3.new(1,1,1)
	ST.BackgroundTransparency = 1

	-- SLIDER
	local Bar = Instance.new("Frame",M)
	Bar.Size = UDim2.new(0,260,0,6)
	Bar.Position = UDim2.new(0.5,-130,0,165)
	Bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

	local Dot = Instance.new("Frame",Bar)
	Dot.Size = UDim2.new(0,14,0,14)
	Dot.Position = UDim2.new(FlySpeed/200,-7,0.5,-7)
	Dot.BackgroundColor3 = Color3.fromRGB(140,0,255)
	Dot.Active = true
	Instance.new("UICorner",Dot).CornerRadius = UDim.new(1,0)

	local dragging = false
	Dot.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			M.Draggable = false
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
			M.Draggable = true
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local x = math.clamp(i.Position.X-Bar.AbsolutePosition.X,0,Bar.AbsoluteSize.X)
			local p = x/Bar.AbsoluteSize.X
			FlySpeed = math.floor(1+p*199)
			Dot.Position = UDim2.new(0,x-7,0.5,-7)
			ST.Text = "Fly Speed : "..FlySpeed
		end
	end)

	-- TP LIST
	local Scroll = Instance.new("ScrollingFrame",M)
	Scroll.Size = UDim2.new(0,360,0,140)
	Scroll.Position = UDim2.new(0.5,-180,0,215)
	Scroll.CanvasSize = UDim2.new(0,0,0,0)
	Scroll.ScrollBarImageTransparency = 0

	local y = 0
	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LP then
			local B = Instance.new("TextButton",Scroll)
			B.Size = UDim2.new(1,-10,0,30)
			B.Position = UDim2.new(0,5,0,y)
			B.Text = "TP ➜ "..p.Name
			B.BackgroundColor3 = Color3.fromRGB(35,35,35)
			B.TextColor3 = Color3.new(1,1,1)
			Instance.new("UICorner",B)

			B.MouseButton1Click:Connect(function()
				clickSound(B)
				if LP.Character and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					LP.Character.HumanoidRootPart.CFrame =
						p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				end
			end)

			y += 35
		end
	end
	Scroll.CanvasSize = UDim2.new(0,0,0,y)
end

-- VALIDATE KEY
Val.MouseButton1Click:Connect(function()
	clickSound(Val)
	if Box.Text == KEY then
		KeyGui:Destroy()
		openMenu()
	else
		Box.Text = ""
		Box.PlaceholderText = "KEY INVALID"
	end
end)
