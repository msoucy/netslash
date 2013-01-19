module netslash.core.player;

import std.random;

class Player : Actor
{
	private:
		Item[] inventory;
		Weapon leftHandWeapon;
		Weapon rightHandWeapon;
		Armor currentArmor;
		int health, mana, maxWeight, strength;
		float dexterity;

	private:
		/*
		 * Attacks the specified actor. Generats a roll which is used to
		 * determine if an attack hit or not.
		 *
		 * Returns the ammount of damage delt to the other actor.
		 * If no damage was delt, returns 0.
		 */
		auto attack( Actor a )
		{
			int damage = 0;
			auto hit = calculateHitChance();
			auto roll = uniform( 0, 100 );

			if( roll >= hit )
			{
				damage = calculateDamage();
				a.applyDamage( damage )
				return damage;
			}

			return damage;
		}

		/*
		 * Calculates damage based off of the current equiped weapon
		 */
		int calculateDamage()
		{
			if( leftHandWeapon is rightHandWeapon )
				// if the weapon is one handed it will be the same in both
				// slots. The damage should be the weapon base damage plus
				// the player's strength attribute - 10 divided by two
			{
				return rightHandWeapon.BASE_DAMAGE +  ( strength - 10 ) /2;
			}else
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
			return ( dexterity + w.getPrecision ) / 2;
		}



}
