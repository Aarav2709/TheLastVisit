--Important for HybridCam™ integration
script.Name = "aero."
--

--Instances
local MBCreate = Instance.new("BlurEffect")
MBCreate.Parent = workspace.CurrentCamera
MBCreate.Name = "AeroBlur"

local aP = Instance.new("BoolValue")
aP.Parent = game.ReplicatedStorage
aP.Name = "aeroPresent"
aP.Value = true

--Variables
local RS = game.ReplicatedStorage

local Camera = workspace.CurrentCamera
local MenuBlur = Camera:WaitForChild("AeroBlur")
local LoadingUI = script:WaitForChild("ui.")
local Players = game:GetService("Players")
local hcp = RS:FindFirstChild("hybridcamPresent")
local hcc = game.StarterGui:FindFirstChild("HybridCam™ Client")
local hcpg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("HybridCam™ Client")

--
script.Name = "aero."
repeat task.wait() until game:IsLoaded()

if not hcp or hcc or hcpg then
	MenuBlur.Size = 24
	LoadingUI.Enabled = true
	wait(script["config."].Time.Value)
	for i = 1,24 do
		task.wait()
		MenuBlur.Size = MenuBlur.Size - 1
	end
	LoadingUI.Enabled = false
	MenuBlur:Destroy()
else
	print("HybridCam™ version 1.8a or newer detected!")
	script["ui."].hc.Value = true
	MenuBlur.Enabled = false
	LoadingUI.Enabled = true
	wait(8)
	LoadingUI.Enabled = false
end


