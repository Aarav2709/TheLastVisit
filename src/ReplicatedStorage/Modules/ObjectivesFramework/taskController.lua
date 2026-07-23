-- modules
local returnPlayer, frameworkConfig, eventsManager = require(script.Parent:WaitForChild("returnPlayer")), require(script.Parent:WaitForChild("frameworkConfig")), require(script.Parent:WaitForChild("eventsManager"))
-- plr
local plr = returnPlayer()
local plrgui = plr.PlayerGui
-- profile
local profile = plr:WaitForChild("Profile")
local objectiveActive = profile:WaitForChild("ObjectiveActive")
-- guis
local objectivesystemgui = plrgui:WaitForChild("ObjectiveSystemGUI")
local objectivetitleframe, objectivesframe = objectivesystemgui:WaitForChild("ObjectiveTitleFrame"), objectivesystemgui:WaitForChild("ObjectivesFrame")

local taskController = {}

-- fetch
local function returnTaskFrame(taskId)
	local active = eventsManager.checkActiveObjective()
	if active then
		local taskframe = objectivesframe:FindFirstChild(taskId)
		local taskdescription = objectivesframe:FindFirstChild(taskId.."_description")
		if taskframe and taskdescription then
			return taskframe, taskdescription
		else
			warn("Failed to fetch task: '"..taskId.."'")
		end
	end
end

-- function
function taskController.taskProgressSet(taskId, number)
	local frame, description = returnTaskFrame(taskId)	
	if frame and description then
		frame:SetAttribute("Progress", number)
		local progressVal, goalVal = frame:GetAttribute("Progress"), frame:GetAttribute("Goal")
		return true, progressVal == goalVal
	end
end

function taskController.taskProgressIncreased(taskId)
	local frame, description = returnTaskFrame(taskId)	
	if frame and description then
		local progressVal, goalVal = frame:GetAttribute("Progress"), frame:GetAttribute("Goal")
		local new = (progressVal+1)
		frame:SetAttribute("Progress", new)
		return true, new == goalVal
	end
end

function taskController.taskProgressDecreased(taskId)
	local frame, description = returnTaskFrame(taskId)	
	if frame and description then
		local progressVal = frame:GetAttribute("Progress")
		local new = (progressVal-1)
		frame:SetAttribute("Progress", new)
		return true
	end
end

function taskController.taskCompleted(taskId)
	local frame, description = returnTaskFrame(taskId)	
	if frame and description then
		frame:SetAttribute("Completed", true)
		frame.ToggleImage.Image = frameworkConfig.task_completed_img_id	
		description:Destroy()	
		return true
	end
end

return taskController
