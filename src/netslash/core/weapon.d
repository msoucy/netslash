module netslash.core.weapon;


import netslash.core.item;
import netslash.core.actor;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : Item
{
	public:
		const int BASE_DAMAGE() @property {return 0;}
		const uint weight() @property {return 0;}
		const int PRECISION() @property {return 0;}

	private:
		// if this weapon is two handed then this should be true otherwise
		// this should be false
		bool twoHanded;

	public:
		bool getTwoHanded()
		{
			return twoHanded;
		}
}
