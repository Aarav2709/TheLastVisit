local model = script.Parent
local plr = game.Players:GetPlayerFromCharacter(script.Parent)
local humanoid = model:WaitForChild("Humanoid")
local description = game:GetService("Players"):GetHumanoidDescriptionFromUserId(plr.UserId)
humanoid:ApplyDescription(description)
wait(1)
script:Destroy()