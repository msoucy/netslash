module netslash.core.weapons.rustysword;

import std.json;

import netslash.core.weapon;

class RustySword : Weapon
{
	public this ()
	{
		super("Rusty Sword",
			"A two handed sword with a rusting blade",
			10, '/', true, 1, 70);
	}

	public string serialize()
	{
		auto json = super.serialize( "Rusty Sword" );
		return toJSON(&json);
	}

	public static RustySword deserialize( string src )
	{
		auto json = src.parseJSON();
		RustySword r = new RustySword();

		return r;
	}
}
