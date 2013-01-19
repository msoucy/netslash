module netslash.core.player;

import std.json;
import std.random;
import std.conv;
import std.typetuple;

import netslash.core.actor;
import netslash.core.armor;
import netslash.core.item;
import netslash.core.npc;
import netslash.core.unarmed;
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
		char rep;
	/**
	 * Creates a new player
	 * startHealth the starting health of the player
	 * startMana the starting mana of the player
	 * startMaxWeight how much weight a player can carry
	 */
	public this( int startHealth, int startMana, int startMaxWeight, int
	startStrength, char repChar)
	{
		health = startHealth;
		maxHealth = startHealth;
		mana = startMana;
		maxMana = startMana;
		weight = startMaxWeight;
		maxWeight = startMaxWeight;
		strength = startStrength;
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
				return rightHandWeapon.base_damage +  ( strength - 10 ) /2;
			}
			else
				// if two one-handed weapons are equiped the same is applied
				// but the strength bonus is applied two times
			{
				return leftHandWeapon.base_damage +
				rightHandWeapon.base_damage + ( (strength - 10) / 2 ) * 2;
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
			return ( dexterity + w.precision ) / 2;
		}

	public:

		/**
		 * Applies the specified damage
		 **/
		override void applyDamage( ulong damage )
		{
			health -= damage - currentArmor.damage_absorbed;

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
			json.object["mana"] = JSONValue();
			json.object["mana"].type = JSON_TYPE.INTEGER;
			json.object["mana"].integer = mana;
			json.object["maxWeight"] = JSONValue();
			json.object["maxWeight"].type = JSON_TYPE.INTEGER;
			json.object["maxWeight"].integer = maxWeight;
			json.object["strength"] = JSONValue();
			json.object["strength"].type = JSON_TYPE.INTEGER;
			json.object["strength"].integer = strength;
			json.object["rep"] = JSONValue();
			json.object["rep"].type = JSON_TYPE.STRING;
			json.object["rep"].integer = rep;
			return toJSON(&json);
		}

		static Player deserialize(string src) {
			auto json = src.parseJSON();
			Player p = new Player(
				json.object["health"].integer.to!int(),
				json.object["mana"].integer.to!int(),
				json.object["maxWeight"].integer.to!int(),
				json.object["strength"].integer.to!int(),
				json.object["rep"].str.to!char(),
			);
			p.x = json.object["x"].integer;
			p.y = json.object["y"].integer;
			return p;
		}
}
