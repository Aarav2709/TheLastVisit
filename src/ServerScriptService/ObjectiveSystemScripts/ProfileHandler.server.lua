-- services
local plrs = game:GetService("Players")

-- functions
plrs.PlayerAdded:Connect(function(plr)
	local profile = script.Profile:Clone()
	profile.Parent = plr
end)