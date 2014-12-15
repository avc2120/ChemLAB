ChemLAB: Chemical Equation Language
=======

*Alice Chang, Gabriel Lu, Martin Ong*

## Test
To test, run `./test.sh`

## Compile and Run
`make` creates an executable `./chemlab`

`./chemlab` takes in 1 command line argument which specifies the ChemLAB file: `<filename>.chem`. It then compiles the ChemLab file into java bytecode, which is then executed on a Java virtual machine.

Ex. `./chemlab test.chem`
