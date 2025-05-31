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
