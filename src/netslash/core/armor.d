module netslash.core.armor;

import netslash.core.item;

/*
 * Abstract class for Armor
 */
class Armor : Item
{
	public:
		const uint DAMAGE;

		this(string _name, string _help, uint weight, char rep= ' ', uint damage=0) {
			super(_name, _help, weight, rep);
			DAMAGE=damage;
		}
}
