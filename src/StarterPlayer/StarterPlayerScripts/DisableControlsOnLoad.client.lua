local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Get the PlayerModule controls
local controls = require(
	player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
):GetControls()

-- Disable movement
controls:Disable()

-- Lock camera
workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

-- Wait for your loading screen
task.wait(9.5)

-- Enable movement
controls:Enable()

-- Restore camera
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom