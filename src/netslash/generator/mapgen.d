module netslash.generator.mapgen;

import std.stdio;
//import netslash.core.actor;
import netslash.core.tile;
import netslash.core.board;
import std.conv;
import std.string;
import std.random;

Board genTestMap() {
    debug {writefln("generating board"); }
    Board b = new Board();
    //Gen upStaris
    int a = cast(int)uniform(1, b.length - 1);
    int aa = cast(int)uniform(1, b[0].length - 1);

    debug {writefln("den up"); }
    b.board[a][aa] = new UpStairs(a, aa);

    debug {writefln("gen downs");}
    //Gen downstairs
    a = cast(int)uniform(1, b.length-1);
    aa = cast(int)uniform(1, b[0].length-1);
    b.board[a][aa] = new DownStairs(a, aa);
    b.print();
    return b;
}