-- services
local rs = game:GetService("RunService")
local plrs = game:GetService("Players")
local rps = game:GetService("ReplicatedStorage")
local modulesfolder = rps:WaitForChild("Modules")
local objectivesframework = require(modulesfolder:WaitForChild("ObjectivesFramework"))
local objectivesIndex, eventsManager = require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("objectivesIndex")), require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("eventsManager"))
-- plr
local plr = plrs.LocalPlayer
local profile = plr:WaitForChild("Profile")
local currentObjective, totalTasks, completedTasks, objectiveActive = profile:WaitForChild("CurrentObjective"), profile:WaitForChild("TotalTasks"), profile:WaitForChild("CompletedTasks"), profile:WaitForChild("ObjectiveActive")
-- char
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
-- guis
local objectivesystemgui = plr.PlayerGui:WaitForChild("ObjectiveSystemGUI")
local objectivetitleframe, objectivesframe = objectivesystemgui:WaitForChild("ObjectiveTitleFrame"), objectivesystemgui:WaitForChild("ObjectivesFrame")

-- values
local processTasks = false
local tasksArray = {}

-- fetch
local function returnObject(target)
	for _, descendant in ipairs(workspace:GetDescendants()) do
		if descendant:IsA("BasePart") then		
			if descendant.Name == target then
				return descendant
			end	
		end
	end
end

-- calculations
local function calculate_task_distance(taskframe, taskdescription, target)
	if taskframe and taskdescription then
		local descriptionVal = taskframe:GetAttribute("Description")
		local dist = (root.Position - target.Position).Magnitude
		taskdescription.Text = descriptionVal.." ("..math.floor(dist).." studs away)"
	end
end

local function calculate_task_progress(taskframe, taskdescription)
	if taskframe and taskdescription then
		local descriptionVal = taskframe:GetAttribute("Description")
		local progressVal, goalVal = taskframe:GetAttribute("Progress"), taskframe:GetAttribute("Goal")
		taskdescription.Text = descriptionVal.." ("..progressVal.." of "..goalVal..")"
	end
end

-- functions
local function objectiveUpdated(objectiveId)	
	-- check if objective has been changed to a new one
	if objectiveId ~= "" then	
		local active repeat wait() active = eventsManager.checkActiveObjective() until active		
		local objectiveData = objectivesIndex[objectiveId]
		tasksArray = {}

		-- store all data in a table
		for taskid, taskdata in pairs(objectiveData.tasks) do
			local taskframe = objectivesframe:WaitForChild(taskid)
			local taskdescription = objectivesframe:WaitForChild(taskid.."_description")

			-- attributes
			local objectNameVal, goalVal = taskframe:GetAttribute("ObjectName"), taskframe:GetAttribute("Goal")
			if objectNameVal ~= "" then
				table.insert(tasksArray, {frame=taskframe, description=taskdescription, parameter="distance", value=returnObject(objectNameVal)})
			end
			if tonumber(goalVal) > 0 then	
				table.insert(tasksArray, {frame=taskframe, description=taskdescription, parameter="goal"})
			end
		end
		
		-- loop through tasks data and refresh task descriptions
		if #tasksArray > 0 then
			processTasks = true
			while true do	
				if processTasks then
					for _, data in pairs(tasksArray) do			
						if data.frame then
							if data.parameter == "distance" then		
								calculate_task_distance(data.frame, data.description, data.value)	
							elseif data.parameter == "goal" then	
								calculate_task_progress(data.frame, data.description)	
							end	
						end	
					end
				else
					break
				end
				rs.Heartbeat:Wait()
			end
		end
	end
end

local function checkCompletedTasks()
	if currentObjective.Value ~= "" then
		if completedTasks.Value == totalTasks.Value then	
			processTasks = false	
			tasksArray = nil
			objectivesframework.unstageObjective()	
		end
	end
end

-- connects
currentObjective.Changed:Connect(objectiveUpdated)
completedTasks.Changed:Connect(checkCompletedTasks)

