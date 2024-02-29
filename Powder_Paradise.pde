enum STATE { MENU, GAME }
Game game;
Menu menu;
ImageUnit imageUnit;
HashMap<imageID, PImage> images;
HashMap<animationID, PImage[]> animations;
int bordeWidth;
boolean spacePressed;
STATE state;
int level;
int numLevel;
int score = 0;

void setup(){
  frameRate(60);
  size(1280, 720); // Set the canvas size
  level = 1;
  numLevel = 3;
  imageUnit = new ImageUnit();
  game = new Game();
  menu = new Menu();
  bordeWidth = width/4;
  state = STATE.MENU;
}

void draw(){
  switch (state){
    case MENU:
      menu.draw();
      break;
    case GAME:
      game.draw();
      break;
  }
}

// Check keys pressed
  void keyPressed() {
   if (key == ' '){
      spacePressed = true;
    }
    if (key == '1'){
      game.changeLevel(1);
    }
    if (key == '2'){
      game.changeLevel(2);
    }
    if (key == '3'){
       game.changeLevel(3);
    }
    if (key == 'm'){
       state = STATE.MENU;
    }
  }
  
  // Check keys released
  void keyReleased() {
    if (key == ' '){
      spacePressed = false;
    }
  }
    
  void mouseReleased(){
    menu.release();
  }
