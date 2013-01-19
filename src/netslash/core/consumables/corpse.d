module netslash.core.consumables.corpse;

import std.json;
import std.conv;

import netslash.core.consumable;
import netslash.core.actor;

class Corpse : Consumable {
	public this(string name, uint weight) {
		super(name ~ " Corpse", "Drink the blood of your enemies!", weight, '%');
	}
	override void consume(Actor a) {
		//
	}

	string serialize()
	{
		auto json = super.serialize( Consumable.NAME );
		return toJSON(&json);
	}

	static Corpse deserialize( string src )
	{
		auto json = src.parseJSON();
		Corpse c = new Corpse(
			json.object["name"].str,
			json.object["weight"].uinteger.to!uint()
			);

		return c;
	}

}
