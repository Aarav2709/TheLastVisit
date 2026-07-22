local TweenService = game:GetService("TweenService")

local gui = script.Parent
local bg = gui:WaitForChild("BG")
local textLabel = bg:WaitForChild("TextLabel")
local nextButton = bg:WaitForChild("TextButton")
task.wait(12)

-- Story scenes
local scenes = {
	"I hadn't been back to my childhood home in almost eight years, but after receiving a call that it would be cleared out by the end of the week, I decided it was finally time to return.",
	"There wasn't much left for me there except a blue folder containing a few important documents, or at least that's what I convinced myself before unlocking the front door.",
	"I thought I would be in and out within a few minutes, collect the folder, lock the house one last time, and never have to look back again.",
	"I didn't realize that sometimes it's not the things you go looking for that stay with you, but the things you never expected to find."
}

-- Fade settings
local fadeDuration = 1

-- Function to fade in an object
local function fadeIn(object)
	local tween = TweenService:Create(object, TweenInfo.new(fadeDuration), {TextTransparency = 0})
	tween:Play()
	tween.Completed:Wait()
end

-- Function to fade out an object
local function fadeOut(object)
	local tween = TweenService:Create(object, TweenInfo.new(fadeDuration), {TextTransparency = 1})
	tween:Play()
	tween.Completed:Wait()
end

-- Function to fade out the background and button simultaneously
local function fadeOutBackgroundAndButton()
	local bgTween = TweenService:Create(bg, TweenInfo.new(fadeDuration), {BackgroundTransparency = 1})
	local buttonTween = TweenService:Create(nextButton, TweenInfo.new(fadeDuration), {BackgroundTransparency = 1, TextTransparency = 1})

	bgTween:Play()
	buttonTween:Play()

	bgTween.Completed:Wait()
	buttonTween.Completed:Wait()
end

-- Function to handle player clicking to proceed
local function waitForClick()
	local clicked = false

	-- Detect when the TextButton is clicked
	local connection
	connection = nextButton.MouseButton1Click:Connect(function()
		clicked = true
		connection:Disconnect() -- Disconnect the event listener
		-- Play the bump effect on the text when clicked
		playTextBumpEffect()
	end)

	-- Wait until the player clicks the button
	repeat
		wait()
	until clicked
end

-- Hover effect for the TextButton (Yellow text on hover)
local function applyHoverEffect()
	-- Tween for hover effect (yellow text on hover)
	local hoverTweenIn = TweenService:Create(nextButton, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 0)}) -- Yellow text on hover
	-- Tween for when mouse leaves (white default text)
	local hoverTweenOut = TweenService:Create(nextButton, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}) -- White text when not hovering

	-- On mouse enter (hover effect in)
	nextButton.MouseEnter:Connect(function()
		hoverTweenIn:Play()
	end)

	-- On mouse leave (hover effect out)
	nextButton.MouseLeave:Connect(function()
		hoverTweenOut:Play()
	end)
end

-- Small bump effect for TextLabel when clicked
local function playTextBumpEffect()
	-- Create the scale-up and scale-down tweens for the bump effect on the text
	local scaleUp = TweenService:Create(textLabel, TweenInfo.new(0.1), {TextSize = 30})  -- Increase text size slightly (bump effect)
	local scaleDown = TweenService:Create(textLabel, TweenInfo.new(0.1), {TextSize = 24})  -- Return to original text size

	-- Play the bump effect: scale up, then scale down
	scaleUp:Play()
	scaleUp.Completed:Wait() -- Wait for the scale-up tween to complete
	scaleDown:Play() -- Play the scale-down tween
end

-- Main storytelling sequence
local function playStory()
	gui.Enabled = true -- Enable the GUI at the start

	-- Apply the hover effect to the TextButton
	applyHoverEffect()

	for i, scene in ipairs(scenes) do
		textLabel.Text = scene -- Set the text for the scene

		-- Special fade-in effect for the first scene
		if i == 1 then
			textLabel.TextTransparency = 1 -- Ensure text is invisible initially
			fadeIn(textLabel) -- Fade in the first text
		else
			fadeIn(textLabel) -- Fade in subsequent text normally
		end

		waitForClick() -- Wait for the player to click the button
		fadeOut(textLabel) -- Fade out the text
	end

	fadeOutBackgroundAndButton() -- Fade out the background and button after the story ends
	gui.Enabled = false -- Disable the GUI after everything fades out
end

-- Start story progression
playStory()
