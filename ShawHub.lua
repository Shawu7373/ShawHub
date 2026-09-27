--// SHAW HUB v2
--// Studio: LocalScript in StarterPlayer > StarterPlayerScripts
--// Executor: paste into any Script executor

--==================================================
-- CONFIG — edit these values
--==================================================
local CONFIG = {
	KillAuraRange   = 1,                    -- set to 1, 10, 50, 100 ...
	KillAuraDelay   = 0.1,                  -- seconds between attacks
	AuraAutoFace    = true,
	NeonColor       = Color3.fromRGB(0, 255, 255), -- edge line color
}

--==================================================
-- SERVICES
--==================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- GUI PARENT
--==================================================
local GuiParent = nil

pcall(function()
	if gethui then
		local h = gethui()
		if h then GuiParent = h end
	end
end)

if not GuiParent then
	pcall(function()
		local cg = game:GetService("CoreGui")
		local t = Instance.new("Folder")
		t.Parent = cg
		t:Destroy()
		GuiParent = cg
	end)
end

if not GuiParent and Player then
	pcall(function()
		GuiParent = Player:WaitForChild("PlayerGui", 10)
	end)
end

if not GuiParent then
	warn("Shaw Hub: could not find a GUI parent")
	return
end

for _, v in ipairs(GuiParent:GetChildren()) do
	if v.Name == "ShawHub" then
		v:Destroy()
	end
end

--==================================================
-- GUI
--==================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "ShawHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999999
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Enabled = true
Gui.Parent = GuiParent

--==================================================
-- MAIN WINDOW
--==================================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(470, 310)
Main.Position = UDim2.new(0.5, -235, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BackgroundTransparency = 0
Main.BorderSizePixel = 0
Main.Visible = true
Main.Active = true
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

-- neon edge
local NeonStroke = Instance.new("UIStroke")
NeonStroke.Color = CONFIG.NeonColor
NeonStroke.Thickness = 1.6
NeonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
NeonStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 48)
Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Top.BackgroundTransparency = 0
Top.BorderSizePixel = 0
Top.Active = true
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.fromOffset(18, 0)
Title.BackgroundTransparency = 1
Title.Text = "Shaw Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -100, 0, 16)
SubTitle.Position = UDim2.fromOffset(18, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "99 NITF"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Top

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38, 38)
Minimize.Position = UDim2.new(1, -82, 0, 5)
Minimize.BackgroundTransparency = 1
Minimize.Text = "−"
Minimize.TextColor3 = Color3.fromRGB(200, 200, 200)
Minimize.TextSize = 24
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -43, 0, 5)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(200, 200, 200)
Close.TextSize = 23
Close.Font = Enum.Font.Gotham
Close.Parent = Top

--==================================================
-- CLOSE CONFIRM DIALOG
--==================================================
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Name = "ConfirmDialog"
ConfirmFrame.Size = UDim2.fromOffset(280, 120)
ConfirmFrame.Position = UDim2.new(0.5, -140, 0.5, -60)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConfirmFrame.BorderSizePixel = 0
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 50
ConfirmFrame.Active = true
ConfirmFrame.Parent = Gui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 10)
ConfirmCorner.Parent = ConfirmFrame

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = CONFIG.NeonColor
ConfirmStroke.Thickness = 1.6
ConfirmStroke.Parent = ConfirmFrame

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size = UDim2.new(1, -20, 0, 40)
ConfirmText.Position = UDim2.fromOffset(10, 15)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Close the whole script?"
ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmText.TextSize = 14
ConfirmText.Font = Enum.Font.GothamBold
ConfirmText.Parent = ConfirmFrame

local ConfirmYes = Instance.new("TextButton")
ConfirmYes.Size = UDim2.new(0.5, -20, 0, 40)
ConfirmYes.Position = UDim2.new(0, 10, 1, -55)
ConfirmYes.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
ConfirmYes.BorderSizePixel = 0
ConfirmYes.Text = "Close Script"
ConfirmYes.TextColor3 = Color3.fromRGB(255, 90, 90)
ConfirmYes.TextSize = 12
ConfirmYes.Font = Enum.Font.GothamBold
ConfirmYes.Parent = ConfirmFrame

local ConfirmYesCorner = Instance.new("UICorner")
ConfirmYesCorner.CornerRadius = UDim.new(0, 6)
ConfirmYesCorner.Parent = ConfirmYes

local ConfirmYesStroke = Instance.new("UIStroke")
ConfirmYesStroke.Color = Color3.fromRGB(255, 80, 80)
ConfirmYesStroke.Thickness = 1.2
ConfirmYesStroke.Parent = ConfirmYes

local ConfirmNo = Instance.new("TextButton")
ConfirmNo.Size = UDim2.new(0.5, -20, 0, 40)
ConfirmNo.Position = UDim2.new(0.5, 10, 1, -55)
ConfirmNo.BackgroundColor3 = Color3.fromRGB(0, 10, 10)
ConfirmNo.BorderSizePixel = 0
ConfirmNo.Text = "Cancel"
ConfirmNo.TextColor3 = Color3.fromRGB(200, 200, 200)
ConfirmNo.TextSize = 12
ConfirmNo.Font = Enum.Font.GothamBold
ConfirmNo.Parent = ConfirmFrame

local ConfirmNoCorner = Instance.new("UICorner")
ConfirmNoCorner.CornerRadius = UDim.new(0, 6)
ConfirmNoCorner.Parent = ConfirmNo

local ConfirmNoStroke = Instance.new("UIStroke")
ConfirmNoStroke.Color = Color3.fromRGB(60, 60, 60)
ConfirmNoStroke.Thickness = 1.2
ConfirmNoStroke.Parent = ConfirmNo

Close.Activated:Connect(function()
	ConfirmFrame.Visible = true
end)

ConfirmNo.Activated:Connect(function()
	ConfirmFrame.Visible = false
end)

ConfirmYes.Activated:Connect(function()
	ConfirmFrame.Visible = false
	if Gui then Gui:Destroy() end
end)

--==================================================
-- LEFT SIDEBAR
--==================================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -48)
Sidebar.Position = UDim2.fromOffset(0, 48)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BackgroundTransparency = 0
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 4)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.Parent = Sidebar

local sideButtons = {}

local function SideButton(text, pageName)
	local B = Instance.new("TextButton")
	B.Size = UDim2.fromOffset(112, 36)
	B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	B.BackgroundTransparency = 0
	B.BorderSizePixel = 0
	B.Text = text
	B.TextColor3 = Color3.fromRGB(200, 200, 200)
	B.TextSize = 12
	B.Font = Enum.Font.Gotham
	B.Parent = Sidebar

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0, 7)
	C.Parent = B

	local S = Instance.new("UIStroke")
	S.Color = Color3.fromRGB(40, 40, 40)
	S.Thickness = 1
	S.Parent = B

	sideButtons[pageName] = {button = B, stroke = S}
	return B
end

--==================================================
-- PAGES CONTAINER
--==================================================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -130, 1, -48)
Content.Position = UDim2.fromOffset(130, 48)
Content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Content.BackgroundTransparency = 0
Content.BorderSizePixel = 0
Content.Parent = Main

local pages = {}

local function makePage(name)
	local P = Instance.new("Frame")
	P.Name = name
	P.Size = UDim2.new(1, 0, 1, 0)
	P.Position = UDim2.fromOffset(0, 0)
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
	T.Size = UDim2.new(1, -30, 0, 35)
	T.Position = UDim2.fromOffset(15, 10)
	T.BackgroundTransparency = 1
	T.Text = text
	T.TextColor3 = Color3.fromRGB(255, 255, 255)
	T.TextSize = 18
	T.Font = Enum.Font.GothamBold
	T.TextXAlignment = Enum.TextXAlignment.Left
	T.Parent = parent
	return T
end

-- sidebar entries
local HomeBtn    = SideButton("☆  Home", "Home")
local CombatBtn  = SideButton("⚔  Combat", "Combat")
local PlayersBtn = SideButton("♙  Players", "Players")
local UpdatesBtn = SideButton("⚡  Updates", "Updates")

local function ShowPage(name)
	for pname, page in pairs(pages) do
		page.Visible = (pname == name)
	end
	for bname, data in pairs(sideButtons) do
		if bname == name then
			data.stroke.Color = CONFIG.NeonColor
			data.button.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			data.stroke.Color = Color3.fromRGB(40, 40, 40)
			data.button.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
end

HomeBtn.Activated:Connect(function()    ShowPage("Home") end)
CombatBtn.Activated:Connect(function()  ShowPage("Combat") end)
PlayersBtn.Activated:Connect(function() ShowPage("Players") end)
UpdatesBtn.Activated:Connect(function() ShowPage("Updates") end)

--==================================================
-- HOME PAGE
--==================================================
PageTitle(HomePage, "Home")

local HomeText = Instance.new("TextLabel")
HomeText.Size = UDim2.new(1, -30, 1, -60)
HomeText.Position = UDim2.fromOffset(15, 50)
HomeText.BackgroundTransparency = 1
HomeText.Text = "Welcome to Shaw Hub\n\nUse the sidebar to switch pages.\n\nCombat  → Kill Aura + Anti-Hit\nPlayers → Teleport to any player\nUpdates → Changelog"
HomeText.TextColor3 = Color3.fromRGB(190, 190, 190)
HomeText.TextSize = 13
HomeText.Font = Enum.Font.Gotham
HomeText.TextXAlignment = Enum.TextXAlignment.Left
HomeText.TextYAlignment = Enum.TextYAlignment.Top
HomeText.TextWrapped = true
HomeText.Parent = HomePage

--==================================================
-- COMBAT PAGE
--==================================================
PageTitle(CombatPage, "Combat")

-- Kill Aura toggle
local AuraEnabled = false

local AuraButton = Instance.new("TextButton")
AuraButton.Size = UDim2.new(1, -30, 0, 48)
AuraButton.Position = UDim2.fromOffset(15, 55)
AuraButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AuraButton.BorderSizePixel = 0
AuraButton.Text = "Kill Aura     OFF"
AuraButton.TextColor3 = Color3.fromRGB(220, 220, 220)
AuraButton.TextSize = 14
AuraButton.Font = Enum.Font.GothamMedium
AuraButton.TextXAlignment = Enum.TextXAlignment.Left
AuraButton.Parent = CombatPage

local AuraPad = Instance.new("UIPadding")
AuraPad.PaddingLeft = UDim.new(0, 15)
AuraPad.Parent = AuraButton

local AuraCorner = Instance.new("UICorner")
AuraCorner.CornerRadius = UDim.new(0, 8)
AuraCorner.Parent = AuraButton

local AuraStroke = Instance.new("UIStroke")
AuraStroke.Color = Color3.fromRGB(40, 40, 40)
AuraStroke.Thickness = 1
AuraStroke.Parent = AuraButton

AuraButton.Activated:Connect(function()
	AuraEnabled = not AuraEnabled
	AuraButton.Text = AuraEnabled and "Kill Aura     ON" or "Kill Aura     OFF"
end)

-- range info label
local RangeInfo = Instance.new("TextLabel")
RangeInfo.Size = UDim2.new(1, -30, 0, 24)
RangeInfo.Position = UDim2.fromOffset(15, 112)
RangeInfo.BackgroundTransparency = 1
RangeInfo.Text = "Kill Aura Range: " .. CONFIG.KillAuraRange .. "   (edit CONFIG.KillAuraRange in script)"
RangeInfo.TextColor3 = Color3.fromRGB(170, 170, 170)
RangeInfo.TextSize = 11
RangeInfo.Font = Enum.Font.Gotham
RangeInfo.TextXAlignment = Enum.TextXAlignment.Left
RangeInfo.Parent = CombatPage

-- Anti-Hit toggle
local AntiHitEnabled = false

local AntiHitButton = Instance.new("TextButton")
AntiHitButton.Size = UDim2.new(1, -30, 0, 48)
AntiHitButton.Position = UDim2.fromOffset(15, 145)
AntiHitButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AntiHitButton.BorderSizePixel = 0
AntiHitButton.Text = "Anti-Hit     OFF"
AntiHitButton.TextColor3 = Color3.fromRGB(220, 220, 220)
AntiHitButton.TextSize = 14
AntiHitButton.Font = Enum.Font.GothamMedium
AntiHitButton.TextXAlignment = Enum.TextXAlignment.Left
AntiHitButton.Parent = CombatPage

local AntiPad = Instance.new("UIPadding")
AntiPad.PaddingLeft = UDim.new(0, 15)
AntiPad.Parent = AntiHitButton

local AntiCorner = Instance.new("UICorner")
AntiCorner.CornerRadius = UDim.new(0, 8)
AntiCorner.Parent = AntiHitButton

local AntiStroke = Instance.new("UIStroke")
AntiStroke.Color = Color3.fromRGB(40, 40, 40)
AntiStroke.Thickness = 1
AntiStroke.Parent = AntiHitButton

-- Anti-hit implementation
local function applyAntiHit()
	if not AntiHitEnabled then return end
	local char = Player and Player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		pcall(function()
			hum.MaxHealth = math.huge
			hum.Health = math.huge
		end)
	end

	if not char:FindFirstChildOfClass("ForceField") then
		local ff = Instance.new("ForceField")
		ff.Visible = false
		ff.Parent = char
	end
end

local function removeAntiHit()
	local char = Player and Player.Character
	if not char then return end
	local ff = char:FindFirstChildOfClass("ForceField")
	if ff then ff:Destroy() end
end

AntiHitButton.Activated:Connect(function()
	AntiHitEnabled = not AntiHitEnabled
	AntiHitButton.Text = AntiHitEnabled and "Anti-Hit     ON" or "Anti-Hit     OFF"
	if AntiHitEnabled then
		applyAntiHit()
	else
		removeAntiHit()
	end
end)

if Player then
	Player.CharacterAdded:Connect(function()
		task.wait(0.5)
		applyAntiHit()
	end)
end

RunService.Heartbeat:Connect(function()
	if AntiHitEnabled then
		applyAntiHit()
	end
end)

--==================================================
-- PLAYERS PAGE
--==================================================
PageTitle(PlayersPage, "Players")

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -30, 1, -60)
PlayerList.Position = UDim2.fromOffset(15, 50)
PlayerList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = PlayersPage

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Padding = UDim.new(0, 4)
PlayerLayout.Parent = PlayerList

PlayerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	PlayerList.CanvasSize = UDim2.fromOffset(0, PlayerLayout.AbsoluteContentSize.Y + 10)
end)

local function RefreshPlayers()
	for _, child in ipairs(PlayerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	if not Player then return end

	for _, target in ipairs(Players:GetPlayers()) do
		if target ~= Player then
			local B = Instance.new("TextButton")
			B.Size = UDim2.new(1, -6, 0, 30)
			B.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			B.BorderSizePixel = 0
			B.Text = "  " .. target.DisplayName .. "  (@" .. target.Name .. ")"
			B.TextColor3 = Color3.fromRGB(220, 220, 220)
			B.TextSize = 11
			B.Font = Enum.Font.Gotham
			B.TextXAlignment = Enum.TextXAlignment.Left
			B.Parent = PlayerList

			local C = Instance.new("UICorner")
			C.CornerRadius = UDim.new(0, 5)
			C.Parent = B

			local S = Instance.new("UIStroke")
			S.Color = Color3.fromRGB(40, 40, 40)
			S.Thickness = 1
			S.Parent = B

			B.Activated:Connect(function()
				local myCharacter = Player.Character
				local targetCharacter = target.Character
				if myCharacter and targetCharacter then
					local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
					local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
					if myRoot and targetRoot then
						myRoot.CFrame = targetRoot.CFrame + Vector3.new(3, 0, 0)
					end
				end
			end)
		end
	end
end

RefreshPlayers()
Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

--==================================================
-- UPDATES PAGE
--==================================================
Page
