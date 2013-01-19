module netslash.core.item;

interface Item
{
	public:
		char getCharacter();

		string getName();
		string getHelp();
		int getWeight();
}
