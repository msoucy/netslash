module netslash.core.projectile;

import std.conv;

import netslash.core.actor;
import netslash.core.npc;


abstract class Projectile : Actor, Npc
{
	public:
		const int SOURCE_DAMAGE;
		const int BASE_DAMAGE;
		const real DECAY_FACTOR;
		const ulong HIT_CHANCE; // should be between 0 and 100
		const ulong PRECISION;
		const ulong RANGE;

	private:
		int distanceTraveled;

		int calculateDamage()
		{
			return ((SOURCE_DAMAGE + BASE_DAMAGE) - (distanceTraveled * DECAY_FACTOR)).to!int();
		}
}
