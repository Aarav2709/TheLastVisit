-- services
local rps = game:GetService("ReplicatedStorage")
local remotesarray = {}
for _, child in pairs(rps:WaitForChild("Remotes"):GetChildren()) do
	remotesarray[child.Name] = child
end

-- functions
remotesarray["CheckActiveObjective"].OnServerInvoke = function(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local objectiveActive = profile:FindFirstChild("ObjectiveActive")
		if objectiveActive then
			return objectiveActive.Value
		else
			warn("Failed to fetch "..plr.Name.."'s ObjectiveActive value")
		end
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end

remotesarray["CheckCurrentObjective"].OnServerInvoke = function(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then
			return currentObjective.Value
		else
			warn("Failed to fetch "..plr.Name.."'s CurrentObjective value")
		end
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end

-- events
remotesarray["StageObjective"].OnServerEvent:Connect(function(plr, objectiveId, tasksAmount)
	remotesarray["TweenInObjective"]:FireClient(plr, objectiveId)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local objectiveCompleted = profile:FindFirstChild("ObjectiveCompleted")
		if objectiveCompleted then
			objectiveCompleted.Value = false
		else
			warn("Failed to fetch "..plr.Name.."'s ObjectiveCompleted value")
		end
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then
			currentObjective.Value = objectiveId
		else
			warn("Failed to fetch "..plr.Name.."'s CurrentObjective value")
		end
		local totalTasks = profile:FindFirstChild("TotalTasks")
		if totalTasks then
			totalTasks.Value = tasksAmount
		else
			warn("Failed to fetch "..plr.Name.."'s TotalTasks value")
		end	
		local completedTasks = profile:FindFirstChild("CompletedTasks")
		if completedTasks then
			completedTasks.Value = 0
		else
			warn("Failed to fetch "..plr.Name.."'s CompletedTasks value")
		end	
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end)

remotesarray["UnstageObjective"].OnServerEvent:Connect(function(plr, objectiveId)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local objectiveCompleted = profile:FindFirstChild("ObjectiveCompleted")
		if objectiveCompleted then
			objectiveCompleted.Value = true
		else
			warn("Failed to fetch "..plr.Name.."'s ObjectiveCompleted value")
		end
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then
			currentObjective.Value = ""
		else
			warn("Failed to fetch "..plr.Name.."'s CurrentObjective value")
		end
		local totalTasks = profile:FindFirstChild("TotalTasks")
		if totalTasks then
			totalTasks.Value = 0
		else
			warn("Failed to fetch "..plr.Name.."'s TotalTasks value")
		end	
		local completedTasks = profile:FindFirstChild("CompletedTasks")
		if completedTasks then
			completedTasks.Value = 0
		else
			warn("Failed to fetch "..plr.Name.."'s CompletedTasks value")
		end	
		remotesarray["TweenOutObjective"]:FireClient(plr, objectiveId)
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end)

remotesarray["InitiateObjective"].OnServerEvent:Connect(function(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then		
			if currentObjective.Value then	
				local objectiveActive = profile:FindFirstChild("ObjectiveActive")
				if objectiveActive then
					objectiveActive.Value = true
				else
					warn("Failed to fetch "..plr.Name.."'s ObjectiveActive value")
				end
			else
				warn("No current objective is currently selected")
			end
		else
			warn("Failed to fetch "..plr.Name.."'s CurrentObjective value")
		end
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end)

remotesarray["CompleteObjective"].OnServerEvent:Connect(function(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then		
			if currentObjective.Value then	
				local objectiveActive = profile:FindFirstChild("ObjectiveActive")
				if objectiveActive then
					objectiveActive.Value = false
				else
					warn("Failed to fetch "..plr.Name.."'s ObjectiveActive value")
				end
			else
				warn("No current objective is currently selected")
			end
		else
			warn("Failed to fetch "..plr.Name.."'s CurrentObjective value")
		end
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end)

remotesarray["TaskCompleted"].OnServerEvent:Connect(function(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local completedTasks = profile:FindFirstChild("CompletedTasks")
		if completedTasks then
			completedTasks.Value += 1
		else
			warn("Failed to fetch "..plr.Name.."'s CompletedTasks value")
		end	
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
	end
end)
