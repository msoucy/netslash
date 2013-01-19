module netslash.core.item;

import std.json;

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

		JSONValue serialize( string typeRep )
		{
			JSONValue json = JSONValue();
			json.type = JSON_TYPE.OBJECT;

			json.object["name"] = JSONValue();
			json.object["name"].type = JSON_TYPE.STRING;
			json.object["name"].str = NAME;

			json.object["helpMessage"] = JSONValue();
			json.object["helpMessage"].type = JSON_TYPE.STRING;
			json.object["helpMessage"].str = HELP_MESSAGE;

			json.object["weight"] = JSONValue();
			json.object["weight"].type = JSON_TYPE.UINTEGER;
			json.object["weight"].uinteger = WEIGHT;

			json.object["rep"] = JSONValue();
			json.object["rep"].type = JSON_TYPE.STRING;
			json.object["rep"].str = ""~REP;

			return json;
		}
}
