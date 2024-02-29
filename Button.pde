class Button{
    int x;
    int y;
    int w;
    int h;
    String text;
    PImage img;
    PImage fullImge;
    
    public Button(PImage fi, int x, int y, int w, int h, String text){
      this.text = text;
      fullImge = fi;
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.unpress();
    }
    
    void press(){
      img = fullImge.get(0, fullImge.height/2, fullImge.width, fullImge.height/2);
    }
    
    void unpress(){
      img = fullImge.get(0, 0, fullImge.width, fullImge.height/2);
    }
    
     void display(){
       image(img, x, y, w, h);
       fill(0); // Set the text color to black
       textSize(h-10); // Set the text size
       textAlign(CENTER, CENTER); // Center-align the text
       text(text, x + w/2, y + h/2 - (h * 0.2));
     }
     
     boolean coordsInside(int mX, int mY){
       if (mX > x && mX < x + w){
         if (mY > y && mY < y + h){
           return true;
         }
       }
       return false;
     }
    
}
