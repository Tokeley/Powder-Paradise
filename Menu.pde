class Menu{
  int titleWidth = 800;
  int titleHeight = 150;
  
  int bigButtonWidth = 300;
  int bigButtonHeight = 100;
  int smallButtonWidth = 70;
  int smallButtonHeight = 70;
  Button playButton;
  Button exitButton;
  ArrayList<Button> levelButtons = new ArrayList<>();
  public Menu(){
    playButton = new Button(imageUnit.images.get(imageID.BIGBUTTON), (width/2)-bigButtonWidth/2, titleHeight + 100, bigButtonWidth, bigButtonHeight, "PLAY");
    exitButton = new Button(imageUnit.images.get(imageID.BIGBUTTON), (width/2)-bigButtonWidth/2, titleHeight + 100 + bigButtonHeight + 150, bigButtonWidth, bigButtonHeight, "EXIT");
    textSize(50); // Set the text size
    textAlign(CENTER, CENTER); // Center-align the text
    text("Select level", width/2, height/2);
    for (int i = 0; i < numLevel; i++){
      levelButtons.add(new Button(imageUnit.images.get(imageID.SMALLBUTTON), width/2-((numLevel*smallButtonWidth)/2) + (i*smallButtonWidth), titleHeight + 150 + bigButtonHeight, smallButtonWidth, smallButtonHeight, str(i+1)));
    }
    levelButtons.get(0).press();
  }
  
  
  void draw(){
    image(imageUnit.images.get(imageID.MENUIMAGE), 0, 0, width, height);
    image(imageUnit.images.get(imageID.LOGO), width/2-titleWidth/2, 60, titleWidth, titleHeight);
    textSize(50); // Set the text size
    textAlign(CENTER, CENTER); // Center-align the text
    text("Select level", width/2, height/2);
    playButton.display();
    exitButton.display();
    for (Button b : levelButtons ){
      b.display();
    }
    if (mousePressed){
      checkButtonPress(mouseX, mouseY);
    }
  }
  
  void checkButtonPress(int mX, int mY){
    if (playButton.coordsInside(mX, mY)){playButton.press();}
    if (exitButton.coordsInside(mX, mY)){exitButton.press();}
    for (Button b : levelButtons ){
      if (b.coordsInside(mX, mY)){
        unPressAll(levelButtons); 
        b.press(); 
        level = levelButtons.indexOf(b)+1;}
    }
  }
  
  void unPressAll(ArrayList<Button> levelButtons){
    for(Button b : levelButtons){
      b.unpress();
    }
  }
  
  void release(){
    if (playButton.coordsInside(mouseX, mouseY)){
      score = 0;
      state = STATE.GAME;
      game.changeLevel(level);
      playButton.unpress();
    }
    if (exitButton.coordsInside(mouseX, mouseY)){exit();}
    for (Button b : levelButtons ){
      if (b.coordsInside(mouseY, mouseY)){b.press();}
    }
  }
}
