// snake variables
int snakesize=1; //size of the snake
int MAXLENGTH=10;
int headx[]=new int[MAXLENGTH]; //xlocation
int heady[]=new int[MAXLENGTH]; //ylocation
int i;

//FOOD VARIABLES
int yumx=(round(random(49))+1)*10;
int yumy=(round(random(49))+1)*10;

  //SPEED
int speed;         
int xspeed,yspeed; 

void setup (){
  
  size (500,500);
  
  headx[0] = 250;
  heady[0] = 250;
  // SNAKE HEAD BEGINS UNMOVING.
  speed=1;           
  xspeed=0;     
  yspeed=0;
}

void draw (){
  background (0);
  
  fill(255,0,0);
  ellipseMode(CENTER);
  ellipse(yumx,yumy,15,15);
  
   for(int i =0; i < snakesize; i++){
   //tail
   fill(200, 20, 200);
   rectMode(CENTER);
   rect(headx[i],heady[i],20,20);

   headx[i]=headx[i]+xspeed;
   heady[i]=heady[i]+yspeed;
   }
// FOOD
 if(snakesize<headx.length)
 {
 if (headx[0]>=yumx-20 && headx[0]<=yumx+20 && heady[0]>=yumy-20 && heady[0]<yumy+20)
 {
    yumx=(round(random(49))+1)*10;
    yumy=(round(random(49))+1)*10;
  
  snakesize++;
  
  if (i!=1)
  {
  headx[snakesize -1] = headx[snakesize - 2] - 0;
  heady[snakesize -1] = heady[snakesize - 2] - 20;
  }
  
 }
 }
}


void keyPressed()
{
   // ARROW KEYS OR LETTER KEYS PRESSED.
   // RIGHT & LEFT HAND CONTROLS.
  
  if(keyCode==UP || key == 'w')
      { 
        xspeed=0;
        yspeed=-2;
      }
  else if(keyCode==DOWN || key =='s')
       { 
         xspeed=0;
         yspeed=2;
       }

  else if(keyCode==LEFT || key=='a')
        { 
          xspeed=-2;
          yspeed=0;
        }
  else if(keyCode==RIGHT || key =='d')
        { 
          xspeed=2;
          yspeed=0;
        }    
}
