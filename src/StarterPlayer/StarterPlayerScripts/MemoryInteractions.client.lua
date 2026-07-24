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

		"The cookies were still here.",
		"I remember these being made every Sunday morning.",
		"I never realized how much those small moments meant."

	}),



	["Research Paper"] = createMemoryDialogue({

		"Old research papers.",
		"I remember spending hours trying to understand what was written here.",
		"Back then, I never thought I would miss these days."

	}),



	["Old House Photograph"] = createMemoryDialogue({

		"A photograph from years ago.",
		"Everyone looked so happy.",
		"I wonder when we stopped taking moments like these."

	}),



	["Spectacles"] = createMemoryDialogue({

		"These were always left near the chair.",
		"Small things like this somehow become the strongest memories."

	}),



	["Keys"] = createMemoryDialogue({

		"The old house keys.",
		"The same keys that opened this door for so many years.",
		"Now they only open memories."

	})

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


					dialogueKitModule.CreateDialogue(dialogue)



				else

					warn("Missing dialogue:",object.Name)

				end


			end)


		end

	end

end