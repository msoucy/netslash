module netslash.core.weapon;

import netslash.core.item;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : item
{
	public:
		const int BASE_DAMAGE;

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
