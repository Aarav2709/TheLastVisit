speed = 10

function CA(child)

if child.className == "Model" then
local h = child:findFirstChild("Humanoid")
	if h ~= nil then
	h.WalkSpeed = speed
	else
	end
else
end

end

game.Workspace.ChildAdded:connect(CA)