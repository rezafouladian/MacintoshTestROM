Example code for building a diagnostic/test ROM to be executed at initial startup when added to a Macintosh computer at the appropriate location.

The template file is [TestROMTemplate.s](TestROMTemplate.s)

To use the ROM in physical hardware, you need to add ROM to the system and have it respond at the proper memory address, typically `0x00F80000` or `0x58000000` depending on the machine.  
If you can attach the ROM to the bus and add logic for it to respond at the proper address, you don't need to make any other modifications to the computer.

You can also try out the test ROM in the [Snow Emulator](https://snowemu.com) by twvd ([Github](https://github.com/twvd/snow)).

## Entry Points

The initial entry point is checked at `0x00F80000`, and if the magic string (`TROMCode`) is there then the computer will jump to the location at `0x00F80004`.  
This happens very early on in startup for most machines, so expect nothing to be initialized.

There is a second entry point at `0x00F80080` which is typically after the initial tests have run.  

The Macintosh Plus also has yet another check at `0x00F80088`.

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