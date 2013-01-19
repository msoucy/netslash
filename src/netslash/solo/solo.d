import metus.dncurses.dncurses;

import std.stdio;

import netslash.generator.mapgen : genTestMap;

import netslash.core.board;
import netslash.core.tile;
import netslash.core.player;

class Solo
{
	private:
		Board[] levels;
		int currentLevel = 0;
		Player player;

	public this()
	{
		player = new Player( 10, 10 , 100, 5, 10, 'X' );
		levels = [];
		initscr();
		initColor();
	}

	public:
		void start()
		{
			levels ~= genTestMap();
			//write(levels[currentLevel].print());
			Board start = levels[0];
			start[5][5].putActor( player );
			mainLoop();
			stdwin.keypad = true;
			mode = Raw();
			stdwin.timeout = 0;
			echo(false);
		}

		void mainLoop()
		{
			bool run = true;
			while( run )
			{
				stdwin.put(levels[currentLevel].print());

				auto c = stdwin.getch();

				switch( c )
				{
					case 27 :
					{
						run = false;
						break;
					}
					default :
					{
						break;
					}
				}
			}
		}
}

int main( char[][] argv )
{
	scope(exit) echo(true);
	Solo s = new Solo();
	s.start();
	scope(exit) endwin();
	return 0;
}
