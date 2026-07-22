
local function spin()
	task.wait()
	script.Parent.Rotation = script.Parent.Rotation - 5
end
--[[

if script.Parent.Parent.hc.Value == false then
	repeat
		spin()
	until
		script.Parent.Parent.Parent["cutscene."]["finished."].Value == true
else
	local startTime = tick()
	
	repeat
		spin()
	until
		tick() - startTime > 8
end

]]

while true do
	spin()
end
