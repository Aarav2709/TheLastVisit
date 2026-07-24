local SoundService = game:GetService("SoundService")

local creak = SoundService.SFX:WaitForChild("WoodCreak")

while true do

	-- wait before next creak
	task.wait(math.random(30,90))

	-- small variation
	creak.Volume = math.random(15,25)/100
	creak.PlaybackSpeed = math.random(90,110)/100

	creak:Play()

end