 --// SHAW HUB v5 — Credits, God Mode, Red Neon, Fixed Fly
local CONFIG = {
	KillAuraRange = 1,
	KillAuraDelay = 0.1,
	AuraAutoFace  = true,
	NeonColor     = Color3.fromRGB(255, 0, 0),
	WalkSpeed     = 50,
	JumpPower     = 100,
	FlySpeed      = 80,
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local GuiParent = Player:WaitForChild("PlayerGui")

-- Wipe any stuck Shaw Hub instances (fixes "remains forever" bug)
for _, v in ipairs(GuiParent:GetChildren()) do
	if v.Name == "ShawHub" or v.Name == "ShawMini" then
		pcall(function() v:Destroy() end)
	end
end
pcall(function()
	local cg = game:GetService("CoreGui")
	for _, v in ipairs(cg:GetChildren()) do
		if v.Name == "ShawHub" then v:Destroy() end
	end
end)

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
Main.Name = "Main"
Main.Size = UDim2.fromOffset(420, 340)
Main.Position = UDim2.new(0.5, -210, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Visible = true
Main.Parent = Gui

local C = Instance.new("UICorner")
C.CornerRadius = UDim.new(0, 12)
C.Parent = Main

local NS = Instance.new("UIStroke")
NS.Color = CONFIG.NeonColor
NS.Thickness = 1.8
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
Title.Text = "Shaw Hub v5"
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
CS.Thickness = 1.8
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
SL.Padding = UDim.new(0, 3)
SL.HorizontalAlignment = Enum.HorizontalAlignment.Center
SL.SortOrder = Enum.SortOrder.LayoutOrder
SL.Parent = Sidebar

local SP = Instance.new("UIPadding")
SP.PaddingTop = UDim.new(0, 6)
SP.Parent = Sidebar

local sideBtns = {}
local function SideButton(text, name)
	local B = Instance.new("TextButton")
	B.Size = UDim2.fromOffset(94, 28)
	B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	B.BorderSizePixel = 0
	B.Text = text
	B.TextColor3 = Color3.fromRGB(200, 200, 200)
	B.TextSize = 10
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

local HomePage     = makePage("Home")
local CombatPage   = makePage("Combat")
local MovementPage = makePage("Movement")
local VisualPage   = makePage("Visual")
local NightsPage   = makePage("Nights")
local PlayersPage  = makePage("Players")
local CreditsPage  = makePage("Credits")
local UpdatesPage  = makePage("Updates")

local function PageTitle(parent, text)
	local T = Instance.new("TextLabel")
	T.Size = UDim2.new(1, -24, 0, 26)
	T.Position = UDim2.fromOffset(12, 4)
	T.BackgroundTransparency = 1
	T.Text = text
	T.TextColor3 = Color3.fromRGB(255, 255, 255)
	T.TextSize = 15
	T.Font = Enum.Font.GothamBold
	T.TextXAlignment = Enum.TextXAlignment.Left
	T.Parent = parent
	return T
end

local function ToggleBtn(parent, y, label)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1, -24, 0, 30)
	B.Position = UDim2.fromOffset(12, y)
	B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	B.BorderSizePixel = 0
	B.Text = label .. "     OFF"
	B.TextColor3 = Color3.fromRGB(220, 220, 220)
	B.TextSize = 11
	B.Font = Enum.Font.GothamMedium
	B.TextXAlignment = Enum.TextXAlignment.Left
	B.Parent = parent
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, 12)
	p.Parent = B
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 7)
	c.Parent = B
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(40, 40, 40)
	s.Thickness = 1
	s.Parent = B
	return B
end

local function setLabel(btn, label, on)
	btn.Text = label .. (on and "     ON" or "     OFF")
end

local HomeBtn     = SideButton("☆  Home", "Home")
local CombatBtn   = SideButton("⚔  Combat", "Combat")
local MoveBtn     = SideButton("➤  Move", "Movement")
local VisualBtn   = SideButton("👁  Visual", "Visual")
local NightsBtn   = SideButton("🌲  99 Nights", "Nights")
local PlayersBtn  = SideButton("♙  Players", "Players")
local CreditsBtn  = SideButton("★  Credits", "Credits")
local UpdatesBtn  = SideButton("⚡  Updates", "Updates")

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
MoveBtn.Activated:Connect(function() ShowPage("Movement") end)
VisualBtn.Activated:Connect(function() ShowPage("Visual") end)
NightsBtn.Activated:Connect(function() ShowPage("Nights") end)
PlayersBtn.Activated:Connect(function() ShowPage("Players") end)
CreditsBtn.Activated:Connect(function() ShowPage("Credits") end)
UpdatesBtn.Activated:Connect(function() ShowPage("Updates") end)

-- HOME
PageTitle(HomePage, "Home")
local HT = Instance.new("TextLabel")
HT.Size = UDim2.new(1, -24, 1, -40)
HT.Position = UDim2.fromOffset(12, 34)
HT.BackgroundTransparency = 1
HT.Text = "Welcome to Shaw Hub v5\n\nCombat    -> Kill Aura + Anti-Hit\nMove      -> Speed, Jump, Fly, Noclip\nVisual    -> Fullbright, ESP\n99 Nights -> God Mode + helpers\nPlayers   -> Teleport to players\nCredits   -> About this hub"
HT.TextColor3 = Color3.fromRGB(190, 190, 190)
HT.TextSize = 11
HT.Font = Enum.Font.Gotham
HT.TextXAlignment = Enum.TextXAlignment.Left
HT.TextYAlignment = Enum.TextYAlignment.Top
HT.TextWrapped = true
HT.Parent = HomePage

-- COMBAT
PageTitle(CombatPage, "Combat")

local AuraEnabled = false
local AuraBtn = ToggleBtn(CombatPage, 34, "Kill Aura")
AuraBtn.Activated:Connect(function()
	AuraEnabled = not AuraEnabled
	setLabel(AuraBtn, "Kill Aura", AuraEnabled)
end)

local AntiEnabled = false
local AntiBtn = ToggleBtn(CombatPage, 68, "Anti-Hit")
AntiBtn.Activated:Connect(function()
	AntiEnabled = not AntiEnabled
	setLabel(AntiBtn, "Anti-Hit", AntiEnabled)
end)

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

Player.CharacterAdded:Connect(function() task.wait(0.5) applyAnti() end)

-- MOVEMENT
PageTitle(MovementPage, "Movement")

local speedEnabled = false
local speedBtn = ToggleBtn(MovementPage, 34, "Speed Boost")
speedBtn.Activated:Connect(function()
	speedEnabled = not speedEnabled
	setLabel(speedBtn, "Speed Boost", speedEnabled)
end)

local jumpEnabled = false
local jumpBtn = ToggleBtn(MovementPage, 68, "Jump Boost")
jumpBtn.Activated:Connect(function()
	jumpEnabled = not jumpEnabled
	setLabel(jumpBtn, "Jump Boost", jumpEnabled)
end)

local infJumpEnabled = false
local infJumpBtn = ToggleBtn(MovementPage, 102, "Infinite Jump")
infJumpBtn.Activated:Connect(function()
	infJumpEnabled = not infJumpEnabled
	setLabel(infJumpBtn, "Infinite Jump", infJumpEnabled)
end)

local flyEnabled = false
local flyBtn = ToggleBtn(MovementPage, 136, "Fly")
flyBtn.Activated:Connect(function()
	flyEnabled = not flyEnabled
	setLabel(flyBtn, "Fly", flyEnabled)
end)

local noclipEnabled = false
local noclipBtn = ToggleBtn(MovementPage, 170, "Noclip")
noclipBtn.Activated:Connect(function()
	noclipEnabled = not noclipEnabled
	setLabel(noclipBtn, "Noclip", noclipEnabled)
end)

UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled then
		local ch = Player.Character
		local h = ch and ch:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

local flyBV
local function clearFly()
	if flyBV then flyBV:Destroy(); flyBV = nil end
end

-- VISUAL
PageTitle(VisualPage, "Visual")

local savedAmbient = Lighting.Ambient
local savedOutdoor = Lighting.OutdoorAmbient
local savedBrightness = Lighting.Brightness
local savedFogEnd = Lighting.FogEnd

local brightEnabled = false
local brightBtn = ToggleBtn(VisualPage, 34, "Fullbright")
brightBtn.Activated:Connect(function()
	brightEnabled = not brightEnabled
	setLabel(brightBtn, "Fullbright", brightEnabled)
	if brightEnabled then
		Lighting.Ambient = Color3.fromRGB(255,255,255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
		Lighting.Brightness = 3
		Lighting.FogEnd = 100000
	else
		Lighting.Ambient = savedAmbient
		Lighting.OutdoorAmbient = savedOutdoor
		Lighting.Brightness = savedBrightness
		Lighting.FogEnd = savedFogEnd
	end
end)

local espEnabled = false
local espBtn = ToggleBtn(VisualPage, 68, "Player ESP")
local espBoxes = {}

local function createESP(plr)
	if espBoxes[plr] then return end
	local ch = plr.Character
	if not ch then return end
	local root = ch:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local box = Instance.new("BoxHandleAdornment")
	box.Size = Vector3.new(4, 5, 4)
	box.Adornee = root
	box.AlwaysOnTop = true
	box.ZIndex = 5
	box.Transparency = 0.4
	box.Color3 = Color3.fromRGB(255, 0, 0)
	box.Parent = ch
	espBoxes[plr] = box
end

local function removeESP(plr)
	if espBoxes[plr] then
		espBoxes[plr]:Destroy()
		espBoxes[plr] = nil
	end
end

espBtn.Activated:Connect(function()
	espEnabled = not espEnabled
	setLabel(espBtn, "Player ESP", espEnabled)
	if espEnabled then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= Player and p.Character then createESP(p) end
		end
	else
		for p, _ in pairs(espBoxes) do removeESP(p) end
	end
end)

Players.PlayerAdded:Connect(function(p)
	if espEnabled then
		p.CharacterAdded:Connect(function() task.wait(1); createESP(p) end)
	end
end)

-- 99 NIGHTS
PageTitle(NightsPage, "99 Nights in the Forest")

local GodEnabled = false
local godBtn = ToggleBtn(NightsPage, 34, "God Mode")
godBtn.Activated:Connect(function()
	GodEnabled = not GodEnabled
	setLabel(godBtn, "God Mode", GodEnabled)
end)

local treeEnabled = false
local treeBtn = ToggleBtn(NightsPage, 68, "Auto Chop Trees")
treeBtn.Activated:Connect(function()
	treeEnabled = not treeEnabled
	setLabel(treeBtn, "Auto Chop Trees", treeEnabled)
end)

local bringEnabled = false
local bringBtn = ToggleBtn(NightsPage, 102, "Bring Items")
bringBtn.Activated:Connect(function()
	bringEnabled = not bringEnabled
	setLabel(bringBtn, "Bring Items", bringEnabled)
	if bringEnabled then
		local ch = Player.Character
		local root = ch and ch:FindFirstChild("HumanoidRootPart")
		if root then
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Name:lower():find("wood") or obj.Name:lower():find("log") or obj.Name:lower():find("stone")) then
					pcall(function()
						obj.CFrame = root.CFrame + Vector3.new(math.random(-5,5), 2, math.random(-5,5))
					end)
				end
			end
		end
	end
end)

local function applyGod()
	if not GodEnabled then return end
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

-- PLAYERS
PageTitle(PlayersPage, "Players")
local Plist = Instance.new("ScrollingFrame")
Plist.Size = UDim2.new(1, -24, 1, -40)
Plist.Position = UDim2.fromOffset(12, 34)
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
			B.Size = UDim2.new(1, -6, 0, 26)
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

-- CREDITS
PageTitle(CreditsPage, "Credits")
local CRT = Instance.new("TextLabel")
CRT.Size = UDim2.new(1, -24, 1, -40)
CRT.Position = UDim2.fromOffset(12, 34)
CRT.BackgroundTransparency = 1
CRT.Text = "★  This hub was created by Shaw  ★\n\nShaw Hub v5\nMade by: Shaw\nGitHub: Shawu7373\n\nThanks for using Shaw Hub!\n\nIf you enjoy it, share it with friends.\nMore features coming soon."
CRT.TextColor3 = Color3.fromRGB(255, 80, 80)
CRT.TextSize = 12
CRT.Font = Enum.Font.GothamBold
CRT.TextXAlignment = Enum.TextXAlignment.Left
CRT.TextYAlignment = Enum.TextYAlignment.Top
CRT.TextWrapped = true
CRT.Parent = CreditsPage

-- UPDATES
PageTitle(UpdatesPage, "Updates")
local UT = Instance.new("TextLabel")
UT.Size = UDim2.new(1, -24, 1, -40)
UT.Position = UDim2.fromOffset(12, 34)
UT.BackgroundTransparency = 1
UT.Text = "v5\n\n+ Neon is now RED\n+ Mini square says SW\n+ Credits tab: created by Shaw\n+ God Mode for 99 Nights\n+ Fixed Fly (works with mobile joystick)\n+ Fixed empty window rendering\n+ Better mini square dragging"
UT.TextColor3 = Color3.fromRGB(190, 190, 190)
UT.TextSize = 11
UT.Font = Enum.Font.Gotham
UT.TextXAlignment = Enum.TextXAlignment.Left
UT.TextYAlignment = Enum.TextYAlignment.Top
UT.TextWrapped = true
UT.Parent = UpdatesPage

-- MINI
local Mini = Instance.new("TextButton")
Mini.Name = "ShawMini"
Mini.Size = UDim2.fromOffset(54, 54)
Mini.Position = UDim2.new(0, 12, 0.5, -27)
Mini.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Mini.BorderSizePixel = 0
Mini.Text = "SW"
Mini.TextColor3 = Color3.fromRGB(255, 255, 255)
Mini.TextSize = 16
Mini.Font = Enum.Font.GothamBold
Mini.Visible = false
Mini.Active = true
Mini.Parent = Gui

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 10)
MC.Parent = Mini

local MS = Instance.new("UIStroke")
MS.Color = CONFIG.NeonColor
MS.Thickness = 1.8
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

-- MAIN LOOPS
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
	local ch = Player.Character
	if not ch then return end
	local h = ch:FindFirstChildOfClass("Humanoid")
	local root = ch:FindFirstChild("HumanoidRootPart")

	if h then
		h.WalkSpeed = speedEnabled and CONFIG.WalkSpeed or 16
		h.JumpPower = jumpEnabled and CONFIG.JumpPower or 50
		h.UseJumpPower = true
	end

	if noclipEnabled then
		for _, part in ipairs(ch:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	if flyEnabled and root and h then
		if not flyBV then
			flyBV = Instance.new("BodyVelocity")
			flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			flyBV.P = 1250
			flyBV.Parent = root
		end
		local moveDir = h.MoveDirection
		local vertical = 0
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = 1 end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vertical = -1 end
		flyBV.Velocity = (moveDir * CONFIG.FlySpeed) + Vector3.new(0, vertical * CONFIG.FlySpeed, 0)
	else
		clearFly()
	end

	applyAnti()
	applyGod()

	if AuraEnabled and tick() - lastAtk >= CONFIG.KillAuraDelay then
		if root and h and h.Health > 0 then
			local t = findTarget()
			if t then
				lastAtk = tick()
				if CONFIG.AuraAutoFace then
					local tr = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
					if tr then
						local la = Vector3.new(tr.Position.X, root.Position.Y, tr.Position.Z)
						if (la - root.Position).Magnitude > 0.05 then
							root.CFrame = CFrame.new(root.Position, la)
						end
					end
				end
				local tool = ch:FindFirstChildOfClass("Tool")
				if tool then pcall(function() tool:Activate() end) end
			end
		end
	end

	if treeEnabled and root then
		local tool = ch:FindFirstChildOfClass("Tool")
		if tool then
			local nearest, nd = nil, 30
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Name:lower():find("tree") or obj.Name:lower():find("wood") or obj.Name:lower():find("log")) then
					local d = (obj.Position - root.Position).Magnitude
					if d < nd then nearest, nd = obj, d end
				end
			end
			if nearest then
				root.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 3, 0))
				pcall(function() tool:Activate() end)
			end
		end
	end
end)

ShowPage("Home")
print("Shaw Hub v5 loaded — created by Shaw")
