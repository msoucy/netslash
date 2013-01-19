module netslash.core.consumables.corpse;

import netslash.core.consumable;

class Corpse : Consumable {
	void consume(Actor a) {
		//
	}
	char getCharacter() @safe pure nothrow const {
		return '%';
	}

}
