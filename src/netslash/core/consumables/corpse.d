module netslash.core.consumables.corpse;

import netslash.core.consumable;
import netslash.core.actor;

class Corpse : Consumable {
	void consume(Actor a) {
		//
	}
	char getCharacter() @safe pure nothrow const {
		return '%';
	}

}
