-- services
local rps = game:GetService("ReplicatedStorage")
local guisfolder = rps:WaitForChild("GUIs")
-- modules
local returnPlayer, objectivesIndex, frameworkConfig = require(script.Parent:WaitForChild("returnPlayer")), require(script.Parent:WaitForChild("objectivesIndex")), require(script.Parent:WaitForChild("frameworkConfig"))
local plr = returnPlayer()
local plrgui = plr.PlayerGui
-- guis
local objectivesystemgui = plrgui:WaitForChild("ObjectiveSystemGUI")
local objectivetitleframe, objectivesframe = objectivesystemgui:WaitForChild("ObjectiveTitleFrame"), objectivesystemgui:WaitForChild("ObjectivesFrame")

local displayObjectiveUI = {}

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

-- functions
function displayObjectiveUI.generateSubheader(txt)
	local subheader = guisfolder:WaitForChild("ObjectiveSubheader"):Clone()
	subheader.Name = txt.."Subheader"
	subheader.Parent = objectivesframe
	subheader.Text = txt
	subheader.Visible = true	
end

function displayObjectiveUI.generateTask(taskid, taskdata)
	local taskframe = guisfolder:WaitForChild("ObjectiveTaskFrame"):Clone()
	taskframe.Name = taskid
	taskframe.Parent = objectivesframe
	taskframe.ObjectiveTaskLabel.Text = taskid
	taskframe.Visible = true
	taskframe.ToggleImage.Image = frameworkConfig.task_uncompleted_img_id

	-- attributes
	taskframe:SetAttribute("Description", taskdata.description)
	if taskdata.parameter == "distance" then	
		if typeof(taskdata.parameter) == "string" then
			local object = returnObject(taskdata.value)
			if object then
				taskframe:SetAttribute("ObjectName", object.Name)
			else
				error("Could not find object '"..taskdata.value.."' (Check if the string is correct and the object is within the workspace)")
			end	
		else
			error("'"..taskdata.parameter.."' is not a string (Set the value to the name of the object)")
		end
	elseif taskdata.parameter == "goal" then
		if typeof(taskdata.value) == "number" then	
			taskframe:SetAttribute("Progress", 0)
			taskframe:SetAttribute("Goal", tonumber(taskdata.value))
		else
			error("'"..taskdata.parameter.."' is not a number (Set the value to a number)")
		end		
	end

	-- description
	if taskdata.description ~= "" then		
		local taskdescription = guisfolder:WaitForChild("ObjectiveTaskDescription"):Clone()
		taskdescription.Name = taskid.."_description"
		taskdescription.Parent = objectivesframe
		taskdescription.Text = taskdata.description
		taskdescription.Visible = true	
	end
end

return displayObjectiveUI