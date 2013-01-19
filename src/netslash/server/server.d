module netslask.server.server;

import std.stdio;
import std.socket;
import core.thread;
import std.conv;
import std.string;
import std.json;
import netslash.generator.mapgen : genTestMap;
import netslash.core.board;
import netslash.core.tile;
import netslash.core.player;

/**
* GameServer for netslash
* @author Andrew Hanes
*/
class GameServer {

    enum Consts {
        DEFAULT_PORT = 13373,
        DEFAULT_BUFSIZE = 1024,
        DEFAULT_MAXCONNECTIONS = 8
    }
    /**
    * Call to start the server
    * Default args are in the GameServer.Consts enum
    * @param port the prot
    * @param bufsize The buf size 
    * @param maxcons The max connections
    */
    void startServer(ushort port = Consts.DEFAULT_PORT, int bufsize = Consts.DEFAULT_BUFSIZE, int maxcons = Consts.DEFAULT_MAXCONNECTIONS) {
        try {
            debug {
                writefln("Starting server\nArgs:\n\tPort: %d\n\tBuffer Size: %d\n\tMax Connections: %d", port, bufsize, maxcons);
            }
            b = genTestMap();
            maxUsers = maxcons;
            currentUsers = 0;
            cons = new Socket[maxcons];
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
    int maxUsers;
    Socket [] cons;
    synchronized {
        int currentUsers;
        Board b;
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
            cli.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVLOWAT, 5);
            ++currentUsers;
            debug { writefln("Running thread..."); }
            char[] buf = new char[bufsize];
            size_t n;
            debug { 
                write("Connection from ");
                writefln(cli.remoteAddress().toAddrString());
            }

            string s = "";
            Player p = new Player(10,10,10,10, 'X');
            b.putActor(p);
            bool err = b.board[b.startRow][b.startCol].putActor(p);
            debug {(err) ? writefln("Placed at home") : writefln("Error placing");}
            cli.send(b.serialize());
            debug {writefln(b.print()); }
            while(cli.isAlive()) {
                n = cli.receive(buf);
                s = to!string(buf[0..n]);
                s = strip(s);
                debug { writefln("From %s: %s", cli.remoteAddress().toAddrString(), s); }
                if(s == GameServerCommands.UPDATE) {
                    cli.send(GameServerCommands.UPDATE);
                }
                else if(s == GameServerCommands.EXIT || '\n') {
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
    writefln("Starting Gameserver");
    debug {
        writefln("***Debug Enabled***");
    }
    debug {
        writefln("Commands: %s, %s, %s", GameServerCommands.UPDATE,GameServerCommands.EXIT, GameServerCommands.ERROR);
        Tile n = new Tile();
        n.rep();
    }
    GameServer gs = new GameServer();
    gs.startServer();
    return 0;
}
