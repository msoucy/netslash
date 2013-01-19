module netslash.core.rangedWeapon;

import std.json;

import netslash.core.weapon;

abstract class RangedWeapon : Weapon
{
	public:
		const int BASE_RANGED_DAMAGE;

		this(string name, string help, uint weight, char rep, bool
		twohanded=false, uint baseDamage=0, uint baseRangedDamage=0, uint precision=0)
		{
			super( name, help, weight, rep, twohanded, baseDamage, precision
			);

			BASE_RANGED_DAMAGE = baseRangedDamage;
		}

		override JSONValue serialize( string typeRep )
		{
			JSONValue json = super.serialize( typeRep );

			json.object["baseRangedDamage"] = JSONValue();
			json.object["baseRangedDamage"].type = JSON_TYPE.INTEGER;
			json.object["baseRangedDamage"].integer = BASE_RANGED_DAMAGE;

			return json;
		}

}
