-- services
local rps = game:GetService("ReplicatedStorage")
local remotesarray = {}
for _, child in pairs(rps:WaitForChild("Remotes"):GetChildren()) do
	remotesarray[child.Name] = child
end

local eventsManager = {}

-- functions
function eventsManager.checkActiveObjective()
	return remotesarray["CheckActiveObjective"]:InvokeServer()
end

function eventsManager.checkCurrentObjective()
	return remotesarray["CheckCurrentObjective"]:InvokeServer()
end

-- events
function eventsManager.stageObjective(objectiveId, totalTasks)
	remotesarray["StageObjective"]:FireServer(objectiveId, totalTasks)
end

function eventsManager.unstageObjective(objectiveId, totalTasks)
	remotesarray["UnstageObjective"]:FireServer(objectiveId, totalTasks)
end

function eventsManager.initiateObjective()
	remotesarray["InitiateObjective"]:FireServer()
end

function eventsManager.completeObjective()
	remotesarray["CompleteObjective"]:FireServer()
end

function eventsManager.taskCompleted()
	remotesarray["TaskCompleted"]:FireServer()
end

return eventsManager
