C****************************************************************
C FUNCTION RMCNP RETURNS THE NEXT PSEUDO-RANDOM NUMBER.
C IT IS PART OF THE MCNP RANDOM NUMBER GENERATOR.
C
      DOUBLE PRECISION FUNCTION RMCNP(ISEED)
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      COMMON/MCNPRN/RANS,RANB,RANI,RANJ,NRN
C
C ----------------------------------------------------------------------
C
      PARAMETER (P=16777216.,Q=1./P,R=Q*Q,GB=1136868.,GS=6328637.)
C
C     -- THIS ROUTINE IS PORTABLE ONLY IF GB+GS<2**24
C
      A=GS*RANS
      B=GB*RANS+GS*RANB+AINT(A*Q)
      RANS=A-INT(A*Q)*P
      RANB=B-INT(B*Q)*P
      RMCNP=(RANB*P+RANS)*R
      NRN=NRN+1
C     -- PUT NRN IN ISEED
      ISEED = NRN
C
      RETURN
C
      END
