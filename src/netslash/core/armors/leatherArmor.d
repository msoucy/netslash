module netslash.core.armors.leatherarmor;

import netslash.core.armor;

static if(0)
class LeatherArmor : Armor
{
	const override uint damage_absorbed() @property {return 2;}

	override const string getName()
	{
		return "Leather Armor";
	}

	override const string getHelp()
	{
		return "A basic set of armor that provides minimal protection";
	}

	override const uint weight()
	{
		return 20;
	}
}
