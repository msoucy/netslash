module netslash.core.actor;

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
		const char representation;

		// what help information should be displayed about this actor
		const string help;

		// the valid directions that the actor can move in
		enum DIRECTON = {
			NORTH, EAST, SOUTH, WEST };

	public:
		// Move in the specified direction
		void move( DIRECTION );

		// Move to the specified location on the board
		void teleport( int x, int y );

		void applyDamage( ulong damage );
}
