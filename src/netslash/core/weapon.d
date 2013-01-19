module netslash.core.weapon;

import std.json;

import netslash.core.item;
import netslash.core.actor;

/*
 * Abstract class for a weapon
 */
abstract class Weapon : Item
{
	public:
		const bool TWOHANDED;
		const uint BASE_DAMAGE;
		const uint PRECISION;

		this(string name, string help, uint weight, char rep, bool twohanded=false, uint baseDamage=0, uint precision=0) {
			super(name, help, weight, rep);
			TWOHANDED=twohanded;
			BASE_DAMAGE=baseDamage;
			PRECISION=precision;
		}

		override JSONValue serialize ( string typeRep )
		{
			JSONValue json = super.serialize( typeRep );

			json.object["twoHanded"] = JSONValue();
			json.object["twoHanded"].type = JSON_TYPE.INTEGER;
			json.object["twoHanded"].integer = TWOHANDED;


			json.object["baseDmage"] = JSONValue();
			json.object["baseDmage"].type = JSON_TYPE.UINTEGER;
			json.object["baseDmage"].uinteger = BASE_DAMAGE;

			json.object["precision"] = JSONValue();
			json.object["precision"].type = JSON_TYPE.UINTEGER;
			json.object["precision"].uinteger = PRECISION;

			return json;
		}
}
