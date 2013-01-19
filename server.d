import std.stdio;
import std.socket;
import core.thread;
import std.conv;

class GameServer {
    void startServer(ushort port = 13373, int bufsize = 1024) {
        auto srv = new TcpSocket;
        srv.bind(new InternetAddress(port));
        srv.listen(10);
        writefln("Entering loop");
        for(Socket c = srv.accept(); c.isAlive(); c = srv.accept()) {
            writefln("Waiting for connection...");
            auto t = new GameThread(c);
            t.start();
        }
    }
private:
    class GameThread : Thread {
        
        this(Socket rem) {
            cli = rem;
            bufsize = 1024;
            super(&run);
        }

    private:
        Socket cli;
        int bufsize;
        void run(){
            writefln("Running thread...");
            char[] buf = new char[bufsize];
            long n;
            write("Connection from ");
            writefln(cli.remoteAddress().toAddrString());
            writefln("Receiveing");
            n = cli.receive(buf);
            writefln("Done receiving");
            while((n = cli.receive(buf)) != 0) {
                string s = to!string(buf);
                writefln("%s", s);
                cli.send("Ok\n");
            }
            writef("Closing connecting to ");
            writefln(cli.remoteAddress().toAddrString());
            cli.close();
        }
    }
}

void main() {
    GameServer gs = new GameServer();
    gs.startServer();
}