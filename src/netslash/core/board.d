module netslash.core.board;

import netslash.core.tile;

class Board {
	enum MAX_ROWS = 50;
	enum MAX_COLS = 15;
	Tile[MAX_ROWS][MAX_COLS] board;
	alias this = board;
}