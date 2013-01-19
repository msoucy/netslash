module netslash.core.consumable;

import netslash.core.item;
import netslash.core.actor;

abstract class Consumable : Item
{
	public:
		void consume(Actor);

		this(string name, string help, uint weight, char rep) {
			super(name,help,weight,rep);
		}
}
