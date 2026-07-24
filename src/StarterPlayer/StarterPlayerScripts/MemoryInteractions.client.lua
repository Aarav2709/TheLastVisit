local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer


local ObjectivesFramework = require(
	ReplicatedStorage
		:WaitForChild("Modules")
		:WaitForChild("ObjectivesFramework")
)


local dialogueGui =
	player.PlayerGui:WaitForChild("DialogueKit")


local dialogueKitModule =
	require(dialogueGui:WaitForChild("DialogueKit"))



local objectivesFolder =
	workspace:WaitForChild("Objectives")



local function createMemoryDialogue(lines)

	local dialogue = {

		InitialLayer = "Layer1",

		SkinName = "Interactive",

		Layers = {

			Layer1 = {

				Dialogue = lines,

				DialogueSounds = {},

				Title = "Memory",

				Replies = {},

				Exec = {}

			}

		}

	}


	dialogue.Layers.Layer1.Exec["_continue"..#lines] = {

		ExecContent = "_continue"..#lines,

		ExecTime = "After",

		Function = function()

			ObjectivesFramework.taskProgressIncreased("Memories")

		end

	}


	return dialogue

end




local memoryDialogues = {


	["Cookies"] = createMemoryDialogue({

		"The old cookie jar was still here.",

		"I remember waking up on Sunday mornings to the smell of freshly baked cookies.",

		"Back then, it felt like another normal day.",

		"I never stopped to think that normal days were the ones I would miss the most.",

		"Sometimes we only understand the value of a moment after it becomes a memory."

	}),



	["Research Paper"] = createMemoryDialogue({

		"Old research papers.",

		"I remember sitting here for hours, trying to understand every little detail.",

		"I was always thinking about the future and everything I wanted to achieve.",

		"I never noticed that these quiet moments were already becoming part of my past.",

		"We spend so much time preparing for tomorrow that we forget to experience today."

	}),


	["Old House Photograph"] = createMemoryDialogue({

		"An old photograph of this house from the day it was completed.",

		"It wasn't taken because the house was special.",

		"It was taken because the people who built it knew that one day, this moment would only exist in memories.",

		"They wanted future generations to know that someone stood here before them.",

		"Someone lived here. Someone laughed here. Someone called this place home.",

		"I always thought memories were about the things we leave behind.",

		"Maybe they are actually about the people who continue carrying them forward."

	}),



	["Spectacles"] = createMemoryDialogue({

		"These glasses were always left near the chair.",

		"I saw them almost every day, but I never really noticed them.",

		"At the time, they were just another object in the house.",

		"Now they remind me that someone sat here, rested here, and spent years of their life in this exact place.",

		"Things become valuable when they carry pieces of someone's story."

	}),



	["Keys"] = createMemoryDialogue({

		"The old house keys.",

		"They opened this door for years.",

		"They welcomed people home after long days and kept countless memories safe inside these walls.",

		"I used to think they were just keys.",

		"But every person who held them left something behind.",

		"Places disappear. Objects break. Time moves forward.",

		"But the moments we share are the things that truly remain."

	}),

}





for _,object in ipairs(objectivesFolder:GetChildren()) do


	local mesh =
		object:FindFirstChildWhichIsA("MeshPart",true)



	if mesh then


		local prompt =
			mesh:FindFirstChildOfClass("ProximityPrompt")



		if prompt then


			prompt.Triggered:Connect(function()


				if not prompt.Enabled then
					return
				end



				local dialogue =
					memoryDialogues[object.Name]



				if dialogue then


					prompt.Enabled = false


					if object.Name == "Cookies" then

						local sound = mesh:FindFirstChild("CookiePlateSlide")

						if sound then
							sound:Play()
						end

					end
					
					if object.Name == "Keys" then

						local sound = mesh:FindFirstChild("KeyPickup")

						if sound then
							sound:Play()
						end

					end
					
					if object.Name == "Old House Photograph" then

						local sound = mesh:FindFirstChild("PhotoBreath")

						if sound then
							sound:Play()
						end

					end
					
					if object.Name == "Research Paper" then

						local sound = mesh:FindFirstChild("PaperRustle")

						if sound then
							sound:Play()
						end

					end
					
					if object.Name == "Spectacles" then

						local sound = mesh:FindFirstChild("SpectacleCloth")

						if sound then
							sound:Play()
						end

					end


					dialogueKitModule.CreateDialogue(dialogue)



				else

					warn("Missing dialogue:",object.Name)

				end


			end)


		end

	end

end