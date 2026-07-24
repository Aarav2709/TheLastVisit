local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remote = ReplicatedStorage:WaitForChild("StartCreditsEvent")

local Settings = {
	FadeTime = 2,
	HoldBlackTime = 0.5,
	ScrollTime = 18,
	BackgroundColor = Color3.fromRGB(0, 0, 0),
	TextColor = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.GothamBold,
	TextSize = 36,
	TitleSize = 52,
	LineSpacing = 12,
	StrokeTransparency = 0.5,
	AllowRepeat = true, -- false = only plays once per player
}

local Credits = {
	{Type = "Title", Text = "The Last Visit"},
	{Type = "Space"},
	{Type = "Text", Text = "Created By"},
	{Type = "Text", Text = "Team Flow!"},
	{Type = "Space"},
	{Type = "Text", Text = "Programming"},
	{Type = "Text", Text = "@AarusPastime // Aarav Gupta"},
	{Type = "Text", Text = "@AarusPastime // Aarav Gupta"},
	{Type = "Space"},
	{Type = "Text", Text = "UI Design"},
	{Type = "Text", Text = "@AarusPastime // Aarav Gupta"},
	{Type = "Space"},
	{Type = "Text", Text = "Special Thanks"},
	{Type = "Text", Text = "John A Mathew, Manas Bhaiya"},
	{Type = "Space"},
	{Type = "Title", Text = "Thanks for Playing!"},
}

local hasPlayed = false
local playing = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CreditsGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Enabled = true
screenGui.Parent = playerGui

local blackFrame = Instance.new("Frame")
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.Position = UDim2.new(0, 0, 0, 0)
blackFrame.BackgroundColor3 = Settings.BackgroundColor
blackFrame.BackgroundTransparency = 1
blackFrame.BorderSizePixel = 0
blackFrame.Parent = screenGui

local creditsHolder = Instance.new("Frame")
creditsHolder.Size = UDim2.new(1, 0, 1, 0)
creditsHolder.Position = UDim2.new(0, 0, 0, 0)
creditsHolder.BackgroundTransparency = 1
creditsHolder.ClipsDescendants = true
creditsHolder.Parent = blackFrame

local creditsFrame = Instance.new("Frame")
creditsFrame.Size = UDim2.new(1, 0, 0, 0)
creditsFrame.BackgroundTransparency = 1
creditsFrame.Position = UDim2.new(0, 0, 1, 0)
creditsFrame.Parent = creditsHolder

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, Settings.LineSpacing)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = creditsFrame

local function clearCredits()
	for _, child in ipairs(creditsFrame:GetChildren()) do
		if not child:IsA("UIListLayout") then
			child:Destroy()
		end
	end
end

local function buildCredits()
	clearCredits()

	for i, item in ipairs(Credits) do
		if item.Type == "Space" then
			local spacer = Instance.new("Frame")
			spacer.Size = UDim2.new(1, 0, 0, 35)
			spacer.BackgroundTransparency = 1
			spacer.LayoutOrder = i
			spacer.Parent = creditsFrame
		else
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, -40, 0, item.Type == "Title" and 70 or 50)
			label.Text = item.Text or ""
			label.TextColor3 = Settings.TextColor
			label.Font = Settings.Font
			label.TextScaled = false
			label.TextWrapped = true
			label.TextSize = item.Type == "Title" and Settings.TitleSize or Settings.TextSize
			label.LayoutOrder = i
			label.Parent = creditsFrame

			local stroke = Instance.new("UIStroke")
			stroke.Transparency = Settings.StrokeTransparency
			stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			stroke.Parent = label
		end
	end

	task.wait()

	creditsFrame.Size = UDim2.new(1, 0, 0, uiListLayout.AbsoluteContentSize.Y)
	creditsFrame.Position = UDim2.new(0, 0, 1, 0)
end

local function playCredits()
	if playing then return end
	if hasPlayed and not Settings.AllowRepeat then return end

	playing = true
	hasPlayed = true

	buildCredits()

	blackFrame.BackgroundTransparency = 1

	local fadeIn = TweenService:Create(
		blackFrame,
		TweenInfo.new(Settings.FadeTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{BackgroundTransparency = 0}
	)
	fadeIn:Play()
	fadeIn.Completed:Wait()

	task.wait(Settings.HoldBlackTime)

	local endPosition = UDim2.new(0, 0, 0, -creditsFrame.AbsoluteSize.Y)

	local scrollTween = TweenService:Create(
		creditsFrame,
		TweenInfo.new(Settings.ScrollTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{Position = endPosition}
	)
	scrollTween:Play()
	scrollTween.Completed:Wait()

	task.wait(1)

	local fadeOut = TweenService:Create(
		blackFrame,
		TweenInfo.new(Settings.FadeTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{BackgroundTransparency = 1}
	)
	fadeOut:Play()
	fadeOut.Completed:Wait()

	playing = false
end

remote.OnClientEvent:Connect(function()
	playCredits()
end)