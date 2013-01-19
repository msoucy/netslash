module netslash.core.rangedWeapon;

import netslash.core.weapon;

abstract class RangedWeapon : Weapon
{
	public:
		const int BASE_DAMAGE;
		const int BASE_RANGED_DAMAGE;
}
