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

	"It's been almost eight years since I last stepped into this house. After hearing it would finally be cleared out, I decided it was time for one last visit.",

	"I wasn't looking for anything in particular. Maybe I just wanted to see it one last time before it became someone else's memory.",

	"Everything was exactly where it had been left. The walls, the furniture, even the silence felt strangely familiar.",

	"I thought I had left this place behind long ago. I didn't realize how much of it had quietly stayed with me."

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