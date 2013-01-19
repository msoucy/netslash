module netslash.core.tile;

import netslash.core.actor;

/*
	Basic tile type
*/
class Tile {
	// Records its position
	int x,y;
	this(int _x=0, int _y=0) {
		x=_x;
		y=_y;
	}
	// Can we pass through the tile?
	bool passable() @property @safe nothrow const
	{
		return true;
	}
	// How does it look on the map
	char rep() @property @safe nothrow pure const
	{
		return ' ';
	}
	// What is displayed when help command is used
	string help() @property @safe nothrow const {
		return "  : An empty space";
	}

	bool putActor(Actor a) {
		if(this.actor is null) {
			this.actor = a;
			return true;
		}
		return false;
	}

	Actor actor = null;
}

class Wall : Tile {
	this(int _x=0, int _y=0) {
		super(_x, _y);
	}
	// Can we pass through the tile?
	override bool passable() @property @safe nothrow const
	{
		return false;
	}
	// How does it look on the map
	override char rep() @property @safe nothrow const
	{
		return '#';
	}
	// What is displayed when help command is used
	override string help() @property @safe nothrow const {
		return "# : A wall";
	}
}

class UpStairs : Tile {
	this(int _x=0, int _y=0) {
		super(_x, _y);
	}
	// Can we pass through the tile?
	override bool passable() @property @safe nothrow const
	{
		return true;
	}
	// How does it look on the map
	override char rep() @property @safe nothrow const
	{
		return '<';
	}
	// What is displayed when help command is used
	override string help() @property @safe nothrow const {
		return rep ~ " : A staircase up";
	}
}

class DownStairs : Tile {
	this(int _x=0, int _y=0) {
		super(_x, _y);
	}
	// Can we pass through the tile?
	override bool passable() @property @safe nothrow const
	{
		return true;
	}
	// How does it look on the map
	override char rep() @property @safe nothrow const
	{
		return '>';
	}
	// What is displayed when help command is used
	override string help() @property @safe nothrow const {
		return rep ~ " : A staircase up";
	}
}
