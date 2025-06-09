# Dev Log:

This document must be updated daily every time you finish a work session.

## Tudor Ganshaw

### 2025-05-22 - Absent
My sister was graduating and I couldn't miss that so unfortunately I was not in class. Sorry about that.

### 2025-05-25 - Map Class
I started on the Map class, getting the basic functions in and adding things that I forgot to consider when making the UML diagrams.
Finished getMap which turns a premade text file into a map arr
Finished createPellets which sets all empty spaces in a map into pellets.
Started on the Ghost class, added a constructor that takes a map.
Also added a move() command, added isOnScreen() to the Map class, added better and more set and get functions to Map.
Updated getMap so that maps don't have to have spaces in between tiles.

## 2025-05-27 - Switching Arr to Nodes
Started on the process of switching maps from using an array to a node system.
Tried to test if the arr to node worked, but when making a toString to debug, terminal refused to update the code I'd written and only ran old code.

## 2025-05-28 - Fixing up Node implementations
Worked on converting Ghost from arr to node.
HEAVILY improved Ghost move() command; made it actually good.
Plans for tomorrow so I don't forget: Update UML Diagrams, check over code for Map & Ghost once more to see that everything is good, start working on Game.pde

## 2025-05-29 - Forgot to update devLog
Forgot to update the devLog for this day, although I know I did stuff. I think it was mostly working on more of the Ghost conversion since a lot of things were broken from how I wrote it.

## 2025-05-30 - Getting the Ghosts moving
Today was mainly just working on getting the Ghosts rendering and moving. Ultimately kind of did this, although they jump between tiles rather than smoothly slide between them. I tried very hard to try and get them to move smoothly; they ended up just rocketing off the side of the screen. I will continue on this endeavor although it is a failing one. I also made the Ghosts different colors, which will be used later after the MVP for the final build.

## 2025-05-31 - Attempted to kill PacMan. PacMan won
Today was mainly just polish to get stuff ready for the MVP. The main thing I did today was add death. Now, when PacMan gets a power up, he can kill ghosts for ~5-ish seconds. When he kills them by being on the same tile as them, they just respawn in the ghost box. The whole eyes pathfinding back thing can be done later. I also made it so killing a ghost increases score by 200. Then, I tried to get PacMan to also be able to die. Let's just say it didn't go well. The death can trigger, sure, but it doesn't work, because for some reason that I can't find for the life of me, every map.getAt(x,y) won't give the node that you ask for, it'll always give a node with PacMan's coords. IDK if that's because PacMan is infecting all the nodes like a parasite or what but it's very bad. He's effectively cheating death. Back after testing. Turns out pac man changes the value of every single node. He goes up, so does the y value of the nodes. Why this happens I'll never understand. Not only that, but for some reason he can die once except only under specific coordinates set as spawn, and even then he doesn't spawn at those coordinates. I'm just gonna make the death flag end the game and put up a big white screen.

## 2025-06-02 - Wraparound and bug fixes
Today was mostly spent adding wraparound, fixing previous bugs, polishing the score system, and trying to figure out why Pacman must cheat death.

## 2025-06-03 - Added lives, level reset, and bug fixes
Main things done today were adding a life system, a way for levels to reset upon pull pellet collection, and an immunity system so Pac Man doesn't get sent into a death loop. We also discussed how to implement different ghost movements. At home, I added some debug testing commands. I attempted to start on the ghost chasing algorithm, although I have to re start from scratch, since using previously made algorithms didn't work.

## 2025-06-04 - Tried to add pathfinding
Today we tried to add ghost pathfinding to Pac Man, although the one algorithm I came up with ended up not being able to run as it was incredibly slow.

## 2025-06-05 - Added start and death screen
Self explanatory. I added a main menu screen from which players can start the game, and a screen where you can see your score and restart the game upon death.

## 2025-06-06 - Added info screen, cleaned up debug menus
Today I added an info screen to the menu screen so that people could learn how to play and see the debug keys, and I cleaned up other parts, like how score is displayed in game.

## 2025-06-07 - Gave up on pathfinding
Today I gave up on pathfinding, because it's impossible. For whatever reason the ghost won't do what it's meant to do despite the fact that it definitely should, and I have no clue what the issue it. Ghosts moving randomly works well enough. Besides giving up on that, I did the README and updating ghosts so they flash when the power up time is almost over. Luckily Raphael was already working on that and managed to do it better than me. Everybody say thank you Raphael. Besides that, I fixed bugs with the ghosts turning unafraid if they died while afraid, and with them moving through walls after being unafraid. I also added in new sprites for each of the ghosts that update with where they're looking, and animated Pac Man sprites. I tried to add the animation of him popping when a ghost gets him, but that has yet to work.

## 2025-06-08 - Video Editing
Today was mostly just editing the final video, fixing last minute bugs, and redoing the UML diagrams.
