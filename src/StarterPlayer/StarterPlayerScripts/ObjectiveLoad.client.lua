local Players = game:GetService("Players")
local player = Players.LocalPlayer
local trigger = workspace.ObjectiveTrigger

local ObjectivesFramework = require(
	game.ReplicatedStorage.Modules.ObjectivesFramework
)

local triggered = false

trigger.Touched:Connect(function(hit)
	if triggered then return end
	if hit.Parent ~= player.Character then return end

	triggered = true
	ObjectivesFramework.stageObjective("THE LAST VISIT")
end)