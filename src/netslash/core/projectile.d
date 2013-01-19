module netslash.core.projectile;

import netslash.core.actor;


//TODO add npc interface
abstract class Projectile : Actor
{
	public:
		const int SOURCE_DAMAGE;
		const int BASE_DAMAGE;
		const real DECAY_FACTOR;
		const ulong HIT_CHANCE // should be between 0 and 100
		const ulong PRECISION;
		const ulong RANGE;

	private:
		int distanceTraveled;

		 int calculateDamage()
		{
			return (SOURCE_DAMAGE + BASE_DAMAGE) - (distance * DECAY_FACTOR);
		}
}
