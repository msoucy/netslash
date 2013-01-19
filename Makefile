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
GEN_PREFIX=$(SRC_PREFIX)/netslash/generator
CORE_PREFIX=$(SRC_PREFIX)/netslash/core
DNCURSES_PREFIX=$(SRC_PREFIX)/metus/dncurses

CORE_FILES=${wildcard $(CORE_PREFIX)/*.d} ${wildcard $(DNCURSES_PREFIX)/*.d}
GEN_FILES=${wildcard $(GEN_PREFIX)/*.d} $(CORE_FILES)
CLIENT_FILES=${wildcard $(CLIENT_PREFIX)/*.d} $(CORE_FILES)
SERVER_FILES=${wildcard $(SERVER_PREFIX)/*.d} $(GEN_FILES)

$(OBJDIR)/%: %.d
	@echo "$<"
	@if [ ! -d $(OBJDIR) ] ; then mkdir -p $(OBJDIR) ; fi
	$(DBLD) "$<"

all: client server generator

release: realclean release-client release-server release-generator

client: $(CLIENT_FILES)
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(CLIENT_FILES)

server: $(SERVER_FILES)
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(SERVER_FILES)

generator: $(GEN_FILES)
	$(DBLD) -od"$(OBJDIR)" $(DEBUG_FLAGS) $(GEN_FILES)

release-client: $(CLIENT_FILES)
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(CLIENT_FILES)

release-server: $(SERVER_FILES)
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(SERVER_FILES)

release-generator: $(GEN_FILES)
	$(DBLD) -od"$(RELDIR)" $(RELEASE_FLAGS) $(GEN_FILES)

clean:
	rm -rf $(OBJDIR) $(RELDIR) &> /dev/null

realclean: clean
	rm -rf client server mapgen
