while true do
	wait(10)
	local m = math.random(1,6)

	if m == 1 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=13061810"
		script.Sound.PlaybackSpeed = 0.3
		--script.Sound.PitchEffect.Octave = 0.3
		script.Sound:Play()
	end

	if m == 2 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=13061809"
		script.Sound.PlaybackSpeed = 0.2
		--script.Sound.PitchEffect.Octave = 0.2
		script.Sound:Play()
	end

	if m == 3 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=13061810"
		script.Sound.PlaybackSpeed = 0.1
		--script.Sound.PitchEffect.Octave = 0.1
		script.Sound:Play()
	end

	if m == 4 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=13061802"
		script.Sound.PlaybackSpeed = 0.1
		--script.SoundEffect.Octav.PitchEffect.Octave = 0.1
		script.Sound:Play()
	end

	if m == 5 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=13061809"
		script.Sound.PlaybackSpeed = 0.1
		--script.Sound.PitchEffect.Octave = 0.1
		script.Sound:Play()
	end

	if m == 6 then
		script.Sound.SoundId = "http://www.roblox.com/asset/?id=12229501"
		script.Sound.PlaybackSpeed = 0.1
		--script.Sound.PitchEffect.Octave = 0.1
		script.Sound:Play()
	end

end
