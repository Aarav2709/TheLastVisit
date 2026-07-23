local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ObjectivesFramework = require(
	ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ObjectivesFramework")
)

local objectivesFolder = workspace:WaitForChild("Objectives")

for _, object in ipairs(objectivesFolder:GetChildren()) do
	local mesh = object:FindFirstChildWhichIsA("MeshPart", true)
	local prompt = mesh and mesh:FindFirstChildOfClass("ProximityPrompt")

	if prompt then
		prompt.Triggered:Connect(function()
			if not prompt.Enabled then
				return
			end

			prompt.Enabled = false

			-- Dialogue for this object will go here.

			ObjectivesFramework.taskProgressIncreased("Memories")
			print("Memory completed:", object.Name)
		end)
	end
end