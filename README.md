# About
LHS is one library of Sandia National Laboratory's Dakota package. LHS is licensed as [LGPL-2.1-or-later](https://dakota.sandia.gov/content/packages/lhs)

## To build lhs on Windows:
1. download mingw at http://www.mingw.org/wiki/Getting_Started
2. install and add the "bin" folder in mingw installation to path setting (e.g. set path = %PATH%;c:\mingw\bin)
3. install gfortran per "mingw-get install fortran gdb"
4. open a command window in the lhs\src folder
5. run "mingw32-make" and lhs.exe should be made in the current folder
6. copy lhs.exe to deploy\runtime\bin folder in the SAM executable distribution

## To build lhs on linux and macOS
1. make sure gcc and gfortran are installed on your system
2. run "make" in the lhs/src folder and lhs.bin should be made in the current folder
3. the lhs.bin file will be copied to the SAM distribution when make is issued in SAMnt
