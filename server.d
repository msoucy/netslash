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
                debug { writefln("Waiting for connection..."); };
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
            while(cli.isAlive()) {
                n = cli.receive(buf);
                string s = to!string(buf[0..n]);
                s = strip(s);
                debug { writefln("%s", s); }
                cli.send("Ok\n");
                if(s == GameServerCommands.EXIT) {
                    break;
                }
            }
            debug {
                writef("Closing connecting to ");
                writefln(cli.remoteAddress().toAddrString());
            }
            cli.close();
            --currentUsers;
        }
    }
}

// Sent from client
class GameServerCommands {
    const string EXIT = "exit";
    const string UPDATE = "update";
}

// Sent from server
class GameServerStatus {
    const string UPDATE = "update";
}

int main() {
    writefln("Starting Gameserver");
    debug {
        writefln("***Debug Enabled***");
    }
    GameServer gs = new GameServer();
    gs.startServer();
    return 1;
}