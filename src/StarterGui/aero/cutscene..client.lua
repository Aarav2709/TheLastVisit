
task.wait()
local TweenService = game:GetService("TweenService")
local Camera = game.Workspace.CurrentCamera

local function MoveCamera(StartPart, EndPart, Duration, EasingStyle, EasingDirection)
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.CFrame = StartPart.CFrame
	local Cutscene = TweenService:Create(Camera, TweenInfo.new(Duration, EasingStyle, EasingDirection), {CFrame = EndPart.CFrame})
	Cutscene:Play()
	task.wait(Duration)
	script["finished."].Value = true
end

local function Cutscene()
	script["started."].Value = true
	MoveCamera(game.Workspace.Camera1, game.Workspace.Camera2, script.Parent["config."].Time.Value, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	task.wait(.5)
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
end

Cutscene()

