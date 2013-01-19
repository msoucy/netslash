module netslash.client.client;

import std.stdio;
import std.socket;
import std.conv;

import netslash.core.board;
import netslash.core.player;
import netslash.core.actor;

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

void main() {
	ClientServer s = new ClientServer("127.0.0.1");
	scope(exit) s.close();

	string str;
	do {
		str=s.get();
	} while(str.length == 0);
	Board b = Board.deserialize(str);
	do {
		str=s.get();
	} while(str.length == 0);
	str.writeln();
	Player p = Player.deserialize(str);
	return;

}
