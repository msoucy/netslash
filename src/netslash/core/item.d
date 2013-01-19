module netslash.core.item;

abstract class Item
{
	public:
		this(string name = "Perfectly generic object", string help = "A perfectly generic object", uint weight = 0, char rep =' ') {
			NAME=name;
			HELP_MESSAGE=help;
			WEIGHT=weight;
			REP=rep;
		}

		const string NAME;
		const string HELP_MESSAGE;
		const uint WEIGHT;
		const char REP;
}
