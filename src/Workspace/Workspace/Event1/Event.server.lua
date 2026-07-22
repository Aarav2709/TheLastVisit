local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local part = script.Parent -- The part players will touch
local guiTemplate = game.StarterGui:WaitForChild("EventStory") -- Reference to the GUI in StarterGui

local touchedPlayers = {} -- Table to track players who have already triggered the GUI

-- Function to handle the story sequence
local function playStory(gui)
	local bg = gui:WaitForChild("BG")
	local textLabel = bg:WaitForChild("TextLabel")
	local nextButton = bg:WaitForChild("TextButton")

	-- Story scenes
	local scenes = {
		"I came back looking for a folder, but I left carrying memories I thought I'd lost forever.",
		"Some goodbyes don't happen when someone leaves, they happen the day you finally return.",
		"Life rarely gives us another chance to say the things we leave unsaid.",
		"So before your last visit becomes your last chance, don't wait.",
	}

	local fadeDuration = 1.1 -- Time for fade-in and fade-out effects
	local buttonCooldown = 2 -- Cooldown duration in seconds
	local isCoolingDown = false -- Cooldown flag

	-- Function to fade in an object
	local function fadeIn(object)
		object.TextTransparency = 1 -- Ensure text is fully transparent
		local tween = TweenService:Create(object, TweenInfo.new(fadeDuration), {TextTransparency = 0})
		tween:Play()
		tween.Completed:Wait()
	end

	-- Function to fade out an object
	local function fadeOut(object)
		local tween = TweenService:Create(object, TweenInfo.new(fadeDuration), {TextTransparency = 1})
		tween:Play()
		tween.Completed:Wait()
		object.TextTransparency = 1 -- Ensure it is fully transparent after fading out
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

	-- Function to fade in the background
	local function fadeInBackground()
		bg.BackgroundTransparency = 1 -- Ensure the background starts fully transparent
		local bgTween = TweenService:Create(bg, TweenInfo.new(fadeDuration), {BackgroundTransparency = 0})
		bgTween:Play()
		bgTween.Completed:Wait()
	end

	-- Function to handle player clicking to proceed
	local function waitForClick()
		local clicked = false

		-- Enable the button and listen for clicks
		local connection
		connection = nextButton.MouseButton1Click:Connect(function()
			if not isCoolingDown then
				clicked = true
				isCoolingDown = true -- Activate cooldown
				nextButton.Active = false -- Disable interaction

				-- Start cooldown timer
				task.delay(buttonCooldown, function()
					isCoolingDown = false
					nextButton.Active = true -- Re-enable interaction
				end)

				connection:Disconnect() -- Disconnect to avoid repeated clicks
			end
		end)

		-- Wait until the player clicks the button
		repeat
			task.wait()
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
	gui.Enabled = true -- Enable the GUI at the start

	-- Apply the hover effect to the TextButton
	applyHoverEffect()

	-- Fade in the background
	fadeInBackground()

	for i, scene in ipairs(scenes) do
		if i > 1 then
			fadeOut(textLabel) -- Fade out the previous text
		end

		textLabel.Text = scene -- Set the text for the current scene
		fadeIn(textLabel) -- Fade in the current text

		waitForClick() -- Wait for the player to click the button
		playTextBumpEffect() -- Play bump effect on the text
	end

	fadeOut(textLabel) -- Fade out the final text
	fadeOutBackgroundAndButton() -- Fade out the background and button after the story ends

	-- Reset GUI elements to their initial state
	textLabel.Text = "" -- Clear text
	textLabel.TextTransparency = 1 -- Hide text
	bg.BackgroundTransparency = 1 -- Fully hide background
	nextButton.TextTransparency = 1 -- Hide button text
	nextButton.BackgroundTransparency = 1 -- Hide button background
	gui.Enabled = false -- Disable the GUI
end

-- Handle the Touched event
part.Touched:Connect(function(hit)
	local player = Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		if not touchedPlayers[player.UserId] then
			-- Mark the player as having triggered the GUI
			touchedPlayers[player.UserId] = true

			local playerGui = player:WaitForChild("PlayerGui")
			local existingGui = playerGui:FindFirstChild("EventStory")

			if not existingGui then
				local gui = guiTemplate:Clone()
				gui.Parent = playerGui
				gui.Enabled = false -- Ensure it starts disabled before enabling
				playStory(gui)
			else
				existingGui.Enabled = false -- Reset in case it was left enabled
				playStory(existingGui)
			end
		end
	end
end)
