module netslash.client.client;

import netslash.core.board;
import netslash.core.tile;
import std.random;
import std.stdio;
import metus.dncurses.dncurses;

void main() {
	Board b = new Board();
    //Gen upStaris
    int a = cast(int)uniform(1, b.length - 1);
    int aa = cast(int)uniform(1, b[0].length - 1);

    debug {writefln("den up"); }
    b.board[a][aa] = new UpStairs();
    b.board[a][aa].x = a;
    b.board[a][aa].y = aa;

    debug {writefln("gen downs");}
    //Gen downstairs
    a = cast(int)uniform(1, b.length-1);
    aa = cast(int)uniform(1, b[0].length-1);
    b.board[a][aa] = new DownStairs();
    b.board[a][aa].x = a;
    b.board[a][aa].y = aa;
    Board.deserialize(b.serialize()).print().writeln();
}