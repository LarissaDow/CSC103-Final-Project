class Obstacle {
 //variables
  int x;
  int y;
  int w;
  int h;

  int left;
  int right;
  int top;
  int bottom;
  
  PImage obstacleImage;
  
  boolean obstacleMovingLeft;
  boolean obstacleMovingRight;
  boolean randomSpeed;
  
  int xSpeed;

 //constructor
  Obstacle(int startingX, int startingY, PImage img, boolean randSpeed) {
    x = startingX;
    y = startingY;
    
    obstacleImage = img;
    randomSpeed = randSpeed;
    
    left = x - obstacleImage.width/2;
    right = x + obstacleImage.width/2;
    top = y - obstacleImage.height/2;
    bottom = y + obstacleImage.height/2;
    obstacleMovingLeft = true;
   
    xSpeed = 1;
  }

  void display() {
    imageMode(CENTER);
    image(obstacleImage, x, y, obstacleImage.width, obstacleImage.height);
  }

  void move() {
    left = x - obstacleImage.width/2;
    right = x + obstacleImage.width/2;
    top = y - obstacleImage.height/2;
    bottom = y + obstacleImage.height/2;
    if(obstacleMovingLeft == true){
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
      println ("Obstacle Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      return true;
    }
    else if (aPlayer.top <= bottom &&
      aPlayer.bottom >= top &&
      aPlayer.left < right &&
      aPlayer.right >= right) {
      aPlayer.isMovingLeft = false;
     aPlayer.x = (right + aPlayer.w/2);
      println("Left Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Obstacle Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }
    else if (aPlayer.left <= right &&
      aPlayer.right >= left &&
      aPlayer.bottom > top &&
      aPlayer.top <= top) {
      aPlayer.isJumping = false;
      aPlayer.isFalling = false;
      aPlayer.y = top - aPlayer.h/2;
      println("Top Collision Detected");
      println ("Player Top:",aPlayer.top," Bottom : ",aPlayer.bottom, " Right: ",aPlayer.right," Left :",aPlayer.left," width: ", aPlayer.w);
      println ("Obstacle Top:",top," Bottom : ",bottom, " Right: ",right," Left :",left);
      println ("Player X and Y: ",aPlayer.x,aPlayer.y);      
      return true;
    }
    return false;
  }
}
