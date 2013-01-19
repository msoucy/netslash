module netslash.core.armors.leatherarmor;

import std.json;

import netslash.core.armor;

class LeatherArmor : Armor
{
	public this()
	{
		super(
			"LeatherArmor",
			"A basic set of armor that provides minimal protection",
			20,
			'L',
			1
	);
	}

	public string serialize()
	{
		auto json = super.serialize( "LeatherArmor" );
		return toJSON(&json);
	}

	public static LeatherArmor deserialize( string src )
	{
		auto json = src.parseJSON();
		LeatherArmor r = new LeatherArmor();

		return r;
	}
}
