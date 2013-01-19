#!/usr/bin/make

# The subdirectory where output files will be stored
OBJDIR=bin
RELDIR=rel

# Libraries we use
C_LIBS=-lncurses
D_LIBS=${addprefix -L, $(C_LIBS)}
# Flags needed for building
BASE_FLAGS=-property $(D_LIBS) -I"src"
DEBUG_FLAGS=$(BASE_FLAGS) -wi -de -gs -debug
RELEASE_FLAGS=$(BASE_FLAGS) -O -inline
# The build command to use
DBLD=dmd

SRC_PREFIX=src
CLIENT_PREFIX=$(SRC_PREFIX)/netslash/client
SERVER_PREFIX=$(SRC_PREFIX)/netslash/server
CORE_PREFIX=$(SRC_PREFIX)/netslash/core

CLIENT_FILES=${wildcard $(CLIENT_PREFIX)/*.d}
SERVER_FILES=${wildcard $(SERVER_PREFIX)/*.d}
CORE_FILES=${wildcard $(CORE_PREFIX)/*.d}

$(OBJDIR)/%: %.d
	@echo "$<"
	@if [ ! -d $(OBJDIR) ] ; then mkdir -p $(OBJDIR) ; fi
	$(DBLD) "$<"

all: client server

release: realclean release-client release-server

client: $(CLIENT_FILES) $(CORE_FILES)
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(CLIENT_PREFIX)/client.d

server: $(SERVER_FILES) $(CORE_FILES)
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(SERVER_PREFIX)/server.d

release-client: $(CLIENT_FILES) $(CORE_FILES)
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(CLIENT_PREFIX)/client.d

release-server: $(SERVER_FILES) $(CORE_FILES)
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(SERVER_PREFIX)/server.d

clean:
	rm -rf $(OBJDIR) $(RELDIR) &> /dev/null

realclean: clean
	rm -rf client server