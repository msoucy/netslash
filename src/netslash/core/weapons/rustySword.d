module netslash.core.weapons.rustysword;

import netslash.core.weapon;

class RustySword : Weapon
{		
	public this ()
	{
		super("Rusty Sword",
			"A two handed sword with a rusting blade",
			10, '/', true, 1, 70);
	}
}
