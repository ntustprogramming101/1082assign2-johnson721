PImage bg, life, soil, soldier, cabbage, gameover, groundhogDown_Image, groundhogIdle, groundhogLeft_Image, groundhogRight_Image, restartHovered, restartNormal, startHovered, startNormal, title;
final int grid = 80,soldierSize = 80,offsetHeight = 37,offsetWidth = 25,GAME_START = 0,GAME_RUN = 1,GAME_LOSE = 2,soldier_H = 80,soldier_W =80,cabbage_H = 80,cabbage_W =80,buttonX = 248,buttonY = 360,button_W = 144,button_H = 60,buttonUp = buttonY,buttonDown = buttonY+button_H,buttonLeft = buttonX,buttonRight = buttonX+button_W,groundhog_W = 80,groundhog_H = 80;
final float grassHeight = 15,lifeGap = 20,lifePosition = 10,lifeSize = 50,sun = 50,sunDiameter = 120;
int lifePoint = 2,gameState = 0,soldierX = -soldierSize,soldierY = floor(random(2,6))*grid,cabbageX  = floor(random(2,8))*grid,cabbageY  = floor(random(2,6))*grid,cabbageQuantity = 1,nowTime,groundhogX = grid*4 , groundhogY = grid;
float soldierSpeed = 3;
boolean upPressed,downPressed,leftPressed,rightPressed ;
void setup() {
  size(640, 480, P2D);
  imageMode(CORNER);
  frameRate(60);
}
void draw() {
  switch (gameState){
    case GAME_START:
      image(loadImage("img/title.jpg"), 0, 0, width, height);
      image(loadImage("img/startNormal.png"), buttonX, buttonY);
      if(mouseX >buttonLeft && mouseX <buttonRight && mouseY >buttonUp && mouseY <buttonDown) {      
          image(loadImage("img/startHovered.png"), buttonX, buttonY);
          if(mousePressed == true) { 
            gameState = GAME_RUN;
          }                        
       }
    break;
    case GAME_RUN:
      image(loadImage("img/bg.jpg"), 0, 0,width, height);
      if(lifePoint >= 1){
      image(loadImage("img/life.png"), lifePosition, lifePosition);}
      if(lifePoint >= 2){
      image(loadImage("img/life.png"), lifePosition+lifeSize+lifeGap, lifePosition);}
      if(lifePoint >= 3){
      image(loadImage("img/life.png"), lifePosition+lifeSize*2+lifeGap*2, lifePosition);}
      ellipseMode(CENTER);
      fill(253,184,19);
      strokeWeight(5);
      stroke(255,255,0);
      ellipse(width-sun,sun,sunDiameter,sunDiameter);
      noStroke();
      fill(124,204,25);
      rect(0,grid*2-grassHeight,width,grassHeight);
      image(loadImage("img/soil.png"), 0, grid*2);
      int groundhogDown = groundhogY+groundhog_H,groundhogLeft = groundhogX,groundhogRight = groundhogX+groundhog_W;
      if(leftPressed){
        image(loadImage("img/groundhogLeft.png"), groundhogX, groundhogY);
      }
      else if(rightPressed){
        image(loadImage("img/groundhogRight.png"), groundhogX, groundhogY);
      }else{
        image(loadImage("img/groundhogIdle.png"), groundhogX, groundhogY);
      }
      if(groundhogLeft <0){ groundhogX = 0;}
      if(groundhogRight > width){ groundhogX = width-groundhog_W;}
      if(groundhogDown > height){ groundhogY = height-groundhog_H;}
      int soldierUp = soldierY,soldierDown = soldierY+soldier_H,soldierLeft = soldierX,soldierRight = soldierX+soldier_W;
        soldierX += soldierSpeed;
        frameRate(15);
        if(soldierX>width){
          soldierX = -soldierSize;
        }
        image(loadImage("img/soldier.png"),soldierX,soldierY);
        if(groundhogY == soldierY || groundhogDown >soldierUp && groundhogDown <soldierDown){
            if( groundhogLeft <soldierRight && groundhogLeft >soldierLeft || 
                groundhogRight >soldierLeft && groundhogRight <soldierRight ||
                groundhogDown >soldierUp && groundhogDown <soldierDown){
               lifePoint -=1;
               groundhogX = grid*4;
               groundhogY = grid;
            }
         }
        if(cabbageQuantity>0){
            image(loadImage("img/cabbage.png"),cabbageX,cabbageY);
          if(groundhogX==cabbageX && groundhogY==cabbageY){
              lifePoint +=1;
              cabbageQuantity -= 1;
              }
        }
        if(lifePoint == 0){
          gameState = GAME_LOSE;
        } 
    break;
    case GAME_LOSE:
      image(loadImage("img/gameover.jpg"), 0, 0, width, height);
      image(loadImage("img/restartNormal.png"), buttonX, buttonY);
      if(mouseX >buttonLeft && mouseX <buttonRight && mouseY >buttonUp && mouseY <buttonDown) {      
          image(loadImage("img/startHovered.png"), buttonX, buttonY);
          if(mousePressed == true) { 
            lifePoint = 2;
            cabbageQuantity = 1;
            soldierX = -soldierSize;
            soldierY = cabbageY = floor(random(2,6))*grid;
            cabbageX  = floor(random(2,8))*grid;
            gameState = GAME_RUN;
          }                        
       }
    break;
  }
}
void keyPressed(){    
  if(key==CODED && gameState == GAME_RUN){
    switch(keyCode){          
      case DOWN:
        downPressed = true;
        groundhogY += grid;        
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
void keyReleased(){
   if(key==CODED){    
    switch(keyCode){
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
