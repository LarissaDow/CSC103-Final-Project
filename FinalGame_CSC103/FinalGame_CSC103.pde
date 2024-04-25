import processing.sound.*;

//declare vars
PImage [] obstacleImages = new PImage[4];
PImage [] unicornImages = new PImage[3];
PImage [] starshipImages = new PImage [1];

Animation p1Animation;
Animation cloudAnimation;

PImage backGroundImage;
PImage backGroundImage1;
PImage backGroundImage2;

int startTime;
int currentTime;
int interval = 9000;
float timeElapse;

Obstacle o1;
Obstacle o2;
Obstacle o3;
Obstacle o4;
Starship s1;

Player p1;
Player flyingPlayer;
boolean playerHit;

int playTime;
int speedUpCounter;
Timer startTimer;
boolean increaseSpeed;
boolean stopTime;
boolean obstacleFAnimation;
boolean obstacleTAnimation;
boolean starshipHit;
boolean sendStarship;
public boolean skyMode;

ArrayList<Obstacle> obstacleList;

SoundFile boingSound;
SoundFile unicornSound;
SoundFile clinkSound;


void setup() {
  size(1400, 600);

  backGroundImage1 = loadImage ("ct_blueSkies2.png");
  backGroundImage1.resize(width, height);
  backGroundImage2 = loadImage ("ct_blueSky4.jpg");
  backGroundImage2.resize(width, height);
  backGroundImage = backGroundImage1;

  playTime = 0;
  playerHit = false;
  increaseSpeed = false;
  stopTime = false;
  sendStarship = false;
  speedUpCounter = 0;

  for (int index=0; index<unicornImages.length; index=index+1) {
    unicornImages[index] = loadImage("unicorn" + index + ".png");
    println ("filename : unicorn" + index + ".png");
    unicornImages[index].resize(80, 95);
  }
  for (int index=0; index<obstacleImages.length; index++) {
    obstacleImages[index] = loadImage("cloud" + index + ".png");
    obstacleImages[index].resize(35, 35);
  }

  for (int index=0; index<starshipImages.length; index++) {
    starshipImages[index] = loadImage("starships" + index + ".png");
    starshipImages[index].resize(45, 45);
  }

 //initialize animation var
  p1Animation = new Animation(unicornImages, .25, 1);


 //draw text
  textSize(50);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

 //initialize timer vars
  startTime = millis();

 //initialize vars
  obstacleFAnimation = false;
  obstacleTAnimation = true;
  skyMode = false;
  starshipHit = false;

 //load obstacles
  o1 = new Obstacle(width-5, height - 55, obstacleImages[0], obstacleFAnimation);
  o2 = new Obstacle(width-255, height - 55, obstacleImages[1], obstacleTAnimation);
  o3 = new Obstacle(width-300, height - 55, obstacleImages[2], obstacleFAnimation);
  o4 = new Obstacle(width-600, height - 55, obstacleImages[3], obstacleFAnimation);
  s1 = new Starship(width, height/2, starshipImages[0], true);
 //load players
  p1 = new Player(width/8, height-50, unicornImages[0]);
  flyingPlayer = new Player(width/6, height/2, unicornImages[2]);


  startTimer = new Timer(playTime);

  obstacleList = new ArrayList<Obstacle>();

  obstacleList.add(o1);
  obstacleList.add(o2);
  obstacleList.add(o3);
  obstacleList.add(o4);

//sound
  boingSound = new SoundFile(this, "boing.wav");
  unicornSound = new SoundFile(this, "unicorn.wav");
  clinkSound = new SoundFile(this, "clink.wav");
  clinkSound.rate(2);
  boingSound.rate(1.5);
  unicornSound.rate(2);
  unicornSound.loop();
}


void draw() {
  background(backGroundImage);

  increaseSpeed = false;

 //set Count timer
  if (stopTime == true) {
    stopObstacles ();
    gameOverPage ();
    playerHit = false;
  } else {
    startTimer.countUp();
    timeElapse = startTimer.getTime();
  }

  fill(255);
  text(round(timeElapse), width/2, 35);

 //sets current time for speed interval timer
  currentTime = (millis() );

  if (currentTime - startTime > interval) {
    println("timer triggered!", currentTime, startTime);
    increaseSpeed = true;
    speedUpCounter = speedUpCounter + 1;
      if (speedUpCounter >= 2){
        sendStarship = true;
      }
 //reset timer
    startTime = millis();
  }

//setup for sky mode
  if (starshipHit == true) {
    skyMode = true;
    starshipHit = false;
    p1Animation.isAnimating = false; 
    backGroundImage = backGroundImage2;
    p1.playerImage = flyingPlayer.playerImage;
    p1.x = flyingPlayer.x;
    p1.y = flyingPlayer.y;
    p1.isFalling = false;
    p1.isJumping = false;
    p1.topJumpY = p1.playerImage.height/2;
    s1.x = round (width-350);
    s1.y = height/2;

//making obstacles come in random 
    for (Obstacle anObstacle : obstacleList) {
      if (skyMode == true) {
        anObstacle.x = round(random(width, width - 200));
        anObstacle.y = round(random (100, height - 100));
      }
    }
  }
  else{
    p1Animation.display(p1.x, p1.y);
  }
  
 //call functions for player and starship
  p1.display();
  p1.move();
  p1.jumping();
 if (sendStarship == true){
  s1.display();
  s1.move();
 }
  p1.falling();
  p1.topJump();
  p1.land();

  if (boingSound.isPlaying()) {
    boingSound.pause();
    unicornSound.loop();
  }

  if (s1.playerCollide (p1)) {
    starshipHitPage ();
    s1.starshipMovingLeft = false;
    starshipHit = true;
    println ("p1 x y : ", p1.x, p1.y);
    if (unicornSound.isPlaying()) {
      unicornSound.pause();
    }
    clinkSound.play();
    clinkSound.play();
  }

  if (playerHit) {
    hitPage();
    stopTime = true;
    s1.starshipMovingLeft= false;

    if (mousePressed) {
      playerHit = false;
      setup();
      startObstacles();
      unicornSound.loop ();
    }
  }

//use of obstacle functions 
  for (Obstacle anObstacle : obstacleList) {
    anObstacle.display();
    anObstacle.move();
    if (anObstacle.playerCollide(p1)) {
      if (boingSound.isPlaying()) {
        boingSound.pause ();
      }
      if (unicornSound.isPlaying()) {
        unicornSound.pause ();
      }
      stopObstacles();
      playerHit = true;
    }
    if (anObstacle.x <= 0) {
      anObstacle.x = width;
      if (anObstacle.randomSpeed == true) {
        anObstacle.xSpeed = round(random (1, 8));
      }
    }
    if (increaseSpeed == true) { //speeds up timer every 9 seconds
      anObstacle.xSpeed += 1;
    }
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    p1.isMovingLeft = true;
  }
  if (key == 'd' || key == 'D') {
    p1.isMovingRight = true;
  }
  if ((key == 's' || key == 'S') && (skyMode == true)) {
    p1.isMovingDown = true;
  }
  if ((key == 'w' || key == 'W') && p1.isJumping == false && p1.isFalling == false) {
    if (skyMode == false) {
      p1.isJumping = true;
      p1.topJumpY = p1.y - p1.jumpHeight;
      if (unicornSound.isPlaying()) {
        unicornSound.pause();
      }
      boingSound.play();
      boingSound.play();
    } else {
      p1.isMovingUp = true;
    }
    println ("Sky Mode: ", skyMode);
    p1Animation.isAnimating = true;
  }
  if (key == ' ' && p1.isJumping == false && p1.isFalling == false) {
    if (skyMode == false) {
      p1.isJumping = true;
      p1.topJumpY = p1.y - p1.jumpHeight;
      if (unicornSound.isPlaying()) {
        unicornSound.pause();
      }
      boingSound.play();
      boingSound.play();
    } else {
      p1.isMovingUp = true;
    }
    println ("Sky Mode: ", skyMode);
    p1Animation.isAnimating = true;
    //    cloudAnimation.isAnimating = true;
  }
}

void keyReleased() {
  if (key == 'a' || key == 'A') {
    p1.isMovingLeft = false;
  }
  if (key == 'd' || key == 'D') {
    p1.isMovingRight = false;
  }
  if (skyMode == true) {
    if (key == 's' || key == 'S') {
      p1.isMovingDown = false;
    }
    if (key == 'w' || key == 'W') {
      p1.isMovingUp = false;
    }
  }
}

void startObstacles() {
  for (Obstacle anObstacle : obstacleList) {
    anObstacle.obstacleMovingLeft = true;
  }
}

void stopObstacles() {
  for (Obstacle anObstacle : obstacleList) {
    anObstacle.obstacleMovingLeft = false;
  }
}

void hitPage() {
  fill(255, 0, 0);
  text("You've been hit!", width/2, height/4);
  text("Click to play again", width/2, height/3);
}

void starshipHitPage() {
  fill(255, 0, 0);
  text("You've hit the Starship!", width/2, height/4);
  text("Try Again", width/2, height/3);
}

void gameOverPage() {
  fill(0);
  textSize(95);
  text("Game over", width/2, height/3 - 40);
  fill(0, 0, 255);
  textSize(50);
  text("Click to play again", width/2, height/3 + 40);
//click on the screen to play again
  if (mousePressed) {
    startTimer = new Timer(playTime);
    playerHit = false;
    setup();
    startObstacles ();
    unicornSound.loop ();
  }
}
