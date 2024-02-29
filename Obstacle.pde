enum obstacleID {BEAR, ROCK, BARRICADE};

class Obstacle{
   float x;
   float y;
   float w;
   float h;
   obstacleID id;
   PImage img;
   boolean movingDown;
   
   public Obstacle(obstacleID id){
     this.id = id;
     x = int(random(bordeWidth, width-bordeWidth));
     y = 200;
     initObstalce();
   }
   
   void initObstalce(){
     switch (id){
       case BEAR:
         img = images.get(imageID.BEAR);
         w = 75;
         h = 50;
         break;
       case ROCK:
         img = images.get(imageID.ROCK);
         int size = int(random(25, 75));
         w = size;
         h = size;
         break;
       case BARRICADE:
         img = images.get(imageID.BARRICADE);
         w = 75;
         h = 50;
         break;
       default:
         img = null;
     }
   }
}
