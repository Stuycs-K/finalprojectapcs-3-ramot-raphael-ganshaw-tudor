# Dev Log:

This document must be updated daily every time you finish a work session.

## Raphael Ramot

### 2025-05-22 - Planning
Tudor was absent so the UML diagrams are not complete with a main/game class. I spent maybe 20 minutes learning about branches and creating mine. The rest was spent doing planning for the pac-man class. 

### 2025-05-23 - Branching and Pac-man
20 mins learning and testing how to branch and merge. 20 minutes writing the basic Pac-man class.

### 2025-05-27 - Map Discussion and MapNode
Spent 15 mins talking to Mr. K about the plan for the map and discussing ourselves how we planned to implement nodes. Then spent the rest of class writing the MapNodes class with a location; mapnodes for up, down, left, right; and an object.

### 2025-05-28 - Editing map based on MapNodes
30 mins discussing electives as a class, rest of class spent making the map work with MapNodes and changing location of pac-man and ghosts to MapNodes.

### 2025-05-29 - Moving to Processing and starting to create map
We first moved all the files to Processing and did some work together with only Tudor typing, as we wanted to make sure we understood how the map worked before writing more code that expanded upon that. I moved on to work on the move function for Pac-man in the last few minutes of class. 
At home, I completed Pac-man's movement to ensure he could move by two pixels at a time and only turn once he reaches the center of the tile he is going to, or the location of his node. I also created the user controls for keypressed so he can move as te player intends.

### 2025-05-30 - Pac-man Movement and ghosts
I spent the beginning of class making Pac-man's movement work exactly as it does in the game (can receive directions for the next turn but only make that turn once there is no wall in that direction). The rest of class was spent working on ghost movement together.

### 2025-06-02 - Ghost Movement
Spent time discussing updates from weekend and next steps to advance from the MVP. I then worked on making Ghost movement similar to Pac-man in that it is smooth, not jumping between nodes. I fixed up the nodes a bit and worked on wraparound.
At home, I finished the ghost movement to be smooth like Pac-man.

### 2025-06-03 - End of Game
Worked together to make the levels reset, added lives, and immunity after losing a life. We discussed strategies for the ghost AI.

### 2025-06-04 - Ghost AI
Worked together to write an AI program that would find the shortest path to pacman.
In the end, the AI wasn't working as intended, so I focused on making each ghost move randomly by creating an arrayList of possible directions (nodes that aren't null) and choosing one randomly.

### 2025-06-06 - Ghost area and Images
I made the ghost area inaccesible to pac-man and changed its color. I added real types to each of the ghosts so they could have PImages instead of circles, and uploaded the images to the game.

### 2025-06-07 - Ghost AI and movement
I created the ghost AI based on a target location for each ghost, as described in the video and in the comments of the Ghost file. Each type has its own target. I also made the program switch between scatter and chase modes for specific amounts of time, as well as turn around when switching between these and being afraid.
I made the ghosts each begin at a specific location in the ghost house and move up and down until their timer is over: each is 3 seconds after the one before it. Then, they target the node above the ghost house and can no longer enter it again. 
I added the animation for Pac-man's death, the flashing colors of the ghosts at the end of being afraid, and the showing of points after eating a ghost.

### 2025-06-08 - Bug Fixes and video
I only worked on small bug fixes where the game didn't work exactly as intended in certain situations, such as when the developer command for reset is used. I also filmed my part of the video.