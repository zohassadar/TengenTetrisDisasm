tetris_obj := main.o header.o constants.o tetris-ram.o entry.o
nesChrEncode := python3 tools/nes-util/nes_chr_encode.py

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: clean tools

build: tetris.nes

compare: tetris.nes
	sha1sum -c tetris.sha

disassembly:
	da65 -i main.infofile
	sed -i 2d main.asm		# remove date from output
	awk -f tetris-ram.awk main.infofile > tetris-ram.asm
	bash addrs.sh
	make compare

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools/cTools/,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools/cTools/))
endif

%.o: dep = $(shell tools/cTools/scan_includes $(@D)/$*.asm)

$(tetris_obj): %.o: %.asm $$(dep)
	ca65 -g --debug-info $*.asm -o $@

tetris.nes: tetris.nes.cfg entry.o tetris-ram.o
	ld65  -Ln $(basename $@).lbl --dbgfile $(basename $@).dbg -C $^ -o $@

clean:
	rm -f tetris.nes *.dbg *.o *.lbl gfx/*.chr

%.chr: %.png
	$(nesChrEncode) $< $@
