import processing.serial.*;

Serial myPort;  

ArrayList ellipseList;
Ellipse head;
int SEGMENT_SIZE = 20;
int dir;
int prevPosX, prevPosY;
PFont f;
String mesaj="";
boolean ok=false;
Ellipse food;


void setup()
{
 size(1274, 798);
 String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 9600);
 
 
 ellipseList = new ArrayList();
 head = new Ellipse(140, 140);
 ellipseList.add(head);
 dir=2;
 // Start with head and small body
 ellipseList.add(new Ellipse(width/2 - 2 * SEGMENT_SIZE, height/2));
 addFood();

 //speed of game
 frameRate(12);
}
void draw()
{
 fill(0);
 background(255,255,255);
 text(mesaj,width/2-100,height/2);
 

 if(ok)
 {
   food.createEllipse();
   tryToEatAndMove(ellipseList.size());
 }
}

boolean tryToEatAndMove(int p)
{
 int x = head.getX();
 int y = head.getY();// collison variable 
int sl = ellipseList.size();

   Ellipse e1 = (Ellipse) ellipseList.get(ellipseList.size() - 1);
   

if ( sl>3){

  Ellipse e3 = (Ellipse) ellipseList.get(ellipseList.size() - 3);
}


 Ellipse e2 = (Ellipse) ellipseList.get(ellipseList.size() - 2);

//      Ellipse e4 = (Ellipse) ellipseList.get(ellipseList.size() - 4);
   
   println("tail:" + e1.getX() + " " + e2.getX());
  
   //for ( int i = sl; i=1; i= sl-1) {
     //print ( "i: " + i);
   //}
   
   int tpx1 = e1.getX();
   int tpy1 = e1.getY();
   
   int tpx2 = e2.getX();
   int tpy2 = e2.getY();
   
  // int tpx3 = e3.getX();
  // int tpy3 = e3.getY();
   
//   int tpx4 = e4.getX();
//   int tpy4 = e4.getY();
   
   if (dist(x, y, tpx1, tpy1) < 14){
     print("dead a ");
     //exit();
 }
   if (sl>1){
   if (dist(x, y, tpx2, tpy2) < 14){
     print("dead b ");

     //exit();
   }  
   }
 //  if (dist(x, y, tpx3, tpy3) < 14){
  //   print("dead");
  //   exit();
 //}
 
 if (dist(x, y, food.getX(), food.getY()) < 14)
 {
   // Move the body
   move();
   
   //colision with yourself
   
   
   
   // Get last two segments
 //  Ellipse e1 = (Ellipse) ellipseList.get(ellipseList.size() - 1);
 //  Ellipse e2 = (Ellipse) ellipseList.get(ellipseList.size() - 2);
//     Ellipse e3 = (Ellipse) ellipseList.get(ellipseList.size() - 3);
//      Ellipse e4 = (Ellipse) ellipseList.get(ellipseList.size() - 4);
   
   println("tail:" + e1.getX() + " " + e2.getX());
 
   
   
   
   int dX = e1.getX() - e2.getX();
   int dY = e1.getY() - e2.getY();
   // Add another segment at the end
   ellipseList.add(new Ellipse(e1.getX() + dX, e1.getY() + dY));
   // Add food to replace the one being eat
   addFood();
   println("Length: " + ellipseList.size());
   
   return true;
 }
 // Not on food, just move
 move();
 return false;
}
void addFood()
{
 int rx = int (random(1, 56));
 int ry = int (random(1, 42));
 food = new Ellipse(rx*14, ry*14,14);// gs yay!
//food=new Ellipse(280,280 ,14);
   print(food.getX() + " ");
     print(food.getY() + " ");
}
void move()
{
 prevPosX = head.getX();
 prevPosY = head.getY();
 switch(dir)
 {
   case 0:
head.moveUp();
break;
   case 1:
head.moveDown();
break;
   case 2:
head.moveRight();
break;
   case 3:
head.moveLeft();
break;
 }
 followHead();
}

void followHead()
{
 fill(0);
 head.createEllipse();
 fill(0);
 for (int i = 1; i < ellipseList.size(); i++)
 {
    Ellipse e = (Ellipse) ellipseList.get(i);
    int ppX = e.getX();
    int ppY = e.getY();
    // Move the segment where the previous one was
    e.x = prevPosX; e.y = prevPosY; // Need Ellipse.setX and setY...
    prevPosX = ppX;
    prevPosY = ppY;
    e.createEllipse();
 }
}

void mousePressed()
{
 mesaj="";
 ok=true;
 dir=0;
}

void keyPressed()
{
 if(key==CODED)
 {
   if(keyCode==UP)
   {
dir=0;
   }
   if(keyCode==DOWN)
   {
dir=1;
   }
   if(keyCode==RIGHT)
   {
dir=2;
   }
   if(keyCode==LEFT)
   {
dir=3;
   }
 }
}

void serialEvent(Serial myPort) {
 // read a byte from the serial port:
 int inByte = myPort.read();
  if (inByte == '1') { 
    dir=0;
  }
     myPort.clear();  
      if (inByte == '2') { 
    dir=3;
  }
  if (inByte == '3') { 
    dir=2;
  }
  if (inByte == '4') { 
    dir=1;
  }
}


class Ellipse
{
 int x; int y; int l; 
 Ellipse(int _x, int _y)
 {
   // size of snake 
   x=_x; y=_y; l=14;
 }
 Ellipse(int _x, int _y, int _l)
 {
   x=_x; y=_y; l=_l;
 }
 void createEllipse()
 {
   rect(x,y,l,l);
 }
 void createEllipse(int a,int b)
 {
   ellipse(a,b,l,l);
 }
 
 void moveUp()
 {
   y-=l;
   if(y<0) y=height;
 }
 void moveDown()
 {
   y+=l;
   if(y>height) y=0;
 }
 void moveRight()
 {
   x+=l;
   if(x>width) x=0;
 }
 void moveLeft()
 {
   x-=l;
   if(x<0) x=width;
 }
 int getX()
 {
   return x;
 }
 int getY()
 {
   return y;
 }
 int getL()
 {
   return l;
 }
}
