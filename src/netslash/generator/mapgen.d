module netslash.generator.mapgen;

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