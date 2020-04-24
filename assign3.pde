final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int soilSpacing=80;
final int grid = 80,groundhog_W = 80, groundhog_H = 80;;
int soil0X, soil0Y, soil1X, soil1Y, soil2X, soil2Y, soil3X, soil3Y, soil4X, soil4Y, soil5X, soil5Y;
int groundhogX=320;
int groundhogY=80;
int lifeY =10;
int frame=0;
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage soil0, soil1, soil2, soil3, soil4, soil5;
PImage stone1, stone2;
PImage life;
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;
boolean upPressed, downPressed, leftPressed, rightPressed ;
void setup() {
  size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil8x24 = loadImage("img/soil8x24.png");
  soil0=loadImage("img/soil0.png");
  soil1=loadImage("img/soil1.png");
  soil2=loadImage("img/soil2.png");
  soil3=loadImage("img/soil3.png");
  soil4=loadImage("img/soil4.png");
  soil5=loadImage("img/soil5.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
  life=loadImage("img/life.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
}
void draw() {
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  switch (gameState) {
  case GAME_START: 
    image(title,0,0);
    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {
      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {
      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  case GAME_RUN:
    image(bg, 0, 0);
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);
    for (int i=0; i< 8; i++) {
      for (int j=0; j<4; j++) {
        soil0X=i*soilSpacing;
        soil0Y=160+j*soilSpacing;
        image(soil0, soil0X, soil0Y);
        soil1X=i*soilSpacing;
        soil1Y=160+320+j*soilSpacing;
        image(soil1, soil1X, soil1Y);
        soil2X=i*soilSpacing;
        soil2Y=160+320*2+j*soilSpacing;
        image(soil2, soil2X, soil2Y);
        soil3X=i*soilSpacing;
        soil3Y=160+320*3+j*soilSpacing;
        image(soil3, soil3X, soil3Y);
        soil4X=i*soilSpacing;
        soil4Y=160+320*4+j*soilSpacing;
        image(soil4, soil4X, soil4Y);
        soil5X=i*soilSpacing;
        soil5Y=160+320*5+j*soilSpacing;
        image(soil5, soil5X, soil5Y);
      }
    } 
    for (int i=0; i<8; i++) {
      int stoneX =i*soilSpacing;
      int stoneY =160+i*soilSpacing;
      image (stone1, stoneX, stoneY);
    }
    for (int i=0; i<=9; i++) {
      for (int j=10; j<18; j++) {
        if (i%4 == 1 || i%4 ==2) {
          if (j%4 == 1 || j%4 ==2) {
            image(stone1, soilSpacing*i, soilSpacing*j);
          } else if (j%4 == 0 || j%4 == 3) {
            image(stone1, soilSpacing*i-soilSpacing*2, soilSpacing*j);
          }
        }
      }
    }
    for (int i=0; i<=9; i++) {
      for (int j=18; j<26; j++) {
        if (i%3 == 1 || i%3 == 2) {
          if (j%3 == 0) {
            image(stone1, soilSpacing*i, soilSpacing*j);
          } else if (j%3 == 1) {
            image(stone1, soilSpacing*i-soilSpacing, soilSpacing*j);
          } else {
            image(stone1, soilSpacing*i-soilSpacing*2, soilSpacing*j);
          }
        }
        if (i%3 == 2) {
          if (j%3 ==0) {
            image(stone2, soilSpacing*i, soilSpacing*j);
          } else if (j%3 ==1) {
            image(stone2, soilSpacing*i-soilSpacing, soilSpacing*j);
          } else {
            image(stone2, soilSpacing*i-soilSpacing*2, soilSpacing*j);
          }
        }
      }
    }
    image(life, 10, lifeY);
    image(life, 80, lifeY);
    image(life, 150, lifeY);
    int groundhogDown = groundhogY+groundhog_H, groundhogLeft = groundhogX, groundhogRight = groundhogX+groundhog_W;
    if(downPressed){
      image(loadImage("img/groundhogDown.png"), groundhogX, groundhogY);
    }else if (leftPressed) {
      image(loadImage("img/groundhogLeft.png"), groundhogX, groundhogY);
    } else if (rightPressed) {
      image(loadImage("img/groundhogRight.png"), groundhogX, groundhogY);
    } else {
      image(loadImage("img/groundhogIdle.png"), groundhogX, groundhogY);
    }
    if (groundhogLeft <0) { 
      groundhogX = 0;
    }
    if (groundhogRight > width) { 
      groundhogX = width-groundhog_W;
    }
    if (groundhogDown > 2240) { 
      groundhogY = height-groundhog_H;
    }
    break;
  case GAME_OVER: 
    image(gameover, 0, 0);
    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {
      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {
      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }
  if (debugMode) {
    popMatrix();
  }
}
void keyPressed() {
  if (key==CODED && gameState == GAME_RUN) {
  switch(keyCode) {
  case UP:
    debugMode = true;
    upPressed = true;
    cameraOffsetY += grid;
    groundhogY -= grid;
    lifeY -= grid;
    break;
  case DOWN:
    debugMode = true;
    downPressed = true;
    cameraOffsetY -= grid;
    groundhogY += grid;
    lifeY += grid;
    break;
  case LEFT:
  leftPressed = true;
    groundhogX -= grid;
    break;
  case RIGHT:
  rightPressed = true;
    groundhogX += grid;
    break;
  }
}
}
void keyReleased() {
  if (key==CODED) {    
    switch(keyCode) {
      case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
