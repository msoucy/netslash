module netslash.client.tile;

import netslash.client.actor;

/*
	Basic tile type
*/
class Tile {
	// Records its position
	int x,y;
	// Can we pass through the tile?
	bool passable() @property @safe nothrow const
	{
		return true;
	}
	// How does it look on the map
	char rep() @property @safe nothrow const
	{
		return ' ';
	}
	// What is displayed when help command is used
	string help() @property @safe nothrow const {
		return "  : An empty space";
	}

	Actor actor;
}
