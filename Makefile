#!/usr/bin/make

# The subdirectory where intermediate files (.o, etc.) will be stored
OBJDIR=bin
RELDIR=rel

C_LIBS=-lncurses
D_LIBS=${addprefix -L, $(C_LIBS)}
D_FLAGS=-property -od"$(OBJDIR)" $(D_LIBS)
DEBUG_FLAGS=$(D_FLAGS) -wi -de -gs -debug
RELEASE_FLAGS=$(D_FLAGS) -O -inline 
DBLD=dmd

SRC_PREFIX=src
CLIENT_PREFIX=$(SRC_PREFIX)/netslash/client
SERVER_PREFIX=$(SRC_PREFIX)/netslash/server
CORE_PREFIX=$(SRC_PREFIX)/netslash/core

$(OBJDIR)/%: %.d
	@echo "$<"
	@if [ ! -d $(OBJDIR) ] ; then mkdir -p $(OBJDIR) ; fi
	$(DBLD) "$<"

all: client server

client:
	$(DBLD) $(DEBUG_FLAGS) $(CLIENT_PREFIX)/client.d

server:
	$(DBLD) $(DEBUG_FLAGS) $(SERVER_PREFIX)/server.d

release-client:
	$(DBLD) $(RELEASE_FLAGS) $(CLIENT_PREFIX)/client.d

release-server:
	$(DBLD) $(RELEASE_FLAGS) $(SERVER_PREFIX)/server.d

clean:
	rm -rf $(OBJDIR) &> /dev/null
