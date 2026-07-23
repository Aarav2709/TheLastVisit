-- modules
local objectivesIndex, taskController, eventsManager, returnPlayer = require(script:WaitForChild("objectivesIndex")), require(script:WaitForChild("taskController")), require(script:WaitForChild("eventsManager")), require(script:WaitForChild("returnPlayer"))

local objectivesframework = {}

-- fetch
local function returnPlayerObjective(plr)
	local profile = plr:FindFirstChild("Profile")
	if profile then	
		local currentObjective = profile:FindFirstChild("CurrentObjective")
		if currentObjective then
			return currentObjective.Value
		else
			warn("Failed to fetch "..plr.Name.."'s currentObjective value")
			return
		end
	else
		warn("Failed to fetch "..plr.Name.."'s profile")
		return
	end
end

-- functions
function objectivesframework.stageObjective(objectiveId)
	local plr = returnPlayer()
	local currentObjective = returnPlayerObjective(plr)
	if currentObjective == ""  then
		local objectiveData = objectivesIndex[objectiveId]
		if objectiveData then
			print("Staging Objective: "..objectiveId)
			eventsManager.stageObjective(objectiveId, #objectiveData.tasksSequence[1])
		else
			warn("Failed to fetch objective: "..tostring(currentObjective))
		end
	else
		warn("Failed to stage new objective (objective already active")	
	end
end

function objectivesframework.unstageObjective()
	local plr = returnPlayer()
	local objectiveId = returnPlayerObjective(plr)
	if objectiveId ~= nil and objectiveId ~= ""  then
		print("Unstaging Objective")
		eventsManager.unstageObjective()
	else
		warn("Couldn't unstage objective (no objective currenly active)")
	end
end

function objectivesframework.taskCompleted(taskId)
	local success = taskController.taskCompleted(taskId)
	if success then
		print("Completed Task: "..taskId)
		eventsManager.taskCompleted()
		return success
	end
end

function objectivesframework.taskProgressSet(taskId, number)
	local success, completed = taskController.taskProgressSet(taskId, number)
	if success and completed then
		print("Task Progress Set: "..taskId)
		taskController.taskCompleted(taskId)
	end
end

function objectivesframework.taskProgressIncreased(taskId)
	local success, completed = taskController.taskProgressIncreased(taskId)
	if success and completed then
		print("Task Progress Increased: "..taskId)
		taskController.taskCompleted(taskId)
	end
end

function objectivesframework.taskProgressDecreased(taskId)
	local success = taskController.taskProgressDecreased(taskId)
	if success then
		print("Task Progress Decreased: "..taskId)
	end
end

return objectivesframework
