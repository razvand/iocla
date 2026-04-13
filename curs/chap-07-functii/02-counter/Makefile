AS = nasm
AFILES = counter.asm
OBJS = $(AFILES:.asm=.o)
BINARIES = $(AFILES:.asm=)
ASFLAGS = -f elf64 -g -F dwarf
LD = gcc
LDFLAGS = -no-pie

.PHONY: all clean

all: $(BINARIES)

$(OBJS): $(AFILES)
	$(AS) $(ASFLAGS) -o $@ $<

$(BINARIES): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f $(OBJS)
	-rm -f $(BINARIES)
	-rm -f *~
