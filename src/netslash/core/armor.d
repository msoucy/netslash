module netslash.core.armor;

import std.json;

import netslash.core.item;

/*
 * Abstract class for Armor
 */
class Armor : Item
{
	public:
		const uint DAMAGE_ABSORBED;

		this(string _name, string _help, uint weight, char rep= ' ', uint damage=0) {
			super(_name, _help, weight, rep);
			DAMAGE_ABSORBED = damage;
		}

		override JSONValue serialize( string typeRep )
		{
			JSONValue json = super.serialize( typeRep );

			json.object["damageAbsorbed"] = JSONValue();
			json.object["damageAbsorbed"].type = JSON_TYPE.UINTEGER;
			json.object["damageAbsorbed"].uinteger = DAMAGE_ABSORBED;

			return json;
		}
}
