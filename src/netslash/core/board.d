module netslash.core.board;

import std.json;
import std.algorithm;
import std.array;
import std.stdio;

import netslash.core.tile;

class Board {
	enum MAX_ROWS = 50;
	enum MAX_COLS = 15;
	Tile[MAX_ROWS][MAX_COLS] board;
	alias this = board;
	int startRow, startCol;

	string serialize() {
		JSONValue b;
		b.type = JSON_TYPE.OBJECT;
		b.object["rows"] = JSONValue();
		b.object["rows"].type = JSON_TYPE.UINTEGER;
		b.object["rows"].uinteger = MAX_ROWS;
		b.object["cols"] = JSONValue();
		b.object["cols"].type = JSON_TYPE.UINTEGER;
		b.object["cols"].uinteger = MAX_COLS;
		b.object["board"] = JSONValue();
		b.object["board"].type = JSON_TYPE.STRING;
		Appender!(char[]) appr;
		foreach(row;board) {
			foreach(tile; row) {
				appr.put(tile.rep);
			}
		}
		b.object["board"].str = appr.data.idup;
		return toJSON(&b);
	}

	void print(File f) {
		f.writefln(print());
	}
	string print() {
		string s = "";
		for(int i = 0; i < board.length; ++i) {
			for(int n = 0; n < board[i].length; ++n) {
				s+=board[i][n].rep();
			}
			s+='\n';
		}
	}
}