# Devlog

## 14th of July, 2026

- Began planning the project after the competition theme was revealed.
- Initially considered creating a large bungalow-style house, but revised the idea into a smaller and more realistic home after evaluating the available development time.
- Finalized the floor plan and overall layout that would serve as the foundation of the experience.

## 15th of July, 2026

- Began developing the environmental assets required for the house.
- Created major furniture pieces, including curtains, a couch, a king-style chair, and several decorative props.
- Built supporting assets such as carpets, books, and miscellaneous decorations to make the environment feel naturally lived in.
- Reached approximately 20% asset completion by the end of the day.

## 16th of July, 2026

- Continued expanding the asset library with tables, vases, plants, photo frames, and other decorative objects.
- Progress was slower due to other commitments, but development remained on schedule.

## 17th of July, 2026

- Began constructing the house by modelling walls and floors in Blender before importing them into Roblox Studio.
- Applied Roblox Studio's built-in PBR material system to improve visual quality while maintaining compatibility with the engine.
- Built doors, staircases, and the structural layout for the first floor.
- Used my own house as a reference when additional inspiration was needed, helping the environment feel more authentic.

## 18th of July, 2026

- Finalized the complete ground floor layout.
- Began constructing and furnishing the first floor.
- Designed additional windows, photo frames, plant variations, and other decorative assets before integrating them into the environment.

## 19th of July, 2026

- Continued creating environmental props, including additional vases and household decorations.
- Added clothing props and subtle dust effects to reinforce the feeling of returning to a house that had remained untouched for years.
- Integrated the newly created assets into the environment.

## 20th of July, 2026

- Concluded large-scale asset development and shifted focus towards improving environmental realism.
- Implemented interior lighting across the ground floor with individually positioned light sources.
- Dedicated most of the day to lighting refinement, leaving the first floor for completion later.

## 21st of July, 2026

- Completed the overall lighting setup using Atmosphere, Color Correction, Blur, and other post-processing effects.
- Created and configured a custom sky to better match the intended atmosphere.
- Performed optimization using Roblox MicroProfiler and built-in performance analysis tools, achieving the following improvements:

  - Memory usage: approximately 2.1 GB to 1.7 GB
  - CPU utilization: approximately 33% to 21%
  - GPU utilization: approximately 15% to 7%

- Identified asset-loading behaviour as the primary performance bottleneck and adjusted rendering settings accordingly.
- Completed the remaining first-floor lighting and implemented functional lamps throughout the house.

## 22nd of July, 2026

- Finished the interactive fireplace after extensive tuning of particle effects and animations.
- Shifted development from environment building to gameplay programming.
- Implemented a custom first-person camera system with movement bobbing.
- Refined player movement by reducing walking speed, disabling unnecessary UI elements, removing jumping, and eliminating footstep sounds to better suit the intended atmosphere.
- Added ambient background audio to strengthen immersion.
- Developed a custom loading screen.
- Performed backend optimizations and resolved numerous gameplay and scripting bugs.

## 23rd of July, 2026

- Completed several systems that had been developed alongside the rest of the project, including:

  1. Story introduction sequence
  2. Ending sequence
  3. Objective system
  4. Additional immersion features and bug fixes

- Integrated and customized an objective system to guide player progression through the narrative, including interaction tracking for meaningful objects placed throughout the house.
- Refined the environmental lighting to achieve a more natural and believable appearance.
- Revisited the core gameplay design and replaced generic collectible objects with meaningful household items that naturally belong within the environment, allowing exploration itself to drive the narrative.
- Performed additional mesh and lighting optimizations, improving runtime performance by approximately 10% compared with previous builds.

## 24th of July, 2026

- Completed the integration of the core gameplay progression systems, connecting the story, objective, interaction, and event systems into a complete playable loop.
- Finalized and tested the objective progression system with placeholder dialogue, ensuring that player interactions correctly update objectives and progress the game from the beginning sequence to the ending sequence.
- Implemented the final narrative flow, including the transition from the ending sequence into the end credits system, creating a smoother conclusion to the overall experience.
- Improved the communication between different gameplay systems by replacing temporary solutions with more structured event-based systems, reducing dependency on hardcoded values and improving future scalability.
- Resolved multiple critical bugs across the project, including objective completion detection, dialogue progression issues, event triggers, and player control states.
- Continued refining the overall gameplay architecture by making systems more modular and reliable, preventing future issues caused by interconnected scripts.
- Dedicated the entire day to development after taking a day off school, with the main focus being the completion of the core gameplay loop. More than 10 significant issues were identified and fixed while restructuring several systems to ensure stability.
- The remaining work is focused on final object interactions, dialogue improvements, audio implementation, optimization, bug fixes, and overall presentation polish.
