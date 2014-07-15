CFLAGS=-O2
IVFC=gfortran
TARGET=lhs.bin
OBJ=\
	KILLFILE.o\
	Parms.o\
	Cparam.o\
	CSAMP.o\
	CWORKX.o\
	CWORKC.o\
	MISCMOD.o\
	CRANK.o\
	BETAFN.o\
	BETAIC.o\
	BETALN.o\
	Banner.o\
	Beta.o\
	Binom.o\
	CCMATR.o\
	CHLSKY.o\
	CORCAL.o\
	COROUT.o\
	Chkdat.o\
	Chkdim.o\
	Chkemp.o\
	Chkstr.o\
	Chkzro.o\
	Cmcrd.o\
	Cumulc.o\
	Cumuld.o\
	DATOUT.o\
	DISTNM.o\
	DMFSD.o\
	DSINV.o\
	Datsqz.o\
	ENTRPF.o\
	ERRGET.o\
	ERSTGT.o\
	ERXSET.o\
	Entrpy.o\
	Errchk.o\
	Expon.o\
	FACTOR.o\
	FACTR2.o\
	FILELENG.o\
	FILEOC.o\
	FINDIT.o\
	FINVNOR.o\
	FLNAME.o\
	GAMMAB.o\
	Gamma.o\
	Gammam.o\
	Geom.o\
	HISTO.o\
	HPSRT.o\
	HSTOUT.o\
	HYPGEO.o\
	Hgeom.o\
	IGAUS1.o\
	IGAUSF.o\
	IMTQL2.o\
	INTERP.o\
	INTRPD.o\
	Igaus.o\
	LJUST.o\
	Lhs.o\
	Lhsdrv.o\
	Lread.o\
	MATINV.o\
	MIX.o\
	Nbinom.o\
	Newcrd.o\
	Normal.o\
	OUTDAT.o\
	Outcrd.o\
	PMTRX.o\
	Pareto.o\
	Poison.o\
	Posdef.o\
	RANKER.o\
	RIERFC1.o\
	RMCNP.o\
	RMCNPI.o\
	RNUM1.o\
	Rdpar.o\
	Rdpar2.o\
	Read.o\
	SETDEF.o\
	SIFT.o\
	Samout.o\
	Sspev.o\
	TQLRAT.o\
	TRBAK3.o\
	TRED3.o\
	Table.o\
	Triang.o\
	UNIFRM.o\
	VIF.o\
	WRTCRD.o\
	Weibul.o\
	Wrtpar.o

%.o : %.for
	$(IVFC) $(CFLAGS) -c $<

%.o : %.FOR
	$(IVFC) $(CFLAGS) -c $<

$(TARGET) : $(OBJ)
	$(IVFC) -o $@ $^

clean:
	rm -f *.o $(TARGET) *.mod

