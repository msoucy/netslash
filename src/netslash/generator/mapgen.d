import std.stdio;
//import netslash.core.actor;
import netslash.core.tile;
import netslash.core.board;

Board genTestMap() {
    Board b = new Board();
    b.board = new Tile[b.MAX_ROWS][b.MAX_COLS];
    for(int i = 0; i < b.board.length; ++i) {
        for(int n = 0; n < b.board[i].length; ++n) {
            if(i == 0 || n == 0 || i == b.board.length - 1 || n == b.board[i].length - 1) {
                b.board[i][n] = new Wall();
            }
            else {
                b.board[i][n] = new Tile();
            }
            
            b.board[i][n].x = i;
            b.board[i][n].y = n;
        }
    }
    return b;
}

int main(char[][] argv) {
    genTestMap().print();
    return 1;
}