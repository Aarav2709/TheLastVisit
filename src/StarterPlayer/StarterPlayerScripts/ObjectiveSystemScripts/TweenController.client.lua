-- services
local ts = game:GetService("TweenService")
local plrs = game:GetService("Players")
local rps = game:GetService("ReplicatedStorage")
-- modules
local modulesfolder, guisfolder = rps:WaitForChild("Modules"), rps:WaitForChild("GUIs")
local objectivesframework, frameworkconfig, objectivesIndex, displayObjectiveUI, eventsManager = require(modulesfolder:WaitForChild("ObjectivesFramework")), require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("frameworkConfig")), require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("objectivesIndex")), require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("displayObjectiveUI")), require(modulesfolder:WaitForChild("ObjectivesFramework"):WaitForChild("eventsManager"))
-- remotes
local remotesarray = {}
for _, child in pairs(rps:WaitForChild("Remotes"):GetChildren()) do
	remotesarray[child.Name] = child
end
-- plr
local plr = plrs.LocalPlayer
local plrgui = plr.PlayerGui
-- guis
local objectivesystemgui = plrgui:WaitForChild("ObjectiveSystemGUI")
local objectivetitleframe, objectivesframe = objectivesystemgui:WaitForChild("ObjectiveTitleFrame"), objectivesystemgui:WaitForChild("ObjectivesFrame")
-- values
local storedObjective = ""

-- fetch
local function returnObjectiveData(id)
	local data = objectivesIndex[id]
	if data then
		return data
	else
		error("Failed to fetch objective: "..id)
	end
end

-- functions
local function resetObjectiveUI()
	objectivetitleframe.ObjectiveTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
	objectivetitleframe.ObjectiveTitleLabel.MaxVisibleGraphemes = 0
	objectivetitleframe.ObjectiveTitleLabel.Text = ""
	objectivetitleframe.Position = frameworkconfig.objective_title_start_pos
	objectivetitleframe.Size = frameworkconfig.objective_title_start_size
end

local function unloadObjectiveTasks()
	local children = objectivesframe:GetChildren()
	local index = #children
	for i = index, 1, -1 do
		local child = children[i]
		if not child:IsA("UIListLayout") then		
			if child:IsA("TextLabel") then
				task.wait(0.2)
			elseif child:IsA("CanvasGroup") then
				task.wait(0.1)
			end
			child:Destroy()
		end
	end
end

local function loadObjectiveTasks(objectiveId)
	local objectiveData = returnObjectiveData(objectiveId)
	for index, array in ipairs(objectiveData.tasksSequence) do	
		if index == 1 then
			task.wait(0.2)
			displayObjectiveUI.generateSubheader("Tasks")	
		else
			task.wait(0.2)
			displayObjectiveUI.generateSubheader("Optional")	
		end			
		for _, taskid in ipairs(array) do
			local taskdata = objectiveData.tasks[taskid]
			task.wait(0.1)
			displayObjectiveUI.generateTask(taskid, taskdata)	
		end
	end
end

-- tweens
local function tweenObjectiveTitleText(state, chars)
	if state == "in" then
		local speed = 1
		local goal= {MaxVisibleGraphemes = chars}
		ts:Create(objectivetitleframe.ObjectiveTitleLabel, TweenInfo.new(speed), goal):Play()
		task.wait(speed*2)
	elseif state == "out" then
		local speed = 0.5
		local goal= {MaxVisibleGraphemes = 0}
		ts:Create(objectivetitleframe.ObjectiveTitleLabel, TweenInfo.new(speed), goal):Play()
		task.wait(speed*2)
	end
end

local function tweenObjectiveTitle(state)
	if state == "in" then
		local speed = 0.5
		local goal = {Position=frameworkconfig.objective_title_end_pos, Size=frameworkconfig.objective_title_end_size}
		ts:Create(objectivetitleframe, TweenInfo.new(speed, Enum.EasingStyle.Circular, Enum.EasingDirection.In), goal):Play()
		task.wait(speed)
		objectivetitleframe.ObjectiveTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	elseif state == "out" then
		local speed = 0.25
		local goal = {Position=frameworkconfig.objective_title_start_pos, Size=frameworkconfig.objective_title_start_size}
		ts:Create(objectivetitleframe, TweenInfo.new(speed, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), goal):Play()
		task.wait(speed)
		objectivetitleframe.ObjectiveTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	end
end

local function tweenInObjectiveEvent(objectiveId)
	if storedObjective ~= "" then
		unloadObjectiveTasks()
	end
	
	-- animate text in
	if storedObjective == "" then
		objectivetitleframe.ObjectiveTitleLabel.Text = objectiveId	
		tweenObjectiveTitleText("in", string.len(objectiveId))
		
		-- animate title into position & size
		tweenObjectiveTitle("in")
	else
		tweenObjectiveTitleText("out")
		objectivetitleframe.ObjectiveTitleLabel.Text = objectiveId	
		tweenObjectiveTitleText("in", string.len(objectiveId))
	end
	
	-- load tasks in
	loadObjectiveTasks(objectiveId)
	storedObjective = objectiveId
	print("Initiating Objective: "..objectiveId)
	eventsManager.initiateObjective()
end

local function tweenOutObjectiveEvent()
	task.wait(2)
	local objectiveData = objectivesIndex[storedObjective]	
	local nextObjectiveId = objectiveData.autoNextObjective
	if nextObjectiveId ~= nil then	
		if tostring(nextObjectiveId) and nextObjectiveId ~= "" then
			objectivesframework.stageObjective(nextObjectiveId)	
			return
		end	
	end
	
	-- no auto next objective
	print("Completing Objective: "..storedObjective)
	unloadObjectiveTasks()
	tweenObjectiveTitleText("out")
	resetObjectiveUI()
	storedObjective = ""
	eventsManager.completeObjective()
end

-- connects
remotesarray["TweenInObjective"].OnClientEvent:Connect(tweenInObjectiveEvent)
remotesarray["TweenOutObjective"].OnClientEvent:Connect(tweenOutObjectiveEvent)