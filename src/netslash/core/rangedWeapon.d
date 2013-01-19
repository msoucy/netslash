module netslash.core.rangedWeapon;

import netslash.core.weapon;

abstract class RangedWeapon : Weapon
{
	public:
		const int BASE_RANGED_DAMAGE;

		this(string name, string help, uint weight, char rep, bool
		twohanded=false, uint baseDamage=0, uint baseRangedDamage=0, uint precision=0)
		{
			super( name, help, weight, rep, twohanded, baseDamage, precision
			);

			BASE_RANGED_DAMAGE = baseRangedDamage;
		}

}
