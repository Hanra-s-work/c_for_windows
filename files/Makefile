##
## EPITECH PROJECT, 2022
## Makefile for compiling
## File description:
## jitter jitter
##

SRC	=	test.c

QUIET	=	@

DELETE	=	$(QUIET)rm -f

LINUX_COMPILER	=	$(QUIET)gcc
WINDOWS64_COMPILER	=	$(QUIET)x86_64-w64-mingw32-gcc
WINDOWS32_COMPILER	=	$(QUIET)i686-w64-mingw32-gcc

ARCH_64_DESCRIMINATOR	=	x86_64
ARCH_32_DESCRIMINATOR	=	_i686

WINDOWS_EXTENSION	=	.exe
LINUX_EXTENSION	=	

OBJ	=	$(SRC:.c=.o)

CFLAGS	=	-Wall -Wextra

CPPFLAGS	=	-I./include

NAME	=	test_file

ARCH_32_NAME	=	$(NAME)$(ARCH_32_DESCRIMINATOR)$(WINDOWS_EXTENSION)
ARCH_64_NAME	=	$(NAME)$(ARCH_64_DESCRIMINATOR)$(WINDOWS_EXTENSION)
LINUX_NAME	=	$(NAME)$(LINUX_EXTENSION)

all:	$(OBJ) complin

allplat: $(OBJ) complin comp32 comp64

comp32:
	$(WINDOWS32_COMPILER) -o $(ARCH_32_NAME) $(SRC) $(CFLAGS) $(CPPFLAGS)
comp64:
	$(WINDOWS64_COMPILER) -o $(ARCH_64_NAME) $(OBJ) $(CFLAGS) $(CPPFLAGS)
complin:
	$(LINUX_COMPILER) -o $(LINUX_NAME) $(OBJ) $(CFLAGS) $(CPPFLAGS)

help:
	$(QUIET)echo "USAGE:"
	$(QUIET)echo "- 'make' will build the linux binary"
	$(QUIET)echo "- 'make re' will clean existing binaries, objects and build"
	$(QUIET)echo "- 'make help' dislay's this help"
	$(QUIET)echo "- 'make allplat' will build all the configured binaries"
	$(QUIET)echo "- 'make debug' will build the linux binary with gdb support"
	$(QUIET)echo "- 'make debug_valgrind' will build for Linux with valgrind support"
	$(QUIET)echo "- 'make clean' remove all object files"
	$(QUIET)echo "- 'make fclean' will remove all binaries and object files"
	$(QUIET)echo "- 'make complin' will build the Linux version of the binary"
	$(QUIET)echo "- 'make comp32' will build the 32 bit version of the binary"
	$(QUIET)echo "- 'make comp64' will build the 64 bit version of the binary"

debug_valgrind: CPPFLAGS += -g3
debug_valgrind: cleanlin complin

debug_gdb: CPPFLAGS += -ggdb3
debug_gdb: cleanlin complin

debug: debug_gdb

clean32:
	$(DELETE) $(ARCH_32_NAME)

clean64:
	$(DELETE) $(ARCH_64_NAME)

cleanlin:
	$(DELETE) $(LINUX_NAME)

clean:
	$(DELETE) $(OBJ)

fclean:	clean	clean32	clean64	cleanlin

re: fclean allplat

windows: comp64

xp: comp32

linux: complin

auteur:
	echo $(USER) > auteur

.PHONY: \
 comp32 comp64 complin all allplat debug_valgrind debug_gdb debug\
 clean32 clean64 cleanlin clean fclean re windows xp linux auteur help
