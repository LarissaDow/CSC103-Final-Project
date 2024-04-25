class Player {

 //variables
  int x;
  int y;
  int w;
  int h;

  PImage playerImage;

  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isMovingUp;
  boolean isMovingDown;
  
  boolean isJumping;
  boolean isFalling;

  int speed;

  int jumpHeight;
  int topJumpY;

  int left;
  int right;
  int top;
  int bottom;

 //constructor
  Player(int startingX, int startingY, PImage img) {
    x = startingX;
    y = startingY;

    playerImage = img;
    w = round(playerImage.width);
    h = round(playerImage.height);
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;

    isJumping = false;
    isFalling = false;

    speed = 10;

    jumpHeight = 225;
    topJumpY = y - jumpHeight;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }

 //functions
  void display() {
   imageMode(CENTER);
    image(playerImage, x, y, playerImage.width, playerImage.height);
  }

  void move() {
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    if (isMovingLeft == true) {
      x -= speed;
    }

    if (isMovingRight == true) {
      x += speed;
    }
    
    if (isMovingUp == true) {
      y -= speed;
    }

    if (isMovingDown == true) {
      y += speed;
    }
  }

  void jumping() {
    if (isJumping == true) {
      y -= speed;
    }
  }

  void falling() {
    if (isFalling == true) {
      y += speed;
    }
  }

  void topJump() {
    if (y <= topJumpY) {
      isJumping = false; //stop jumping upward
      if (skyMode == true){
        y = h/2+ 5;
      } else {
        isFalling = true; //start falling down
      }
    }
  }

  void land() {
    if (y >= height - h/2) {
      isFalling = false;
      y = height - h/2;
    }
  }
}
