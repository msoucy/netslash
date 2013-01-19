module netslash.client.client;

import std.stdio;
import std.socket;
import std.conv;

import netslash.core.board;
import netslash.core.player;
import netslash.core.actor;

import metus.dncurses.dncurses;

class ClientServer {
private:
	Socket skt;
	size_t bufsize;
	enum Consts {DEFAULT_BUFSIZE = 2046, DEFAULT_PORT = 13373}
public:
	this(string host, ushort port = Consts.DEFAULT_PORT, size_t bufsize = Consts.DEFAULT_BUFSIZE) {
		debug { writefln("Starting client\nArgs:\n\tPort: %d\n\tBuffer Size: %d", port, bufsize); }
		writefln(getAddress(host, port)[0].toAddrString());
		skt = new TcpSocket(new InternetAddress(host, port));
		skt.blocking = false;
		this.bufsize = bufsize;
		debug { writefln("Entering client loop"); }
	}

	string get() {
		char[] buf = new char[bufsize];
		long n = skt.receive(buf);

		debug { 
			//string str = to!string(buf[0..n]);
			//writefln("got: %s", str);
		}
		if(n==0 || (n==-1&&wouldHaveBlocked())) {
			return "";
		} else {
			debug {
				writefln("Received %s bytes", n);
			}
			return to!string(buf[0..n]);
		}
	}

	void write(string s) {
		skt.send(s);
	}

	void close() {
		this.write("exit");
		skt.close();
	}
}

string getline(ClientServer serv) {
	string str;
	do {
		str=serv.get();
	} while(str.length == 0);
	return str;
}

void main() {
	//ClientServer s = new ClientServer("hanesmba.student.rit.edu");
	ClientServer s = new ClientServer("127.0.0.1");
	scope(exit) s.close();

	initscr();
	scope(exit) endwin();
	initColor();

	stdwin.keypad = true;
	mode=Raw();
	stdwin.timeout = 50;
	echo(false);
	scope(exit) echo(true);

	string str;
	str = s.getline();
	Board board = Board.deserialize(str);
	stdwin.put(board.print());
	str = s.getline();
	Player player = Player.deserialize(str);
	stdwin.getch();

	while(1) {
		auto ch = stdwin.getch();
		switch(ch) {
			case 'h': {
				player.x--;
				s.write(player.serialize());
				break;
			}
			case 'l': {
				player.x++;
				s.write(player.serialize());
				break;
			}
			case 'j': {
				player.y++;
				s.write(player.serialize());
				break;
			}
			case 'k': {
				player.y--;
				s.write(player.serialize());
				break;
			}
			case 'q': {
				return;
			}
			default: {
				break;
			}
		}
		str=s.get();
		if(str != "") {
			board = Board.deserialize(str);
			str=s.get();
			if(str != "") {
				player = Player.deserialize(str);
			}
		}
	}

}
