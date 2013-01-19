module netslash.core.weapon;


import netslash.core.item;
import netslash.core.actor;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : item
{
	public:
		const int BASE_DAMAGE;
		const int PRECISION;

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
