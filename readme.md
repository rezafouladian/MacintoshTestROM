Example code for building a diagnostic/test ROM to be executed at initial startup when added to a Macintosh computer at the appropriate location.

The template file is [TestROMTemplate.s](TestROMTemplate.s)

To use the ROM in physical hardware, you need to add ROM to the system and have it respond at the proper memory address, typically `0x00F80000` or `0x58000000` depending on the machine.

You can also try out the test ROM in the [Snow Emulator](https://snowemu.com) ([Github](https://github.com/twvd/snow)).

## Building

Included is an example script to build a binary using vasm. 

```
vasmm68k_mot -Fbin -o test_rom.bin -nosym TestROMTemplate.s -sc -DMacSE
```

Breaking down the individual parts of the command:
```
vasmm68k_mot -Fbin -o output_file.bin -nosym input_file.s -sc -DMacSE

"-Fbin" - Tells the assembler to output a binary

"-o output_file.bin" - Tells the assembler to save the file as "output_file.bin"

"-nosym" - Removes all symbols from the output file

"input_file.s" - The input file to build from

"-sc" - "Small code" mode. Optional.

"-DMacSE" - Sets the "MacSE" option to 1. 
The machine options are:
PreMacPlus
MacPlus
MacSE
Portable
MacII
SE30
```