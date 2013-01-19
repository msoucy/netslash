module netslash.core.weapons.rustysword;

import netslash.core.weapon;

class RustySword : Weapon
{
	public:
		override const uint base_damage() @property {return 0;}
		override const uint weight() @property {return 10;}
		override const uint precision() @property {return 0;}
		
	public this ()
	{
		Weapon.twoHanded = true;
	}

	public:

		const string getName()
		{
			return "Rusty Sword";
		}

		const string getHelp()
		{
			return "A two handed sword with a rusing blade";
		}

		override const char getCharacter()
		{
			return '/';
		}
}
