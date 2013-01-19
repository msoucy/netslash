module netslash.core.stairs;

import netslash.core.tile;

class UpStairs : Tile {
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
