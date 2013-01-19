module netslash.core.fountain;

import netslash.core.actor;
import netslash.core.consumable;
import netslash.core.player;

class Fountain : Actor
{
	public:
		override const bool moveable() @property{ return false; }
		override const char rep() @property{ return 'F'; }
		this( int x, int y )
		{
			this.x = x;
			this.y = y;
		}

		void move()
		{
			// do nothing
		}

		override void teleport( int x, int y)
		{
			// do nothing
		}

		override void applyDamage( ulong damage )
		{
			// do nothing
		}

		override void consume( Consumable c )
		{
			// do nothing
		}

		const override string help()
		{
			return "This is a fountain, you can drink from it with q\nQuaff"
			~"for Victory!!";
		}

		void drink( Player p )
		{
			// TODO add shenagans to drink
			p.heal( p.getMaxHealth() );
		}
}
