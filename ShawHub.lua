--// SHAW HUB v3 — working on Delta mobile
local CONFIG = {
	KillAuraRange = 1,
	KillAuraDelay = 0.1,
	AuraAutoFace  = true,
	NeonColor     = Color3.fromRGB(0, 255, 255),
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local GuiParent = Player:WaitForChild("PlayerGui")

for _, v in ipairs(GuiParent:GetChildren()) do
	if v.Name == "ShawHub" then v:Destroy() end
end

local function makeDraggable(dragPart, targetFrame)
	local dragging, dragStart, startPos = false, nil, nil
	dragPart.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = targetFrame.Position
		end
	end)
	dragPart.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			targetFrame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "ShawHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999999
Gui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(400, 300)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = Gui

local C = Instance.new("UICorner")
C.CornerRadius = UDim.new(0, 12)
C.Parent = Main

local NS = Instance.new("UIStroke")
NS.Color = CONFIG.NeonColor
NS.Thickness = 1.6
NS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
NS.Parent = Main

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 44)
Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Top.BorderSizePixel = 0
Top.Active = true
Top.Parent = Main

local TC = Instance.new("UICorner")
TC.CornerRadius = UDim.new(0, 12)
TC.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -110, 1, 0)
Title.Position = UDim2.fromOffset(16, 0)
Title.BackgroundTransparency = 1
Title.Text = "Shaw Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Min = Instance.new("TextButton")
Min.Size = UDim2.fromOffset(34, 34)
Min.Position = UDim2.new(1, -76, 0, 5)
Min.BackgroundTransparency = 1
Min.Text = "−"
Min.TextColor3 = Color3.fromRGB(200, 200, 200)
Min.TextSize = 22
Min.Font = Enum.Font.GothamBold
Min.Parent = Top

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(34, 34)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.Gotham
CloseBtn.Parent = Top

makeDraggable(Top, Main)

local Confirm = Instance.new("Frame")
Confirm.Size = UDim2.fromOffset(260, 110)
Confirm.Position = UDim2.new(0.5, -130, 0.5, -55)
Confirm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Confirm.BorderSizePixel = 0
Confirm.Visible = false
Confirm.ZIndex = 50
Confirm.Active = true
Confirm.Parent = Gui

local CC = Instance.new("UICorner")
CC.CornerRadius = UDim.new(0, 10)
CC.Parent = Confirm

local CS = Instance.new("UIStroke")
CS.Color = CONFIG.NeonColor
CS.Thickness = 1.6
CS.Parent = Confirm

local CText = Instance.new("TextLabel")
CText.Size = UDim2.new(1, -20, 0, 40)
CText.Position = UDim2.fromOffset(10, 12)
CText.BackgroundTransparency = 1
CText.Text = "Close the script?"
CText.TextColor3 = Color3.fromRGB(255, 255, 255)
CText.TextSize = 14
CText.Font = Enum.Font.GothamBold
CText.Parent = Confirm

local Yes = Instance.new("TextButton")
Yes.Size = UDim2.new(0.5, -18, 0, 36)
Yes.Position = UDim2.new(0, 10, 1, -46)
Yes.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Yes.BorderSizePixel = 0
Yes.Text = "Close"
Yes.TextColor3 = Color3.fromRGB(255, 90, 90)
Yes.TextSize = 12
Yes.Font = Enum.Font.GothamBold
Yes.Parent = Confirm

local YC = Instance.new("UICorner")
YC.CornerRadius = UDim.new(0, 6)
YC.Parent = Yes

local No = Instance.new("TextButton")
No.Size = UDim2.new(0.5, -18, 0, 36)
No.Position = UDim2.new(0.5, 8, 1, -46)
No.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
No.BorderSizePixel = 0
No.Text = "Cancel"
No.TextColor3 = Color3.fromRGB(200, 200, 200)
No.TextSize = 12
No.Font = Enum.Font.GothamBold
No.Parent = Confirm

local NC = Instance.new("UICorner")
NC.CornerRadius = UDim.new(0, 6)
NC.Parent = No

CloseBtn.Activated:Connect(function() Confirm.Visible = true end)
No.Activated:Connect(function() Confirm.Visible = false end)
Yes.Activated:Connect(function() Gui:Destroy() end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -44)
Sidebar.Position = UDim2.fromOffset(0, 44)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SL = Instance.new("UIListLayout")
SL.Padding = UDim.new(0, 4)
SL.HorizontalAlignment = Enum.HorizontalAlignment.Center
SL.SortOrder = Enum.SortOrder.LayoutOrder
SL.Parent = Sidebar

local SP = Instance.new("UIPadding")
SP.PaddingTop = UDim.new(0, 10)
SP.Parent = Sidebar

local sideBtns = {}

local function SideButton(text, name)
	local B = Instance.new("TextButton")
	B.Size = UDim2.fromOffset(94, 32)
	B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	B.BorderSizePixel = 0
	B.Text = text
	B.TextColor3 = Color3.fromRGB(200, 200, 200)
	B.TextSize = 11
	B.Font = Enum.Font.Gotham
	B.Parent = Sidebar
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = B
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(40, 40, 40)
	s.Thickness = 1
	s.Parent = B
	sideBtns[name] = {btn = B, stroke = s}
	return B
end

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -110, 1, -44)
Content.Position = UDim2.fromOffset(110, 44)
Content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Content.BorderSizePixel = 0
Content.Parent = Main

local pages = {}
local function makePage(name)
	local P = Instance.new("Frame")
	P.Size = UDim2.new(1, 0, 1, 0)
	P.BackgroundTransparency = 1
	P.Visible = false
	P.Parent = Content
	pages[name] = P
	return P
end

local HomePage    = makePage("Home")
local CombatPage  = makePage("Combat")
local PlayersPage = makePage("Players")
local UpdatesPage = makePage("Updates")

local function PageTitle(parent, text)
	local T = Instance.new("TextLabel")
	T.Size = UDim2.new(1, -24, 0, 30)
	T.Position = UDim2.fromOffset(12, 8)
	T.BackgroundTransparency = 1
	T.Text = text
	T.TextColor3 = Color3.fromRGB(255, 255, 255)
	T.TextSize = 16
	T.Font = Enum.Font.GothamBold
	T.TextXAlignment = Enum.TextXAlignment.Left
	T.Parent = parent
	return T
end

local HomeBtn    = SideButton("☆  Home", "Home")
local CombatBtn  = SideButton("⚔  Combat", "Combat")
local PlayersBtn = SideButton("♙  Players", "Players")
local UpdatesBtn = SideButton("⚡  Updates", "Updates")

local function ShowPage(name)
	for pname, page in pairs(pages) do page.Visible = (pname == name) end
	for bname, data in pairs(sideBtns) do
		if bname == name then
			data.stroke.Color = CONFIG.NeonColor
			data.btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			data.stroke.Color = Color3.fromRGB(40, 40, 40)
			data.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
end

HomeBtn.Activated:Connect(function() ShowPage("Home") end)
CombatBtn.Activated:Connect(function() ShowPage("Combat") end)
PlayersBtn.Activated:Connect(function() ShowPage("Players") end)
UpdatesBtn.Activated:Connect(function() ShowPage("Updates") end)

PageTitle(HomePage, "Home")
local HT = Instance.new("TextLabel")
HT.Size = UDim2.new(1, -24, 1, -50)
HT.Position = UDim2.fromOffset(12, 42)
HT.BackgroundTransparency = 1
HT.Text = "Welcome to Shaw Hub\n\nCombat -> Kill Aura + Anti-Hit\nPlayers -> Teleport\nUpdates -> Changelog"
HT.TextColor3 = Color3.fromRGB(190, 190, 190)
HT.TextSize = 12
HT.Font = Enum.Font.Gotham
HT.TextXAlignment = Enum.TextXAlignment.Left
HT.TextYAlignment = Enum.TextYAlignment.Top
HT.TextWrapped = true
HT.Parent = HomePage

PageTitle(CombatPage, "Combat")

local AuraEnabled = false
local AuraBtn = Instance.new("TextButton")
AuraBtn.Size = UDim2.new(1, -24, 0, 40)
AuraBtn.Position = UDim2.fromOffset(12, 44)
AuraBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AuraBtn.BorderSizePixel = 0
AuraBtn.Text = "Kill Aura     OFF"
AuraBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AuraBtn.TextSize = 13
AuraBtn.Font = Enum.Font.GothamMedium
AuraBtn.TextXAlignment = Enum.TextXAlignment.Left
AuraBtn.Parent = CombatPage

local AP = Instance.new("UIPadding")
AP.PaddingLeft = UDim.new(0, 12)
AP.Parent = AuraBtn

local AC = Instance.new("UICorner")
AC.CornerRadius = UDim.new(0, 7)
AC.Parent = AuraBtn

local AS = Instance.new("UIStroke")
AS.Color = Color3.fromRGB(40, 40, 40)
AS.Thickness = 1
AS.Parent = AuraBtn

AuraBtn.Activated:Connect(function()
	AuraEnabled = not AuraEnabled
	AuraBtn.Text = AuraEnabled and "Kill Aura     ON" or "Kill Aura     OFF"
end)

local RangeInfo = Instance.new("TextLabel")
RangeInfo.Size = UDim2.new(1, -24, 0, 20)
RangeInfo.Position = UDim2.fromOffset(12, 90)
RangeInfo.BackgroundTransparency = 1
RangeInfo.Text = "Range: " .. CONFIG.KillAuraRange .. " (edit CONFIG)"
RangeInfo.TextColor3 = Color3.fromRGB(170, 170, 170)
RangeInfo.TextSize = 10
RangeInfo.Font = Enum.Font.Gotham
RangeInfo.TextXAlignment = Enum.TextXAlignment.Left
RangeInfo.Parent = CombatPage

local AntiEnabled = false
local AntiBtn = Instance.new("TextButton")
AntiBtn.Size = UDim2.new(1, -24, 0, 40)
AntiBtn.Position = UDim2.fromOffset(12, 116)
AntiBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AntiBtn.BorderSizePixel = 0
AntiBtn.Text = "Anti-Hit     OFF"
AntiBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AntiBtn.TextSize = 13
AntiBtn.Font = Enum.Font.GothamMedium
AntiBtn.TextXAlignment = Enum.TextXAlignment.Left
AntiBtn.Parent = CombatPage

local AnP = Instance.new("UIPadding")
AnP.PaddingLeft = UDim.new(0, 12)
AnP.Parent = AntiBtn

local AnC = Instance.new("UICorner")
AnC.CornerRadius = UDim.new(0, 7)
AnC.Parent = AntiBtn

local AnS = Instance.new("UIStroke")
AnS.Color = Color3.fromRGB(40, 40, 40)
AnS.Thickness = 1
AnS.Parent = AntiBtn

local function applyAnti()
	if not AntiEnabled then return end
	local ch = Player.Character
	if not ch then return end
	local h = ch:FindFirstChildOfClass("Humanoid")
	if h then pcall(function() h.MaxHealth = math.huge; h.Health = math.huge end) end
	if not ch:FindFirstChildOfClass("ForceField") then
		local ff = Instance.new("ForceField")
		ff.Visible = false
		ff.Parent = ch
	end
end

AntiBtn.Activated:Connect(function()
	AntiEnabled = not AntiEnabled
	AntiBtn.Text = AntiEnabled and "Anti-Hit     ON" or "Anti-Hit     OFF"
	applyAnti()
end)

Player.CharacterAdded:Connect(function()
	task.wait(0.5)
	applyAnti()
end)

RunService.Heartbeat:Connect(function() applyAnti() end)

PageTitle(PlayersPage, "Players")
local Plist = Instance.new("ScrollingFrame")
Plist.Size = UDim2.new(1, -24, 1, -50)
Plist.Position = UDim2.fromOffset(12, 42)
Plist.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Plist.BorderSizePixel = 0
Plist.ScrollBarThickness = 3
Plist.CanvasSize = UDim2.new(0, 0, 0, 0)
Plist.Parent = PlayersPage

local PL = Instance.new("UIListLayout")
PL.Padding = UDim.new(0, 3)
PL.Parent = Plist

PL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Plist.CanvasSize = UDim2.fromOffset(0, PL.AbsoluteContentSize.Y + 8)
end)

local function RefreshPlayers()
	for _, c in ipairs(Plist:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	for _, t in ipairs(Players:GetPlayers()) do
		if t ~= Player then
			local B = Instance.new("TextButton")
			B.Size = UDim2.new(1, -6, 0, 28)
			B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			B.BorderSizePixel = 0
			B.Text = "  " .. t.DisplayName
			B.TextColor3 = Color3.fromRGB(220, 220, 220)
			B.TextSize = 11
			B.Font = Enum.Font.Gotham
			B.TextXAlignment = Enum.TextXAlignment.Left
			B.Parent = Plist
			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(0, 5)
			c.Parent = B
			local s = Instance.new("UIStroke")
			s.Color = Color3.fromRGB(40, 40, 40)
			s.Thickness = 1
			s.Parent = B
			B.Activated:Connect(function()
				local mc = Player.Character
				local tc = t.Character
				if mc and tc then
					local mr = mc:FindFirstChild("HumanoidRootPart")
					local tr = tc:FindFirstChild("HumanoidRootPart")
					if mr and tr then mr.CFrame = tr.CFrame + Vector3.new(3, 0, 0) end
				end
			end)
		end
	end
end

RefreshPlayers()
Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

PageTitle(UpdatesPage, "Updates")
local UT = Instance.new("TextLabel")
UT.Size = UDim2.new(1, -24, 1, -50)
UT.Position = UDim2.fromOffset(12, 42)
UT.BackgroundTransparency = 1
UT.Text = "v3\n\n+ Fixed GUI so it shows in Delta\n+ Uses PlayerGui directly\n+ Working tabs\n+ Kill Aura / Anti-Hit\n+ Draggable window + square"
UT.TextColor3 = Color3.fromRGB(190, 190, 190)
UT.TextSize = 12
UT.Font = Enum.Font.Gotham
UT.TextXAlignment = Enum.TextXAlignment.Left
UT.TextYAlignment = Enum.TextYAlignment.Top
UT.TextWrapped = true
UT.Parent = UpdatesPage

local Mini = Instance.new("TextButton")
Mini.Size = UDim2.fromOffset(52, 52)
Mini.Position = UDim2.new(0, 12, 0.5, -26)
Mini.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Mini.BorderSizePixel = 0
Mini.Text = "SH"
Mini.TextColor3 = Color3.fromRGB(255, 255, 255)
Mini.TextSize = 14
Mini.Font = Enum.Font.GothamBold
Mini.Visible = false
Mini.Active = true
Mini.Parent = Gui

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 8)
MC.Parent = Mini

local MS = Instance.new("UIStroke")
MS.Color = CONFIG.NeonColor
MS.Thickness = 1.6
MS.Parent = Mini

makeDraggable(Mini, Mini)

local miniPressPos, miniWasDrag
Mini.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		miniPressPos = input.Position
		miniWasDrag = false
	end
end)
Mini.InputChanged:Connect(function(input)
	if not miniPressPos then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
		if (input.Position - miniPressPos).Magnitude > 6 then miniWasDrag = true end
	end
end)
Mini.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		if not miniWasDrag then
			Main.Visible = true
			Mini.Visible = false
		end
		miniPressPos = nil
	end
end)

Min.Activated:Connect(function()
	Main.Visible = false
	Mini.Visible = true
end)

local lastAtk = 0
local function findTarget()
	local ch = Player.Character
	if not ch then return nil end
	local r = ch:FindFirstChild("HumanoidRootPart")
	if not r then return nil end
	local best, bd = nil, CONFIG.KillAuraRange + 0.01
	for _, t in ipairs(Players:GetPlayers()) do
		if t ~= Player then
			local tc = t.Character
			if tc then
				local tr = tc:FindFirstChild("HumanoidRootPart")
				local th = tc:FindFirstChildOfClass("Humanoid")
				if tr and th and th.Health > 0 then
					local d = (r.Position - tr.Position).Magnitude
					if d <= bd then best, bd = t, d end
				end
			end
		end
	end
	return best
end

RunService.Heartbeat:Connect(function()
	if not AuraEnabled then return end
	if tick() - lastAtk < CONFIG.KillAuraDelay then return end
	local ch = Player.Character
	if not ch then return end
	local r = ch:FindFirstChild("HumanoidRootPart")
	local h = ch:FindFirstChildOfClass("Humanoid")
	if not r or not h or h.Health <= 0 then return end
	local t = findTarget()
	if not t then return end
	lastAtk = tick()
	if CONFIG.AuraAutoFace then
		local tr = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
		if tr then
			local la = Vector3.new(tr.Position.X, r.Position.Y, tr.Position.Z)
			if (la - r.Position).Magnitude > 0.05 then
				r.CFrame = CFrame.new(r.Position, la)
			end
		end
	end
	local tool = ch:FindFirstChildOfClass("Tool")
	if tool then pcall(function() tool:Activate() end) end
end)

ShowPage("Home")
print("Shaw Hub v3 loaded")
