# Powder-Paradise ⛷️
Hit the slopes and tear up some powder with Powder Paradise. Power Paradise is a fun skiing game where you must dodge the obstacles to survive. This project was created with Processing.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation and Usage](#installation-and-usage)
- [Software Design Principles](#software-design-principles)
- [Contributors](#contributors)

## Overview

In Powder Paradise, the goal is to hold on to the jetski as long as possible without hitting an obstacle such as a polar bear, barrier, or rock. Move by using the mouse or trackpad and jump over obstacles with the space bar (which will give you a bonus 5 points). The game has three levels that increase in difficulty for more advanced skiers. See you on the slopes! 

## Features

- Steering determined by mouse position. 
- Multiple levels with increasing speed and obstacles 
- Ski tracks left behind skier
- Score system to track progress. Extra points can be earned by jumping over obstacles successfully.
- "Over the horizon" effect where trees and obstacles rise over the horizon to give the sense of movement
- Arcade style pixel art design

## Screenshots

![Screenshot 1](screenshot1.jpg)
*Figure 1: the menu.*

![Screenshot 2](screenshot2.jpg)
*Figure 2: the settings.*

## Installation and Usage

1. Download and install Processing from the official website (https://processing.org/download/).
2. Clone this repository () to your local machine or download the source code as a ZIP archive.
3. Open the Processing IDE and load the Powder Paradise project.
4. Click the "Run" button (or press `Ctrl+R`) to start the game.

## Technical challenges

- Getting the “Over the horizon” effect on trees and obstacles was quite difficult. I initially tried to have trees and obstacles spawn below the horizon and then rise up and when they reached a point, turn and go downwards and would cover them with the horizon rectangle, but because there were multiple trees and obstacles, if the horizon rectangle was covering one, it would cover all of them. To fix this I made the trees and obstacle images get cropped from the bottom of the  image less and less as they raised up by using Image.get() to crop.

- Another challenge was implementing the movement of the skier. Instead of having the skier move directly left and right, I wanted him to move in a semi-circle around the snowmobile. I took my a while to get the maths right but this was definitely worth doing. The calculation is: skier.y = sqrt(pow(radius, 2)-pow((mouseX-(width/2)), 2)); which uses the equation of a circle.
