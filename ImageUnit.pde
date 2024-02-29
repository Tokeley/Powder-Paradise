enum imageID {SKIER, SNOWMOBILE, TREE, CLOUDS, BEAR, ROCK, BARRICADE, EXTRALIFE, MENUIMAGE, LOGO, BIGBUTTON, SMALLBUTTON};
enum animationID {CLOUDS};
// Used for loading and accessing images and animation images (arrays of images)
class ImageUnit{
  public HashMap<imageID, PImage> images = new HashMap<>();
  public HashMap<animationID, PImage[]> animations = new HashMap<>();
  
  public ImageUnit(){
    loadImages();
    loadAnimations();
  }
  
  // load images into images map
  private void loadImages(){
    
    images.put(imageID.SKIER, loadImage("Images/Skier.png"));
    images.put(imageID.SNOWMOBILE, loadImage("Images/SnowMobile.png"));
    images.put(imageID.TREE, loadImage("Images/Tree1.png"));
    images.put(imageID.BEAR, loadImage("Images/Bear.png"));
    images.put(imageID.BARRICADE, loadImage("Images/Barricade.png"));
    images.put(imageID.ROCK, loadImage("Images/Rock.png"));
    images.put(imageID.EXTRALIFE, loadImage("Images/ExtraLife.png"));
    images.put(imageID.MENUIMAGE, loadImage("Images/Menu_BG.png"));
    images.put(imageID.LOGO, loadImage("Images/Logo.png"));
    images.put(imageID.BIGBUTTON, loadImage("Images/Button_Big.png"));
    images.put(imageID.SMALLBUTTON, loadImage("Images/Button_Small.png"));
  }
  
  // load image array into animations map
  private void loadAnimations(){
    animations.put(animationID.CLOUDS, loadAnimation(loadImage("Images/Clouds.png"), 540));
  }
  
  // Make animation array from sprite sheet
  private PImage[] loadAnimation(PImage fullImage, int frameWidth){
    int frames = fullImage.width/frameWidth;
    PImage[] animation = new PImage[frames];
    
    for(int i = 0; i < frames; i++){
      PImage frameImage = fullImage.get(i*frameWidth, 0, frameWidth, fullImage.height);
      animation[i] = frameImage;
    }
    
    return animation;
  }
}
