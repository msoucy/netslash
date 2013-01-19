module netslash.core.consumable;

import netslash.core.item;
import netslash.core.actor;

interface Consumable : Item
{
	public:
		void consume(Actor);
}
