PImage bg, gameover, restartHovered, restartNormal, startHovered, startNormal, title, cabbage, groundhogDown, groundhogIdle, groundhogLeft, groundhogRight, life, robot, soil, solider;
final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2, GAME_WIN = 3;
int groundhogPosX = 4 * 80, groundhogPosY = 80, groundhogMoveX = 0, groundhogMoveY = 0, groundhogFrame = 15, groundhogFrameCount = 0, lifePoint = 2, soliderSpeed = 2, soldierPosX = 0, soldierPosY = (int(random(2, 6))) * 80, cabbagePosX = (int(random(0, 8))) * 80, cabbagePosY = (int(random(2, 6))) * 80, gameState = GAME_START;
boolean groundhogMove = false;
void setup() {
  size(640, 480, P2D);
}
void draw() {
  noStroke();
  switch (gameState) {
    case GAME_START :
      background(loadImage("img/title.jpg"));
      if (mouseX > 248 && mouseX < 392 && mouseY > 360 && mouseY < 420 ) {
        image(loadImage("img/startHovered.png"), 248, 360);
        if ( mousePressed) {
          gameState = GAME_RUN;
        }
      } else {
        image(loadImage("img/startNormal.png"), 248, 360);
      }
      break;
    case GAME_RUN :
      background(loadImage("img/bg.jpg"));
      image(loadImage("img/soil.png"), 0, 80 * 2);
      fill(255, 255, 0);
      ellipse(590, 50, 130, 130);
      fill(253, 184, 19);
      ellipse(590, 50, 120, 120);
      fill(124, 204, 25);
      rect(0, 2 * 80 - 15, 640, 15);
      image(loadImage("img/soldier.png"), soldierPosX, soldierPosY);
      soldierPosX += soliderSpeed;
      if (soldierPosX >= 640) {
        soldierPosY = (int(random(2, 6))) * 80;
        soldierPosX = -80;
      }
      for (int i = 0; i < lifePoint; i++) {
        image(loadImage("img/life.png"), 10 + i * (70), 10);
      }
      image(loadImage("img/cabbage.png"), cabbagePosX, cabbagePosY);
      if (groundhogMove) {
        switch (groundhogMoveX) {
          case 1:
            groundhogPosX += 80 / groundhogFrame;
            image(loadImage("img/groundhogRight.png"), groundhogPosX, groundhogPosY);
            break;
          case -1:
            groundhogPosX -= 80 / groundhogFrame;
            image(loadImage("img/groundhogLeft.png"), groundhogPosX, groundhogPosY);
            break;
        }
        switch (groundhogMoveY) {
          case 1:
            groundhogPosY -= 80 / groundhogFrame;
            image(loadImage("img/groundhogDown.png"), groundhogPosX, groundhogPosY);
            break;
          case -1:
            groundhogPosY += 80 / groundhogFrame;
            image(loadImage("img/groundhogIdle.png"), groundhogPosX, groundhogPosY);
            break;
        }
        if (groundhogFrameCount > 15) {
          groundhogMoveX = groundhogMoveY = groundhogFrameCount = 0;
          groundhogMove = false;
        }
        groundhogFrameCount++;
      } else {
        switch (keyCode) {
          case UP:
            if (groundhogPosY > 160 && keyPressed) {
              groundhogMove = true;
              groundhogMoveY = 1;
            }
            break;
          case DOWN:
            if (groundhogPosY < 400 && keyPressed) {
              groundhogMove = true;
              groundhogMoveY = -1;
            }
            break;
          case RIGHT:
            if (groundhogPosX < 560 && keyPressed) {
              groundhogMove = true;
              groundhogMoveX = 1;
            }
            break;
          case LEFT:
            if (groundhogPosX > 0 && keyPressed) {
              groundhogMove = true;
              groundhogMoveX = -1;
            }
            break;
        }
        image(loadImage("img/groundhogIdle.png"), groundhogPosX, groundhogPosY);
      }
      if ((groundhogPosX < cabbagePosX + 80 && groundhogPosX + 80 > cabbagePosX) && (groundhogPosY < cabbagePosY + 80 && groundhogPosY + 80 > cabbagePosY)) {
        if (lifePoint < 5) {
          lifePoint++;
        }
        cabbagePosX = (int(random(0, 8))) * 80;
        cabbagePosY = (int(random(2, 6))) * 80;
      }
      if ((groundhogPosX < soldierPosX + 80 && groundhogPosX + 80 > soldierPosX) && (groundhogPosY < soldierPosY + 80 && groundhogPosY + 80 > soldierPosY)) {
        lifePoint -= 1;
        groundhogMoveX = groundhogMoveY = groundhogFrameCount = 0;
        groundhogMove = false;
        groundhogPosX = 320;
        groundhogPosY = 80;
      }
      if (lifePoint == 0) {
        gameState = GAME_OVER;
      }
      break;
    case GAME_OVER :
      background(loadImage("img/gameover.jpg"));
      if (mouseX > 248 && mouseX < 392 && mouseY > 360 && mouseY < 420) {
        image(loadImage("img/restartHovered.png"), 248, 360);
        if (mousePressed) {
          gameState = GAME_RUN;
          lifePoint = 2;
          soldierPosX = -80;
          soldierPosY = (int(random(2, 6))) * 80;
          groundhogMoveX = groundhogMoveY = groundhogFrameCount = 0;
          groundhogMove = false;
          groundhogPosX = 320;
          groundhogPosY = 80;
        }
      } else {
        image(loadImage("img/restartNormal.png"), 248, 360);
      }
      break;
    case GAME_WIN :
      break;
  }
}
