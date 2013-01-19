import std.stdio;
//import netslash.core.actor;
import netslash.core.tile;
import netslash.core.board;
import std.conv;
import std.string;
import std.random;
import netslash.core.stairs;

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
    //Gen upStaris
    int a = cast(int)uniform(1, b.length - 1);
    int aa = cast(int)uniform(1, b[0].length - 1);
    b.board[a][aa] = new UpStairs();
    b.board[a][aa].x = a;
    b.board[a][aa].y = aa;


    //Gen downstairs
    a = cast(int)uniform(1, b.length-1);
    aa = cast(int)uniform(1, b[0].length-1);
    b.board[a][aa] = new DownStairs();
    b.board[a][aa].x = a;
    b.board[a][aa].y = aa;

    return b;
}

int main(char[][] argv) {
    writeln("Generating map...");
    auto f = File("Maps/map.nsmap", "w");
    genTestMap().print(f);
    return 0;
}