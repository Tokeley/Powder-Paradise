class ExtraSki{
   float x;
   float y;
   float w;
   float h;
   PImage img;
   boolean movingDown;
  
   public ExtraSki(){
     img = images.get(imageID.EXTRALIFE);
     x = int(random(bordeWidth, width-bordeWidth));
     y = 200;
     w = 75;
     h = 75;
   }
}
