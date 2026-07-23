# Devlog

## 14th of July, 2026

- Began planning the project immediately after the competition theme was revealed.
- My initial concept was a large bungalow-style house, but after evaluating the project's scope, I redesigned it into a smaller, more realistic home.
- Finalized the floor plan and overall layout that would serve as the foundation for the entire experience.

## 15th of July, 2026

- Started developing the environmental assets required for the house.
- Created major furniture pieces including curtains, a couch, a king-style chair, and several decorative props.
- Built supporting assets such as carpets, books, and miscellaneous decorations to make the environment feel naturally lived in.
- Reached approximately 20% asset completion by the end of the day.

## 16th of July, 2026

- Continued expanding the asset library with tables, vases, plants, photo frames, and other decorative objects.
- Progress was slower due to other commitments, but development remained on schedule.

## 17th of July, 2026

- Began constructing the house by modelling walls and floors in Blender before importing them into Roblox Studio.
- Applied Roblox's built-in PBR material system to improve visual quality while maintaining engine compatibility.
- Built doors, staircases, and the structural layout for the first floor.
- Used my own house as a design reference whenever additional inspiration was needed, helping the environment feel more authentic.

## 18th of July, 2026

- Finalized the complete ground floor layout.
- Began constructing and furnishing the first floor.
- Designed additional windows, photo frames, plant variations, and other decorative assets before integrating them into the environment.

## 19th of July, 2026

- Continued creating environmental props including additional vases and household decorations.
- Introduced clothing props and subtle dust effects to reinforce the feeling of returning to a house that had remained untouched for years.
- Integrated all newly created assets into the environment.

## 20th of July, 2026

- Concluded large-scale asset development and shifted focus toward improving environmental realism.
- Implemented interior lighting across the ground floor with individually positioned light sources.
- Dedicated most of the day to lighting refinement, leaving the first floor for completion later.

## 21st of July, 2026

- Completed the overall lighting setup using Atmosphere, Color Correction, Blur, and other post-processing effects.
- Created and configured a custom sky to better match the intended atmosphere.
- Performed optimization using Roblox MicroProfiler and built-in performance analysis tools, achieving the following improvements:

  - Memory Usage: ~2.1 GB → ~1.7 GB
  - CPU Utilization: ~33% → ~21%
  - GPU Utilization: ~15% → ~7%

- Identified asset loading behaviour as the primary performance bottleneck and adjusted rendering settings accordingly.
- Completed the remaining first-floor lighting and implemented functional lamps throughout the house.

## 22nd of July, 2026

- Finished the interactive fireplace after extensive tuning of particle effects and animations.
- Shifted development from environment building to gameplay programming.
- Implemented a custom first-person camera system featuring movement bobbing.
- Refined player movement by reducing walking speed, disabling unnecessary UI elements, removing jumping, and eliminating footstep sounds to better suit the intended atmosphere.
- Added ambient background audio to strengthen immersion.
- Developed a custom loading screen.
- Performed backend optimizations and resolved numerous gameplay and scripting bugs.

## 23rd of July, 2026

- Completed several systems that had been under development alongside the rest of the project, including:

  1. Story introduction sequence.
  2. Ending sequence.
  3. Objective system.
  4. Additional immersion features and extensive bug fixes.

- Designed and implemented a custom objective system to guide player progression through the narrative, replacing the original demonstration framework with game-specific objectives and interaction tracking.
- Refined the environmental lighting to achieve a more natural and believable appearance.
- Revisited the core gameplay design and replaced generic collectible objects with meaningful household items that naturally belong within the environment, allowing exploration itself to drive the narrative.
- Performed additional mesh and lighting optimizations, improving runtime performance by approximately 10% compared to previous builds.
- Integrated the story, objective, and gameplay systems into a unified progression flow, ensuring exploration, interactions, and narrative events occur seamlessly.
- With the environment, presentation systems, optimization, and narrative framework largely complete, the remaining focus is implementing the final object interactions and polishing the overall experience.
