class Skier{
    float x; 
    float y;
    float w;
    float h;
    
    public Skier(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    public boolean collisionObstacle(Obstacle obs){
      if (x+10 > obs.x && x-10 < obs.x+obs.w){
        if (y+10 > obs.y && y-10 < obs.y+obs.h){
          return true;
        }
      }
      return false;
    }
    
    public boolean collisionSki(ExtraSki ski){
      if (x+10 > ski.x && x-10 < ski.x+ski.w){
        if (y+10 > ski.y && y-10 < ski.y+ski.h){
          return true;
        }
      }
      return false;
    }
}
