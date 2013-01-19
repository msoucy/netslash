module netslash.core.npc;

/**
 * Allows for grouping of actors based off of if they are computer controlled
 * or not
 **/
interface Npc
{
	public:
		void act();

		void applyDamage();
}
