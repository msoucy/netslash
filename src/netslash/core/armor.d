module netslash.core.armor;

import netslash.core.item;

/*
 * Abstract class for Armor
 */
abstract class Armor : Item
{
	public:
		const uint damage_absorbed() @property { return 0;}

		const abstract string getName();
		const abstract string getHelp();
		const abstract uint weight();
}
