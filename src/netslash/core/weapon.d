module netslash.core.weapon;


import netslash.core.item;
import netslash.core.actor;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : Item
{
	public:
		const uint base_damage() @property {return 0;}
		const uint weight() @property {return 0;}
		const uint precision() @property {return 0;}

	private:
		// if this weapon is two handed then this should be true otherwise
		// this should be false
		bool twoHanded;

	public:
		bool getTwoHanded()
		{
			return twoHanded;
		}

		char getCharacter();
}
