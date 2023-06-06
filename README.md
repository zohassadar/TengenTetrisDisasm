# Tengen NES Tetris Disassembly

Currently in development.  Contributions welcome.  

Todo:
* complete info file with as many labels as possible
* identify and label unused code/data


Todo after above is complete:
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

Requires a backup of of the original game with the filename `clean.nes` in the project root directory.  

main.asm is dynamically generated using main.infofile.  This means comments outside of labels and constants for specific values can't be added yet (unless someone knows a trick and wants to tell me).  To update, add label label information to main.infofile.  If label is for a RAM address ($0000-$07FF), update tetris-ram.asm. Then run `make disassembly`.  This will update main.asm with the new labels.  

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

[CelestialAmber](https://github.com/CelestialAmber/TetrisNESDisasm) disassembly structure

[ejona86](https://github.com/ejona86/taus) info file structure

[qalle2](https://github.com/qalle2/nes-util) CHR tools

[kirjavascript](https://github.com/kirjavascript/TetrisGYM) borrowed bits
