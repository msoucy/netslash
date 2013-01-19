import std.stdio;
import std.socket;
import core.thread;
import std.conv;
import std.string;

class GameServer {

    enum Consts {
        DEFAULT_PORT = 13373,
        DEFAULT_BUFSIZE = 1024,
        DEFAULT_MAXCONNECTIONS = 8
    }

    void startServer(ushort port = Consts.DEFAULT_PORT, int bufsize = Consts.DEFAULT_BUFSIZE, int maxcons = Consts.DEFAULT_MAXCONNECTIONS) {
        try {
            debug {
                writefln("Starting server:\n\tArgs: Port: %d\n\tBuffer Size: %d\n\tMax Connections: %d", port, bufsize, maxcons);
            }
            currentUsers = 0;
            auto srv = new TcpSocket;
            srv.bind(new InternetAddress(port));
            srv.listen(10);
            debug { writefln("Entering loop"); }
            for(Socket c = srv.accept(); c.isAlive(); c = srv.accept()) {
                debug { writefln("Waiting for connection..."); }
                if(currentUsers < maxcons) {
                    auto t = new UserThread(c);
                    t.start();
                }
                else {
                    writefln("Max Users Connected!");
                    debug {
                        writefln("Current mex users reached: %d", currentUsers);
                    }
                }
            }
        } catch(std.socket.SocketOSException e) {
            writefln("Error binding to Socket");
        }
    }
private:
        synchronized {
            int currentUsers;
        }
    class UserThread : Thread {
        
        this(Socket rem, int bufs = Consts.DEFAULT_BUFSIZE) {
            debug { writefln("Thread constructor started"); }
            cli = rem;
            bufsize = bufs;
            super(&run);
        }

    private:
        Socket cli;
        int bufsize;
        void run(){
            ++currentUsers;
            debug { writefln("Running thread..."); }
            char[] buf = new char[bufsize];
            long n;
            // n = cli.receive(buf);
            debug { 
                write("Connection from ");
                writefln(cli.remoteAddress().toAddrString());
            }
            debug { writefln("Receiveing"); }
            n = cli.receive(buf);
            debug { writefln("Done receiving"); }
            string s = "";
            while(cli.isAlive()) {
                n = cli.receive(buf);
                s = to!string(buf[0..n]);
                s = strip(s);
                debug { writefln("%s", s); }
                if(s == GameServerCommands.UPDATE) {
                    cli.send(GameServerCommands.UPDATE);
                }
                if(s == GameServerCommands.EXIT) {
                    cli.send(GameServerCommands.EXIT);
                    debug {writefln("Exiting");}
                    break;
                }
                else {
                    cli.send(GameServerCommands.ERROR);
                }
            }
            --currentUsers;
            writef("Closed connection to ");
            writefln(cli.remoteAddress().toAddrString());
            writefln("Current Users: %d", currentUsers);
            cli.close();
            
        }
    }
}

// Sent from server
class GameServerCommands {
public:
    static string UPDATE = "update";
    static string EXIT = "exit";
    static string ERROR = "error";
}

int main() {
    debug {
        writefln("%s, %s, %s", GameServerCommands.UPDATE,GameServerCommands.EXIT, GameServerCommands.ERROR);
    }
    writefln("Starting Gameserver");
    debug {
        writefln("***Debug Enabled***");
    }
    GameServer gs = new GameServer();
    gs.startServer();
    return 1;
}