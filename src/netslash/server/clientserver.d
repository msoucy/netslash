module netslask.server.clientserver;

import std.stdio;
import std.socket;
import std.conv;
//import netslash.server.server;

class ClientServer {
private:
    Socket skt;
    enum Consts {DEFAULT_BUFSIZE = 4096, DEFAULT_PORT = 13373}
public:
    this(ushort port = Consts.DEFAULT_PORT, int bufsize = Consts.DEFAULT_BUFSIZE) {
        debug { writefln("Starting client_server\nArgs:\n\tPort: %d\n\tBuffer Size: %d", port, bufsize); }
        writefln(getAddress("hanesmba.student.rit.edu", 13373)[0].toAddrString());
        debug{writefln("Connecting to %s", addr[0]);}
        skt = new TcpSocket;
        skt.blocking(true);
        //skt.bind(new InternetAddress(InternetAddress.parse("hanesmba.student.rit.edu")[0], Consts.DEFAULT_PORT));
        Socket sock = new TcpSocket(new InternetAddress("hanesmba.student.rit.edu", Consts.DEFAULT_PORT));
        
        debug { writefln("Entering client loop"); }
    }

    string get() {
        char[] buf;
        long n = skt.receive(buf);
        return to!string(buf[0..n]);
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
    ClientServer s = new ClientServer();
    writefln(s.get());
    writefln(s.get());
    s.write("Hello World");
    s.close();
}