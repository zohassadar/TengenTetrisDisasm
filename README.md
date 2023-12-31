# Tengen NES Tetris Disassembly

Todo:
* Find labels related to music and why it doesn't repeat when code is shifted
* Testing framework
* Identify and label unused code/data
* Clean up labels
* add logic to header.asm
* replace known values with constants
* add comments where necessary to explain game logic
* break out nametables into text format


## Build Requirements

* gcc
* make
* cc65
* python (with pillow library)

## Disassemble

Requires a backup of the original game with the filename `clean.nes` in the project root directory.  

main.asm is dynamically generated using main.infofile.  This means comments outside of labels and constants for specific values can't be added yet (unless someone knows a trick and wants to tell me).  To update, add label information to main.infofile and run `make disassembly`.  This will update main.asm with the new labels.  

## Build

`make`

This will ouput a file `tetris.nes` with the following:

```
sha1sum: 34113a102ccfff6a859f8ebb66c24260d43ec7ab
md5sum: 1bcb1795a0feed766d6d0681196662fb
```

## Validate

`make compare`

## Thanks
[threecreepio](https://github.com/threecreepio/da65ify) getting this started

[CelestialAmber](https://github.com/CelestialAmber/TetrisNESDisasm) disassembly structure

[ejona86](https://github.com/ejona86/taus) info file structure and tetris-ram.awk

[qalle2](https://github.com/qalle2/nes-util) CHR tools

[kirjavascript](https://github.com/kirjavascript/TetrisGYM) borrowed bits
