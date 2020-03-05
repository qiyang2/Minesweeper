import de.bezier.guido.*;
public final static int NUM_ROWS = 18;
public final static int NUM_COLS = 18;
public final static int NUM_MINES = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    mines = new ArrayList <MSButton>();
    
    setMines();
}
public void setMines()
{
    //your code
    int row;
    int col;
    
    for(int i = 0; i< NUM_MINES; i++){
        row = (int)(Math.random() * NUM_ROWS);
        col = (int)(Math.random() * NUM_COLS);
        if(!mines.contains(buttons[row][col])){
            mines.add(buttons[row][col]);
        }
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int i = 0; i< mines.size(); i++){
        if(mines.get(i).flagged == false){
            return false;
        }
    }return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int i = 0; i< mines.size(); i++){
        mines.get(i).clicked= true;
    }
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(!mines.contains(buttons[r][c])){
                buttons[r][c].clicked = true;
            }
        }
    }

    buttons[NUM_ROWS/2][NUM_COLS/2 -3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2 -2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2 -1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2 +1].setLabel("L");
    buttons[NUM_ROWS/2][NUM_COLS/2 +2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2 +3].setLabel("S");
    buttons[NUM_ROWS/2][NUM_COLS/2 +4].setLabel("E");
    
}
public void displayWinningMessage()
{
    //your code here

    buttons[NUM_ROWS/2][NUM_COLS/2 -3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2 -2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2 -1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2 +1].setLabel("W");
    buttons[NUM_ROWS/2][NUM_COLS/2 +2].setLabel("I");
    buttons[NUM_ROWS/2][NUM_COLS/2 +3].setLabel("N");
    
    
}
public boolean isValid(int r, int c)
{
    //your code here
    if(r >= NUM_ROWS || r < 0 || c >= NUM_COLS || c < 0){
        return false;
    }
    return true;
    
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for(int r = row-1; r<= row+1; r++){
        for(int c = col-1; c<= col+1; c++){
            if(isValid(r,c) && mines.contains(buttons[r][c])){
                numMines++;
            }
        }
    }

    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
            if(flagged == true){
                flagged = false;
                clicked = false;
            }else if(flagged == false){
                flagged = true;
            }
        }

        else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(this.myRow,this.myCol) > 0){
            setLabel(countMines(this.myRow,this.myCol));
        }else for(int r = myRow-1; r<= myRow+1; r++){
                for(int c = myCol-1; c<= myCol+1; c++){
                    if(isValid(r,c) && buttons[r][c].clicked == false && !(r == myRow && c == myCol)){
                        buttons[r][c].mousePressed();
                    }
                }
            }
            
        }

    public void draw () 
    {

        if (flagged)
            fill(70,120,50);
        else if( clicked && mines.contains(this) ) 
            fill(230,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
       
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }

}
