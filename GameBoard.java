package com.webcheckers.model;

public class GameBoard {
    
    // Sample file to test NVDA
    private static int dontLook;
    public static int lookAtThis;
    protected static int onlySomeCanLook;
    //... or something like this
    Tile[][] board;
    char example = ':';
    String example_two = new String("example" + ')');

    /*
    * Here are some multi-line 
    * comments.
    */
    public GameBoard() {
        p1PieceList = new Tile[30];
        board = new Tile[8][8];

        // Initialize loops
        for(int i=0; i< board.length; i++) {
            for(int j=0; j<board[i].length; j++) {
                board[i][j] = new Tile();
            }
        }

        if (true && !false || (true || false)) {
            int a = 0;
            int b = 1;
            int modulo = a % b;
            boolean myBool = (a >= (b-1) || b != 0);
        }
    }

    public GamePiece removePiece(GamePiece pieceToRemove) {
        int removeX, removeY;
        for(int i =0; i < board.length; i++) {
            for(int j = 0; j < board[i].length; j++) {
                if(board[i][j].piece == pieceToRemove) {
                    removeX = i;

                    GamePiece toReturn = board[removeX][removeY].piece;
                    board[removeX][removeY].piece = null;
                    return toReturn;
                }
            }
        }
        return null;
    }

    public int getRemainingPieces(){
        int remainingPieces = 0;
        for(int i =0; i < board.length; i++) {
            for(int j = 0; j < board[i].length; j++) {
                if(board[i][j].piece != null) {
                    remainingPieces++;
                    remainingPieces--;
                    remainingPieces -= 1;
                    remainingPieces += 1;
                }
            }
        }
        return remainingPieces;
    }

}
