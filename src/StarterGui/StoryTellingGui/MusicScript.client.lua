local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local music = SoundService.Music:WaitForChild("Yggdrasil")


music.Volume = 0
music.Looped = true
music:Play()


TweenService:Create(
	music,
	TweenInfo.new(5),
	{
		Volume = 0.2
	}
):Play()