module netslash.core.unarmed;

import netslash.core.weapon;

class Unarmed : Weapon
{
	private:
	public:

	/**
	 * Create a new unarmed weapon.
	 * Unarmed always does +0 damage
	 **/
	public this()
	{
		BASE_DAMAGE = 0;
	}

	public:
		override getCharacter()
		{
			return ' ';
		}

		override getName()
		{
			return "Fisticuffs";
		}

		override getHelp()
		{
			return "Attack with your manly fisticuffs!";
		}
}
