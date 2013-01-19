module netslash.core.weapon;


import netslash.core.item;
import netslash.core.actor;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : Item
{
	public:
		const bool TWOHANDED;
		const uint BASE_DAMAGE;
		const uint PRECISION;

		this(string name, string help, uint weight, char rep, bool twohanded=false, uint baseDamage=0, uint precision=0) {
			super(name, help, weight, rep);
			TWOHANDED=twohanded;
			BASE_DAMAGE=baseDamage;
			PRECISION=precision;
		}
}
