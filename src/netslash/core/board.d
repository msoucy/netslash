module netslash.core.board;

import std.algorithm;
import std.array;
import std.json;
import std.stdio;
import std.typetuple;

import netslash.core.tile;

class Board {
	enum MAX_ROWS = 15;
	enum MAX_COLS = 50;
	Tile[MAX_COLS][MAX_ROWS] board;
	alias this = board;
	int startRow, startCol;

	this() {
		this.board = new Tile[MAX_COLS][MAX_ROWS];
		for(int i = 0; i < board.length; ++i) {
			for(int n = 0; n < board[i].length; ++n) {
				if(i == 0 || n == 0 || i == board.length - 1 || n == board[i].length - 1) {
					board[i][n] = new Wall();
				}
				else {
					board[i][n] = new Tile();
				}
				debug{ writefln("Put tile at %d, %d", i, n);}
				board[i][n].x = i;
				board[i][n].y = n;
				debug { write(board[i][n]); }
			}
			debug { writefln(""); }
		}

	}

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

	static Board deserialize(string src) {
		Board b = new Board();
		JSONValue json = src.parseJSON();
		debug {
			if(JSONValue* rows = "rows" in json.object) {
				assert(rows.type == JSON_TYPE.INTEGER && rows.integer == MAX_ROWS);
			} else {
				assert(0);
			}
			if(JSONValue* cols = "cols" in json.object) {
				assert(cols.type == JSON_TYPE.INTEGER && cols.integer == MAX_COLS);
			} else {
				assert(0);
			}
		}
		JSONValue* data = "board" in json.object;
		assert(data.type == JSON_TYPE.STRING && data.str.length == MAX_ROWS*MAX_COLS);
		
		size_t r = 0;
		size_t c = 0;
		foreach(char ch; data.str) {
			foreach(T; TypeTuple!(Tile, Wall, UpStairs, DownStairs)) {
				Tile tile = new T();
				if(tile.rep == ch) {
					b.board[r][c] = tile;
					break;
				}
			}
			c++;
			if(c==MAX_COLS) {
				c=0;
				r++;
			}
		}
		return b;
	}

	void print(File f) {
		f.writefln(print());
	}

	string print() {
		debug {writefln("printing board"); }
		string s = "";
		debug {writefln("x: %d, y: %d", this.board.length, this.board[0].length);}
		for(int i = 0; i < MAX_ROWS; ++i) {
			for(int n = 0; n < MAX_COLS; ++n) {

				s ~= board[i][n].rep();
			}
			//debug{writefln("Line %d: %s\n", i, s);}
			s ~= '\n';
		}
		return s;
	}
}
