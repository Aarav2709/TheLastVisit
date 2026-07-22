local RootPart = script.Parent:WaitForChild("HumanoidRootPart")
local Sound = RootPart:WaitForChild("Running")
Sound.Volume = 0

Sound:GetPropertyChangedSignal("Volume"):Connect(function() 
	Sound:Destroy()
end)