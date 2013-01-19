module netslash.core.armor.leatherarmor;

import netslash.core.armor;

class LeatherArmor : Armor
{
	const override uint damage_absorbed @property {return 2}

	const string getName()
	{
		return "Leather Armor";
	}

	const string getHelp()
	{
		return "A basic set of armor that provides minimal protection";
	}

	const uint weight()
	{
		return 20;
	}
}
