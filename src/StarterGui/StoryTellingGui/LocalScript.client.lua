local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Players = game:GetService("Players")


local player = Players.LocalPlayer


local controls =
	require(
		player.PlayerScripts:WaitForChild("PlayerModule")
	):GetControls()



local storyActive =
	ReplicatedStorage:WaitForChild("StoryActive")



local gui = script.Parent


local bg =
	gui:WaitForChild("BG")


local textLabel =
	bg:WaitForChild("TextLabel")


local nextButton =
	bg:WaitForChild("TextButton")



task.wait(7)



local scenes = {

	"Almost eight years have passed since I last stood at this door.",

	"When I heard the house was finally going to be cleared out, I knew I had to come back one last time.",

	"I told myself I was only here to collect anything I had forgotten.",

	"But deep down, I think I came here because I wasn't ready to let go.",

	"This house was never meant to be just a building.",

	"When it was first built, the people who created it left pieces of their lives behind. Not because they expected to stay forever, but because they wanted someone in the future to remember that they were here.",

	"A reminder that every room, every object, and every moment once belonged to someone.",

	"I never thought I would be the person returning to find those memories.",

	"Maybe that is what time does. It turns ordinary moments into the ones we wish we could experience again."

}




local function fadeText(transparency)

	local tween =
		TweenService:Create(
			textLabel,
			TweenInfo.new(0.8),
			{
				TextTransparency = transparency
			}
		)

	tween:Play()
	tween.Completed:Wait()

end





local function setupHover()


	nextButton.MouseEnter:Connect(function()


		TweenService:Create(
			nextButton,
			TweenInfo.new(0.2),
			{
				TextColor3 = Color3.fromRGB(255,255,0)
			}
		):Play()


	end)



	nextButton.MouseLeave:Connect(function()


		TweenService:Create(
			nextButton,
			TweenInfo.new(0.2),
			{
				TextColor3 = Color3.fromRGB(255,255,255)
			}
		):Play()


	end)

end




local function waitClick()


	local clicked = false


	local connection


	connection =
		nextButton.MouseButton1Click:Connect(function()

			clicked = true

			connection:Disconnect()

		end)



	repeat
		task.wait()
	until clicked


end





local function fadeOutEverything()


	local a =
		TweenService:Create(
			bg,
			TweenInfo.new(1),
			{
				BackgroundTransparency = 1
			}
		)



	local b =
		TweenService:Create(
			textLabel,
			TweenInfo.new(1),
			{
				TextTransparency = 1
			}
		)



	local c =
		TweenService:Create(
			nextButton,
			TweenInfo.new(1),
			{
				BackgroundTransparency = 1,
				TextTransparency = 1
			}
		)



	a:Play()
	b:Play()
	c:Play()


	a.Completed:Wait()

end






local function playStory()


	storyActive.Value = true


	controls:Disable()


	gui.Enabled = true



	setupHover()



	for i,scene in ipairs(scenes) do

		textLabel.TextTransparency = 1
		textLabel.Text = scene


		local tween =
			TweenService:Create(
				textLabel,
				TweenInfo.new(0.8),
				{
					TextTransparency = 0
				}
			)

		tween:Play()
		tween.Completed:Wait()


		waitClick()


		if i ~= #scenes then

			local out =
				TweenService:Create(
					textLabel,
					TweenInfo.new(0.5),
					{
						TextTransparency = 1
					}
				)

			out:Play()
			out.Completed:Wait()

		end

	end



	fadeOutEverything()


	task.wait(0.2)


	gui.Enabled = false



	storyActive.Value = false


	controls:Enable()


end



playStory()