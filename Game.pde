class Game{
  Skier skier;
  Snowmobile snowmobile;
  float radius;
  float speed = 6;
  float skiMarkWidth = 10;
  float horizonY = 200;
  float acceleration = 1.00001;
  boolean jumping = false;
  boolean jumpingOver = false;
  boolean lifeDeduction = false;
  boolean generateExtraSkis = true;
  boolean alreadyHit = false;
  int safteyTimer = 0;
  float skierSize = 100;
  int numLives = 0;
  int obstacleProb;
  Button menuButton;
  
  ArrayList<PVector> skiTrackPoints = new ArrayList<>();
  ArrayList<Tree> trees = new ArrayList<>();
  ArrayList<Obstacle> obstacles = new ArrayList<>();
  ArrayList<ExtraSki> extraSkis = new ArrayList<>();
  
  
  public Game(){
    skier = new Skier(width/2, 775, skierSize, skierSize);
    snowmobile = new Snowmobile(width/2, horizonY, 100, 100);
    radius = skier.y - snowmobile.y;
    images = imageUnit.images;
    animations = imageUnit.animations;
    menuButton = new Button(imageUnit.images.get(imageID.BIGBUTTON), width - 120, 10, 100, 50, "Menu");
  }
  
  void draw(){
    println(level);
    speed = speed * acceleration;
    background(100, 160, 200);
    drawClouds();
    drawSlope();
    drawSkiMarks();
    drawTrees();
    drawObstacles();
    drawExtraSkis();
    drawRope();
    drawSnowmobile();
    drawSkier();
    drawScoreBoard();
    menuButton.display();
    updateSkierPos();
    checkCollisions();
    
    
    if (alreadyHit){
      safteyTimer++;
      if (safteyTimer > 25){
        alreadyHit = false;
        safteyTimer = 0;
      }
    }
    
    if (spacePressed && !jumping){
       jumping = true;
       skier.w = skier.w*2;
       skier.h = skier.h*2;
    }
    
    if(jumping){
      jump();
    }
    
    if (frameCount % 50 == 0){
      score++;
    }
    
    if (mousePressed){
      if (menuButton.coordsInside(mouseX, mouseY)){
        state = STATE.MENU;
      }
    }
  }
  
  void drawScoreBoard(){
    fill(50); 
    textSize(45); 
    textAlign(LEFT, LEFT);
    text("Score: " + score, 40, 50);
    
    if (jumpingOver){
      fill(50, 240, 0);
      text("+5", 250, 50);
    }
    
    fill(50); 
    text("Extra Lives: ", 40, 100);
    
    for (int i = 0; i < numLives; i++){
      image(images.get(imageID.EXTRALIFE), (250)+i*45, 60, 45, 45);
    }
    
  }
  
  void drawClouds(){
    image(animations.get(animationID.CLOUDS)[frameCount/8 % animations.get(animationID.CLOUDS).length], 0, 0, width, height/3);
  }
  
  void drawSlope(){
      fill(243, 241, 237);
      strokeWeight(0);
      rect(0, horizonY, width, height);
  }
  void drawSkiMarks(){
      if (!jumping){
         PVector newPoint = new PVector();
         newPoint.x = skier.x;
         newPoint.y = skier.y + skier.h/4;
         skiTrackPoints.add(newPoint);
      } 
      stroke(100); // Set the stroke color to black (0 is black in grayscale)
      strokeWeight(5); // Set the line thickness to 10 pixels
      for (int i = 0; i < skiTrackPoints.size(); i++){
        if(i >= 1){
          PVector p1 = skiTrackPoints.get(i-1);
          PVector p2 = skiTrackPoints.get(i);
          line(p1.x - skierSize/9 + (skiMarkWidth/2), p1.y+skiMarkWidth/2, p2.x - skierSize/9 + (skiMarkWidth/2), p2.y+skiMarkWidth/2);
          line(p1.x + skierSize/9 - (skiMarkWidth/2), p1.y+skiMarkWidth/2, p2.x + skierSize/9 - (skiMarkWidth/2), p2.y+skiMarkWidth/2);
        }
        //ellipse(point.x - skier.w/9 + (skiMarkWidth/2), point.y+skiMarkWidth/2, skiMarkWidth, skiMarkWidth);
        //ellipse(point.x + skier.w/9 - (skiMarkWidth/2), point.y+skiMarkWidth/2, skiMarkWidth, skiMarkWidth);
        skiTrackPoints.get(i).y += speed;
      }
      
      // limit number of points
     if (skiTrackPoints.size() > 30){
       skiTrackPoints.remove(0);
     }
  }
  
  void drawTrees(){
     if (int(random(0, 2)) == 0){
        Tree tree = new Tree();
        tree.w = int(random(40, 100));
        tree.h = int(random(80, 190));;
        if(int(random(0, 2)) == 0){ tree.x = int(random(0, bordeWidth-tree.w)); }
        else { tree.x = int(random((width-bordeWidth), width-tree.w)); }   
        tree.y = 200;
        tree.imageNum = 1;
        tree.movingDown = false;
        trees.add(tree);
     }
     
     for(int i = trees.size()-1; i >= 0; i--){
       Tree tree = trees.get(i);
       if(tree.movingDown){
         image(images.get(imageID.TREE), tree.x, tree.y, tree.w, tree.h);
         tree.y += speed;
       } else {
         image(images.get(imageID.TREE).get(0, 0, images.get(imageID.TREE).width, (int)(images.get(imageID.TREE).height*((horizonY - tree.y)/tree.h))), tree.x, tree.y, tree.w, horizonY-tree.y);
         tree.y -= speed;
       }
       if (tree.y+tree.h < horizonY){
         tree.movingDown = true;
       }
       
        // limit number of trees
       if (tree.y > height + tree.h){
         trees.remove(tree);
       }
     }
     
  }
  
  void drawObstacles(){
    if (int(random(0, obstacleProb)) == 0){
        obstacleID id;
        switch (int(random(0, obstacleID.values().length))){
          case 0:
            id = obstacleID.BEAR;
            break;
          case 1:
            id = obstacleID.ROCK;
            break;
          case 2:
            id = obstacleID.BARRICADE;
            break;
          default:
            id = obstacleID.BEAR;
            break;
        };
        Obstacle obstacle = new Obstacle(id);
        obstacles.add(obstacle);
     }
     
     for(int i = obstacles.size()-1; i >= 0; i--){
        Obstacle obstacle = obstacles.get(i);
        if(obstacle.movingDown){
         image(obstacle.img, obstacle.x, obstacle.y, obstacle.w, obstacle.h);
         obstacle.y += speed;
       } else {
         image(obstacle.img.get(0, 0, obstacle.img.width, (int)(obstacle.img.height*((horizonY - obstacle.y)/obstacle.h))), obstacle.x, obstacle.y, obstacle.w, horizonY-obstacle.y);
         obstacle.y -= speed;
       }
       if (obstacle.y+obstacle.h < horizonY){
         obstacle.movingDown = true;
       }
       // limit number of trees
       if (obstacle.y > height + obstacle.h){
         obstacles.remove(obstacle);
       }
     }
  }
  
  void drawExtraSkis(){
    if (numLives >= 3){generateExtraSkis = false;}
    else {generateExtraSkis = true;}
    if (int(random(0, 200)) == 0 && generateExtraSkis){
        ExtraSki extraSki = new ExtraSki();
        extraSkis.add(extraSki);
     }
     
     for(int i = extraSkis.size()-1; i >= 0; i--){
        ExtraSki extraSki = extraSkis.get(i);
        if(extraSki.movingDown){
         image(extraSki.img, extraSki.x, extraSki.y, extraSki.w, extraSki.h);
         extraSki.y += speed;
       } else {
         image(extraSki.img.get(0, 0, extraSki.img.width, (int)(extraSki.img.height*((horizonY - extraSki.y)/extraSki.h))), extraSki.x, extraSki.y, extraSki.w, horizonY-extraSki.y);
         extraSki.y -= speed;
       }
       if (extraSki.y+extraSki.h < horizonY){
         extraSki.movingDown = true;
       }
       // limit number of trees
       if (extraSki.y > height + extraSki.h){
         extraSkis.remove(extraSki);
       }
     }
  }
  
  void drawRope(){
    strokeWeight(2);
    stroke(0);
    line(skier.x, skier.y, snowmobile.x, snowmobile.y);
  }
  
  void drawSnowmobile(){
    image(images.get(imageID.SNOWMOBILE), snowmobile.x - (snowmobile.w/2), snowmobile.y - (snowmobile.h/2), snowmobile.w, snowmobile.h);
  }
  
  void drawSkier(){
    image(images.get(imageID.SKIER), skier.x - (skier.w/2), skier.y - (skier.h/2), skier.w, skier.h);
  }
  
  void updateSkierPos(){
    if(mouseX < bordeWidth || mouseX > width - bordeWidth){
      return;
    }
    skier.x = mouseX;
    skier.y = sqrt(pow(radius, 2)-pow((mouseX-(width/2)), 2));
  }
    
  void jump(){
    if (skier.w <= skierSize || skier.h <= skierSize){
      skiTrackPoints.clear();
      jumping = false;
      jumpingOver = false;
    }
     skier.w = skier.w*0.97;
     skier.h = skier.h*0.97;
  }
  
  void checkCollisions(){
    for (Obstacle obs : obstacles){
      if(skier.collisionObstacle(obs) && !jumping && !alreadyHit){ // Player hit object
          if (numLives == 0){ state = STATE.MENU; } 
          else { numLives--; }
           alreadyHit = true;
        }
      if (skier.collisionObstacle(obs) && jumping && !jumpingOver){// Player jumped over object
        score += 5;
        jumpingOver = true;
      }
    }
    
    ExtraSki toDelete = null;
    for (ExtraSki ski : extraSkis){
      if(skier.collisionSki(ski) && jumping){ return; }
      if (skier.collisionSki(ski) && numLives < 3){
        numLives ++;
        toDelete = ski;
      } 
    }
    extraSkis.remove(toDelete);
  }
  
  public void changeLevel(int level){
      switch (level){
        case 1:
          speed = 10;
          obstacleProb = 50;
          break;
       case 2:
          speed = 15;
          obstacleProb = 20;
          break;
       case 3:
          speed = 20;
          obstacleProb = 10;
          break;
       default:
          break;
      }
  }
  
}

  
