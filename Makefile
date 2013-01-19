#!/usr/bin/make

# The subdirectory where intermediate files (.o, etc.) will be stored
OBJDIR=bin
RELDIR=rel

C_LIBS=-lncurses
D_LIBS=${addprefix -L, $(C_LIBS)}
D_FLAGS=-property $(D_LIBS)
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

release: realclean release-client release-server

client: ${wildcard $(CLIENT_PREFIX)/*.d} ${wildcard $(CORE_PREFIX)/*.d}
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(CLIENT_PREFIX)/client.d

server: ${wildcard $(SERVER_PREFIX)/*.d} ${wildcard $(CORE_PREFIX)/*.d}
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(SERVER_PREFIX)/server.d

release-client: ${wildcard $(CLIENT_PREFIX)/*.d} ${wildcard $(CORE_PREFIX)/*.d}
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(CLIENT_PREFIX)/client.d

release-server: ${wildcard $(SERVER_PREFIX)/*.d} ${wildcard $(CORE_PREFIX)/*.d}
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(SERVER_PREFIX)/server.d

clean:
	rm -rf $(OBJDIR) $(RELDIR) &> /dev/null

realclean: clean
	rm -rf client server