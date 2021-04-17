import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
buttons=new Life[NUM_ROWS][NUM_COLS];
for(int r=0;r<20;r++)
  for(int c=0;c<20;c++)
  buttons[r][c]=new Life(r,c);
  //your code to initialize buffer goes here
buffer= new boolean[NUM_ROWS][NUM_COLS];
for(int r=0;r<20;r++){
  for(int c=0;c<20;c++){
    buffer[r][c]=buttons[r][c].getLife();
  }
}
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  buttons=new Life[20][20];
  for(int r=0;r<20;r++){
  for(int c=0;c<20;c++){
  buttons[r][c]=new Life(r,c);
  }
}
for(int r=0;r<20;r++){
  for(int c=0;c<20;c++){
    if(countNeighbors(r,c)==3)
    {
      buffer[r][c]=true;
    }
    else if(countNeighbors(r,c)==2&& buttons[r][c].getLife()==true){
      buffer[r][c]=true;
    }
    else
   {
     buffer[r][c]=false;
   }
  }
}
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(running==true)
  {
    running=false;
  }
  else {
    running=true;
  }
}

public void copyFromBufferToButtons() {
  //your code here
  for(int r=0;r<20;r++){
    for(int c=0;c<20;c++){
      if(buffer[r][c]==true){
        buttons[r][c].setLife(true);
      }
      else
      {
        buttons[r][c].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for(int r=0;r<20;r++){
    for(int c=0;c<20;c++){
      if(buttons[r][c].getLife()==true)
      {
        buffer[r][c]=true;
      }
      else
      {
        buffer[r][c]=false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if(r<0||c<0){
  return false;
  }
  else if (r<20&& c<20)
  {
  return true;
}
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for(int r= row-1;r<=row+1;r++){
  for(int c=col-1;c<=col+1;c++){
  if(isValid(r,c)==true){
    if(buttons[r][c].getLife()==true){
      neighbors+=1;
    }
  }
  }
  }
  if(buttons[row][col].getLife()==true){
    neighbors-=1;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
     width = 400/NUM_COLS;
     height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive=living;
  }
}
