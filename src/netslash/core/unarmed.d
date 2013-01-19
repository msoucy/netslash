module netslash.core.unarmed;

import netslash.core.weapon;

class Unarmed : Weapon
{
	private:
	public:

	override const uint base_damage() @property {
		return 0;
	}

	public:
		override const char getCharacter()
		{
			return ' ';
		}

		string getName()
		{
			return "Fisticuffs";
		}

		string getHelp()
		{
			return "Attack with your manly fisticuffs!";
		}
		uint WEIGHT() @property { return 0; }
}
