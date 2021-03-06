module netslash.core.player;

import std.json;
import std.random;
import std.conv;
import std.typetuple;
import std.stdio;

import netslash.core.actor;
import netslash.core.armor;
import netslash.core.item;
import netslash.core.npc;
import netslash.core.weapons.unarmed;
import netslash.core.weapon;

class Player : Actor
{
	private:
		Item[] inventory;

		// Actors that are 'spawned' by this player, they must go immediately
		// after the player. The best example of this is a projectile from a
		// ranged weapon
		Npc[] slaves;
		Weapon leftHandWeapon;
		Weapon rightHandWeapon;
		Armor currentArmor;
		int health, maxHealth,  mana, maxMana, weight,  maxWeight, strength;
		float dexterity;
		bool alive;

	public:
		static char rep;
		static real healthRegenFactor = 0.1;
		static real manaRegenFactor = 0.1;
	/**
	 * Creates a new player
	 * startHealth the starting health of the player
	 * startMana the starting mana of the player
	 * startMaxWeight how much weight a player can carry
	 */
	public this( int startHealth, int startMana, int startMaxWeight, int
	startStrength, float startDex ,char repChar)
	{
		health = startHealth;
		maxHealth = startHealth;
		mana = startMana;
		maxMana = startMana;
		weight = 0;
		maxWeight = startMaxWeight;
		strength = startStrength;
		dexterity = 10f;
		rep = repChar;

		inventory = [];
		slaves = [];
	}
	private:
		/*
		 * Attacks the specified actor. Generats a roll which is used to
		 * determine if an attack hit or not.
		 *
		 * Returns the ammount of damage delt to the other actor.
		 * If no damage was dealt, returns 0.
		 */
		auto attack( Actor a, Weapon w )
		{
			int damage = 0;
			auto hit = calculateHitChance( w );
			auto roll = uniform( 0, 100 );

			if( roll >= hit )
			{
				damage = calculateDamage();
				a.applyDamage( damage );
				return damage;
			}

			return damage;
		}

		auto rangedAttack()
		{
			//TODO generate a new actor to place in the world
		}

		/*
		 * Calculates damage based off of the current equiped weapon
		 */
		int calculateDamage()
		{
			// if a hand is unarmed (null) create new unarmed
			if( leftHandWeapon is null )
			{
				leftHandWeapon = new Unarmed();
			}

			if( rightHandWeapon is null )
			{
				rightHandWeapon == new Unarmed();
			}

			if( leftHandWeapon is rightHandWeapon )
				// if the weapon is one handed it will be the same in both
				// slots. The damage should be the weapon base damage plus
				// the player's strength attribute - 10 divided by two
			{
				return rightHandWeapon.BASE_DAMAGE +  ( strength - 10 ) /2;
			}
			else
				// if two one-handed weapons are equiped the same is applied
				// but the strength bonus is applied two times
			{
				return leftHandWeapon.BASE_DAMAGE +
				rightHandWeapon.BASE_DAMAGE + ( (strength - 10) / 2 ) * 2;
			}
		}

		/*
		 * Calculates the hit chance based off of the player's dexterity stat
		 * and the weapons precisison stat
		 *
		 * Precision max is 100 (hit every time ), precision min is 0 (never
		 * hits)
		 */
		real calculateHitChance( Weapon w )
		{
			return ( dexterity + w.PRECISION ) / 2;
		}

	public:

		/**
		 * Applies the specified damage
		 **/
		override void applyDamage( ulong damage )
		{
			health -= damage - currentArmor.DAMAGE_ABSORBED;

			if( health <= 0 )
			{
				alive = false;
			}
		}

		void heal( ulong amount )
		{
			health += amount;

			if( health > maxHealth )
			{
				health = maxHealth;
			}
		}

		int getMaxHealth()
		{
			return maxHealth;
		}

		override void teleport(int x, int y) {
			return;
		}
		override void move(Actor.DIRECTION) {
			return;
		}

		override string help() {
			return "A player";
		}

		string serialize() {
			auto json = JSONValue();
			json.type = JSON_TYPE.OBJECT;
			json.object["x"] = JSONValue();
			json.object["x"].type = JSON_TYPE.INTEGER;
			json.object["x"].integer = x;
			json.object["y"] = JSONValue();
			json.object["y"].type = JSON_TYPE.INTEGER;
			json.object["y"].integer = y;
			json.object["health"] = JSONValue();
			json.object["health"].type = JSON_TYPE.INTEGER;
			json.object["health"].integer = health;
			json.object["maxHealth"] = JSONValue();
			json.object["maxHealth"].type = JSON_TYPE.INTEGER;
			json.object["maxHealth"].integer = maxHealth;
			json.object["mana"] = JSONValue();
			json.object["mana"].type = JSON_TYPE.INTEGER;
			json.object["mana"].integer = mana;
			json.object["maxMana"] = JSONValue();
			json.object["maxMana"].type = JSON_TYPE.INTEGER;
			json.object["maxMana"].integer = maxMana;
			json.object["maxWeight"] = JSONValue();
			json.object["maxWeight"].type = JSON_TYPE.INTEGER;
			json.object["maxWeight"].integer = maxWeight;
			json.object["strength"] = JSONValue();
			json.object["strength"].type = JSON_TYPE.INTEGER;
			json.object["strength"].integer = strength;
			json.object["dexterity"] = JSONValue();
			json.object["dexterity"].type = JSON_TYPE.FLOAT;
			json.object["dexterity"].floating = 10;
			json.object["alive"] = JSONValue();
			json.object["alive"].type = JSON_TYPE.INTEGER;
			json.object["alive"].integer = alive;
			json.object["rep"] = JSONValue();
			json.object["rep"].type = JSON_TYPE.STRING;
			json.object["rep"].str = ""~rep;
			json.object["healthRegenFactor"] = JSONValue();
			json.object["healthRegenFactor"].type = JSON_TYPE.FLOAT;
			json.object["healthRegenFactor"].floating = healthRegenFactor;
			return toJSON(&json);
		}

		static Player deserialize(string src) {
			auto json = src.parseJSON();
			writefln("AAA");
			Player p = new Player(
				
				json.object["health"].integer.to!int(),
				json.object["mana"].integer.to!int(),
				json.object["maxWeight"].integer.to!int(),
				json.object["strength"].integer.to!int(),
				//json.object["dexterity"].floating,
				10f,
				'X'
				//json.object["rep"].str.to!char()
			);
			
			p.maxHealth = json.object["maxHealth"].integer.to!int(),
			p.maxMana = json.object["maxMana"].integer.to!int(),
			p.x = json.object["x"].integer;
			p.y = json.object["y"].integer;
			p.healthRegenFactor = 1;
			//json.object["healthRegenFactor"].floating;
			writefln("BBBB");
			p.manaRegenFactor = 1;
			//json.object["manaRegenFactor"].floating;

			writefln("AAA");
			p.dexterity = json.object["dexterity"].floating;
			p.alive = json.object["alive"].integer != 0;

			return p;
		}
}
