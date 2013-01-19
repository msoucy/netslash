module netslash.core.weapons.rustysword;

import netslash.core.weapon;

class RustySword : Weapon
{
	public:
		override const int base_damage() @property {return 0;}
		override const uint weight() @property {return 10;}
		override const int precision() @property {return 0;}
		override const 

	private:
		bool twoHanded;

	public this ()
	{
		twoHanded = true;
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

		const char getCharacter()
		{
			return '/';
		}
}
