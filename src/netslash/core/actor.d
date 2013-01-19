module netslash.core.actor;

import netslash.core.consumable;

/*
* Interface for Actors
*/
abstract class Actor
{
	public:
		// indicates if the Actor can be moved by another actor
		const bool moveable;

		// the Actor's position
		int x,y;

		// what character should be displayed for this actor
		const char rep() @property {return ' ';}

		// what help information should be displayed about this actor
		const string help;

		// the valid directions that the actor can move in
		enum DIRECTION {
			NORTH, EAST, SOUTH, WEST
		};

	public:
		// Move in the specified direction
		abstract void move( DIRECTION );

		// Move to the specified location on the board
		void teleport( int x, int y );

		void applyDamage( ulong damage );

		void consume(Consumable c) {
			c.consume(this);
		}
}
