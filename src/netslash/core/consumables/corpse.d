module netslash.core.consumables.corpse;

import netslash.core.consumable;
import netslash.core.actor;

class Corpse : Consumable {
	this(string name, uint weight) {
		super(name ~ " Corpse", "Drink the blood of your enemies!", weight, '%');
	}
	override void consume(Actor a) {
		//
	}

}
