# Devlog

## 14th of July, 2026
- I began with the development of assets after the theme was released.
- I initially planned out on making a Large Bungalow Type-of house.
- But eventually, I settled on a small, realistic looking house.
- I planned the initial layout of the house.

## 15th of July, 2026
- Today, I started with the development of assets. I spent a lot of time analyzing what would be required.
- I made curtains, couch, a king-looking seat, and some more stuff.
- Then I developed models which would fill the remaining areas, like carpets, books, etc, to make the scene more filled.
- I ended the day with almost 20% of assets, completed.

## 16th of July, 2026
- I continued with the development of assets, such as a table, vase, plants, photos, etc.
- I wasn't able to put much time today due to being involed in other tasks.

## 17th of July, 2026
- I booted up Roblox Studio and started making Walls and Floors in Blender, and imported all that to Roblox.
- I textured walls and floors using Roblox Studio's in-built PBR Texturing System for better compatibility with Engine.
- When I was done, I decided to do Doors, and eventually made staircases, giving access to the First Floor.
- I was running out of ideas so I decided to follow how my House is designed.

## 18th of July, 2026
- I finalized Ground Floor in Roblox Studio today itself, since all the assets were finalized and I was too lazy to add some more stuff on ground floor.
- I began duplicating doors on the First Floor, and started with asset development for it again.
- I spent most of my time designing Window, Photo Frames, and more varities of plants.
- I placed all of it accordingly too.

## 19th of July, 2026
- I continued to develop more assets, that is, vases, and thought of making some cloths and add some dust particles over specific items since my game resembles the player revisiting his old house after ages.
- I added all those assets.

## 20th of July, 2026
- I thought that the assets that are developed for now are way more than enough.
- Now I decided to add some "Realism" to the game, for which I added Light Sources *INSIDE* the house.
- This took a lot of time for Ground Floor, First Floor was TBD.

## 21st of July, 2026
- Today, I finally setted up the In-Game Lighting. I added Atmosphere, adjusted tones, with more levels to density.
- I made my own sky asset and fine-tuned it accordingly.
- I added Blur and did some Color Correction too.
- The game looked way better, and had finally had some life in it.
- I ran MicroProfiler and In-built Performance Capturing to it and optimized the game. I was able to achieve the following:
1) Memory from ~2.1GB to ~1.7GB
2) CPU Util from ~33% to ~21%
3) GPU Util from ~15% to ~7%
> The main thing that I realized while doing Optimizations was how assets were being rendered when the Game Loaded, and I ran several tests and found a perfect setting.
- I fixed the First Floor's Light Sources and Added Lighting to Lamps.

# 22nd of July, 2026
- I made the fireplace working, a lot of tuning work was done:  (thanks to maths, I learnt graphs and this made my work a lot more easier hah!)
- Today, I decided to not build anymore and start scripting, which includes the core gameplay, and player interactions and UX.
- I started with scripting, and successfully coded a First Person Camera, with Bobbing after 4 hours.
- I modified player speeds to be slower, disabled most of the UI, and disable jumping and no walk sound (sounded bad) for more realism.
- Added creepy background music too!
