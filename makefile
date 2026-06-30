# Compiler
CC = gcc
CFLAGS = -c

ODIR = output

# Root directory
ROOT_DIR = ti

# MMWavelink
MMWLINK_IDIR = $(ROOT_DIR)/mmwavelink/src

mmwlink:
	@$(CC) $(CFLAGS) $(MMWLINK_IDIR)/*.c


# MMWave Ethernet
MMWETH_IDIR = $(ROOT_DIR)/ethernet/src

mmwethernet:
	@$(CC) $(CFLAGS) $(MMWETH_IDIR)/*.c


mmwave: mmwlink mmwethernet
	@$(CC) $(CFLAGS) $(ROOT_DIR)/mmwave/*.c

cliopt:
	@$(CC) $(CFLAGS) opt/*.c

tomlconfig:
	@$(CC) $(CFLAGS) toml/*.c

# Build all
all: mmwlink mmwethernet mmwave cliopt tomlconfig
	@$(CC) $(CFLAGS) *.c
	@$(CC) -o mmwave *.o -lpthread -lm
	@rm -f *.o

build: all

install: all
	@sudo cp -f ./mmwave /usr/bin
	@rm -f ./mmwave

clean:
	@rm -f *.o
	@rm -f mmwave
