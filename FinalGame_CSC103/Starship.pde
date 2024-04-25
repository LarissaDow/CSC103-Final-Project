class Starship {
 //variables
  int x;
  int y;
  int w;
  int h;

  int left;
  int right;
  int top;
  int bottom;
  
  PImage starshipImage;
  
  boolean starshipMovingLeft;
  boolean starshipMovingRight;
  boolean randomSpeed;
  
  int xSpeed;

 //constructor
  Starship(int startingX, int startingY, PImage img, boolean randSpeed) {
    x = startingX;
    y = startingY;
    
    starshipImage = img;
    randomSpeed = randSpeed;
    
    left = x - starshipImage.width/2;
    right = x + starshipImage.width/2;
    top = y - starshipImage.height/2;
    bottom = y + starshipImage.height/2;
    starshipMovingLeft = true;
   
    xSpeed = 1;
  }

  void display() {
    imageMode(CENTER);
    image(starshipImage, x, y, starshipImage.width, starshipImage.height);
  }

  void move() {
    left = x - starshipImage.width/2;
    right = x + starshipImage.width/2;
    top = y - starshipImage.height/2;
    bottom = y + starshipImage.height/2;
    if(starshipMovingLeft == true){
       x -= xSpeed;
       if(x ==0){
         x = width;
       }
    } 
  }
  
   boolean playerCollide(Player aPlayer) {
    if (aPlayer.top <= bottom &&
      aPlayer.bottom >= top &&
      aPlayer.right >= left &&
      aPlayer.left <= left ) {
      aPlayer.isMovingRight = false;
      aPlayer.x = (left - aPlayer.w/2);
      println("Right Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Starship Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }
    else if (aPlayer.top <= bottom &&
      aPlayer.bottom >= top &&
      aPlayer.left < right &&
      aPlayer.right >= right) {
      aPlayer.isMovingLeft = false;
      aPlayer.x = (right + aPlayer.w/2);
      println("Left Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Starship Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }
    else if (aPlayer.left <= right &&
      aPlayer.right >= left &&
      aPlayer.bottom >= top &&
      aPlayer.top < top) {
      aPlayer.isJumping = false;
      aPlayer.isFalling = false;
      println("Top Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Starship Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }
    else if (aPlayer.left <= right &&
      aPlayer.right >= left &&
      aPlayer.bottom > bottom &&
      aPlayer.top <= bottom) {
      aPlayer.isJumping = false;
      aPlayer.isFalling = false;
      println("Bottom Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Starship Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }    
    return false;
  }
}
