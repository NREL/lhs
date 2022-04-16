#${ARCH}  is either x86_64 or arm64 to build universal binary from Makefile

all:
	 make -f Makefile-lhs ARCH=arm64
	 rm *.mod
	 rm *.o
	 make -f Makefile-lhs ARCH=x86_64
	 rm *.mod
	 rm *.o
	 lipo -create -output lhs.bin lhs_x86_64.bin lhs_arm64.bin
	 cp lhs.bin ../../SAM/Sandia/osx

clean:
	$(RM) *.o *.bin *.mod

