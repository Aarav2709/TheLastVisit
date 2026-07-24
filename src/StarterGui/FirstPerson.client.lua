repeat task.wait() until game:GetService("Players").LocalPlayer.Character

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local storyActive = ReplicatedStorage:WaitForChild("StoryActive")
local dialogueActive = ReplicatedStorage:WaitForChild("DialogueActive")

if not dialogueActive then
	dialogueActive = Instance.new("BoolValue")
	dialogueActive.Name = "DialogueActive"
	dialogueActive.Parent = ReplicatedStorage
end


local CanToggleMouse = {
	allowed = true,
	activationkey = Enum.KeyCode.F
}


local CanViewBody = true
local Sensitivity = 0.25
local Smoothness = 0.1
local FieldOfView = 95


local camera = workspace.CurrentCamera
local player = Players.LocalPlayer
local mouse = player:GetMouse()


mouse.Icon = "rbxassetid://4727487316"


local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")
local head = character:WaitForChild("Head")


local TargetAngleX = 0
local TargetAngleY = 0

local AngleX = 0
local AngleY = 0


local freeMouse = false



local function updateCharacter()

	for _,v in pairs(character:GetChildren()) do

		if v.Name == "Head" then
			v.LocalTransparencyModifier = 1
			v.CanCollide = false
		end


		if v:IsA("Accessory") then

			local handle = v:FindFirstChild("Handle")

			if handle then
				handle.LocalTransparencyModifier = 1
				handle.CanCollide = false
			end

		end

	end

end



UserInputService.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = Vector2.new(
			input.Delta.X / Sensitivity,
			input.Delta.Y / Sensitivity
		) * Smoothness


		TargetAngleX = math.clamp(
			TargetAngleX - delta.Y,
			-80,
			80
		)


		TargetAngleY =
			(TargetAngleY - delta.X) % 360

	end

end)



UserInputService.InputBegan:Connect(function(input)

	if input.KeyCode == CanToggleMouse.activationkey then

		if CanToggleMouse.allowed then
			freeMouse = not freeMouse
		end

	end

end)



RunService.RenderStepped:Connect(function()


	updateCharacter()


	AngleX =
		AngleX + (TargetAngleX - AngleX) * 0.35


	local difference = TargetAngleY - AngleY


	if math.abs(difference) > 180 then
		difference -= math.sign(difference) * 360
	end


	AngleY =
		(AngleY + difference * 0.35) % 360



	camera.CameraType = Enum.CameraType.Scriptable


	camera.CFrame =
		CFrame.new(head.Position)
		* CFrame.Angles(0,math.rad(AngleY),0)
		* CFrame.Angles(math.rad(AngleX),0,0)
		* CFrame.new(0,0.8,0)



	root.CFrame =
		CFrame.new(root.Position)
		* CFrame.Angles(0,math.rad(AngleY),0)



	humanoid.AutoRotate = false



	if freemouse or dialogueActive.Value or storyActive.Value then

		UserInputService.MouseBehavior =
			Enum.MouseBehavior.Default

		UserInputService.MouseIconEnabled=true

	else

		UserInputService.MouseBehavior =
			Enum.MouseBehavior.LockCenter

		UserInputService.MouseIconEnabled=false

	end


	camera.FieldOfView = FieldOfView


end)