	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local startCreditsEvent = ReplicatedStorage:WaitForChild("StartCreditsEvent")

	local part = script.Parent

	part.Transparency = 1
	part.CanCollide = false
	part.CanTouch = false


	local storyActive = ReplicatedStorage:WaitForChild("StoryActive")

	local guiTemplate = game.StarterGui:WaitForChild("EventStory")

	local unlocked = false
	local touchedPlayers = {}



	local function checkMemoriesComplete(player)

		local profile = player:FindFirstChild("Profile")

		if not profile then
			return false
		end


		local objectiveCompleted = profile:FindFirstChild("ObjectiveCompleted")


		if not objectiveCompleted then
			return false
		end


		return objectiveCompleted.Value == true

	end



	local function unlockEnding()

		if unlocked then
			return
		end


		unlocked = true


		part.CanTouch = true
		part.CanCollide = false
		part.Transparency = 1


		print("Ending unlocked")

	end



	local function monitorPlayer(player)

		local profile = player:WaitForChild("Profile")

		local completedTasks = profile:WaitForChild("CompletedTasks")


		local function check()

			if checkMemoriesComplete(player) then
				unlockEnding()
			end

		end


		completedTasks.Changed:Connect(check)


		task.wait(1)

		check()

	end



	Players.PlayerAdded:Connect(monitorPlayer)


	for _,player in ipairs(Players:GetPlayers()) do
		task.spawn(monitorPlayer,player)
	end




	local function playStory(gui, player)

		local bg = gui:WaitForChild("BG")
		local textLabel = bg:WaitForChild("TextLabel")
		local nextButton = bg:WaitForChild("TextButton")


		local scenes = {

			"I came here expecting to say goodbye to a house.",

			"But I realized I was never saying goodbye to the walls, the furniture, or the objects inside.",

			"Every item I found carried something much bigger than itself.",

			"A reminder that someone lived here. Someone cared. Someone had moments they thought would last forever.",

			"We often believe we have more time.",

			"More conversations. More visits. More chances to appreciate the people and places around us.",

			"But time never promises us another moment.",

			"This house was built to preserve memories for the future.",

			"And now I finally understand what it was trying to preserve.",

			"Not the building.",

			"Not the objects.",

			"The moments that made it a home."

		}



		local function waitClick()

			local clicked = false


			local connection

			connection = nextButton.MouseButton1Click:Connect(function()

				clicked = true

				connection:Disconnect()

			end)


			repeat
				task.wait()
			until clicked

		end

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

		storyActive.Value = true
		gui.Enabled = true

		for _,scene in ipairs(scenes) do

			textLabel.Text = scene
			textLabel.TextTransparency = 1

			local fadeIn = TweenService:Create(
				textLabel,
				TweenInfo.new(0.8),
				{
					TextTransparency = 0
				}
			)

			fadeIn:Play()
			fadeIn.Completed:Wait()

			waitClick()

			local fadeOut = TweenService:Create(
				textLabel,
				TweenInfo.new(0.5),
				{
					TextTransparency = 1
				}
			)

			fadeOut:Play()
			fadeOut.Completed:Wait()

		end

		gui.Enabled = false
		storyActive.Value = false
		startCreditsEvent:FireClient(player)

	end

	part.Touched:Connect(function(hit)


		local player = Players:GetPlayerFromCharacter(hit.Parent)


		if not player then
			return
		end


		if touchedPlayers[player.UserId] then
			return
		end


		if not unlocked then
			return
		end


		touchedPlayers[player.UserId] = true



		local playerGui = player:WaitForChild("PlayerGui")


		local gui = guiTemplate:Clone()

		gui.Parent = playerGui

		gui.Enabled = false



		playStory(gui, player)


	end)