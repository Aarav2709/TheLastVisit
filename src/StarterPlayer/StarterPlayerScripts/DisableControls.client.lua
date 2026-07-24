local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local controls = require(
	player.PlayerScripts:WaitForChild("PlayerModule")
):GetControls()

local event = ReplicatedStorage:WaitForChild("DisableControlsEvent")


event.OnClientEvent:Connect(function(state)

	if state then
		controls:Disable()
	else
		controls:Enable()
	end

end)