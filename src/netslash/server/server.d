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
            players = new Player[maxcons];
            cons = new Socket[maxcons];
            for(int i = 0; i < maxcons; ++i) {
                players[i] = null;
            }
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
        Player[] players;
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
            //cli.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVLOWAT, 1);
            ++currentUsers;
            debug { writefln("Running thread..."); }
            char[] buf = new char[bufsize];
            size_t n;
            debug { 
                write("Connection from ");
                writefln(cli.remoteAddress().toAddrString());
            }

            string s = "";
            Player p = new Player(10,10,10,10,10, 'X');
            players[currentUsers-1] = p;
            int index = currentUsers-1;
            bool err = b.board[b.startRow][b.startCol].putActor(p);
            debug {(err) ? writefln("Placed at home") : writefln("Error placing");}
            cli.send(b.serialize());
            cli.send(p.serialize());
            debug{ writefln("playerinfo: %s", p.serialize()); }
            debug {writefln(b.print()); }
            while(cli.isAlive()) {
                n = cli.receive(buf);
                s = to!string(buf[0..n]);
                s = strip(s);
                debug { writefln("From %s: %s", cli.remoteAddress().toAddrString(), s); }

                if(s == GameServerCommands.EXIT) {
                    cli.send(GameServerCommands.EXIT);
                    debug {writefln("Exiting");}
                    break;
                }

                else {
                    try {
                        writefln("b");
                        Player newP = Player.deserialize(s);
                        writefln("a");
                        Player old = players[index];
                        b.board[old.x][old.y].actor = null;
                        b.board[newP.x][newP.y].actor = newP;
                        players[index] = newP;
                        cli.send(b.serialize());
                        auto json = JSONValue();
                        json.type = JSON_TYPE.ARRAY;
                        for(int i = 0; i < players.length; ++i) {
                            if(!(players[i] is null)) {
                                debug { writefln("Adding player: %d", i); }
                                string str = players[i].serialize();
                                debug { writefln("Serialized player: %s", str); }
                                writef("a\n");
                                json.array ~= parseJSON(str);
                                debug{ writefln("Bottom of loop"); }
                            }
                            else {
                                debug{ writefln("Player is null");}
                            }
                        }
                        debug{writefln(s);}
                        debug{ writefln("Done serializing"); }
                        writefln(toJSON(&json));
                        cli.send(toJSON(&json));
                    } catch(Exception e) {
                        cli.write("error");
                    }
                }
                writefln("done");
                drawBoard();
            }
            --currentUsers;
            writef("Closed connection to ");
            writefln(cli.remoteAddress().toAddrString());
            writefln("Current Users: %d", currentUsers);
            scope(exit) cli.close();
        }
    }

    void drawBoard() {
        for(int i = 0; i < b.board.length; ++i) {
            for(int n = 0; n < b.board[i].length; ++n) {
                char pChar = b.board[i][n].rep();
                for(int z = 0; z < players.length; ++z) {
                    if(!(players[z] is null)) {
                        if(players[z].x == i && players[z].y==n) {
                            //debug{writefln("Player at %d, %d", i,n);}
                            pChar = players[z].rep;
                            break;
                        }
                    }
                }
                writef("%c", pChar);
            }
            writefln("");
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

int main(char[][] argv) {
    writefln("Starting Gameserver");
    debug {
        writefln("***Debug Enabled***");
    }
    debug {
        writefln("Commands: %s, %s, %s", GameServerCommands.UPDATE,GameServerCommands.EXIT, GameServerCommands.ERROR);
        Tile n = new Tile(0,0);
        n.rep();
    }
    GameServer gs = new GameServer();
    gs.startServer();
    return 0;
}
