module netslash.core.weapons.unarmed;

import netslash.core.weapon;

class Unarmed : Weapon
{
	public this ()
	{
		super("Fisticuffs",
			"Attack with your manly fisticuffs!",
			0, ' ', false, 0, 100);
	}
}
