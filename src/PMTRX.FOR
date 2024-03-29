C****************************************************************
C SUBROUTINE PMTRX PRINTS OUT A CORRELATION MATRIX
C
      SUBROUTINE PMTRX(NC,IFLAG)
C     INCLUDE 'KILLFILE.INC'                                            GDW-96  
      USE KILLFILE                      
C
C     INCLUDE 'PARMS.INC'                                               GDW-96  
      USE PARMS                         
C     INCLUDE 'CPARAM.INC'                                              GDW-96  
      USE CPARAM                        
C     INCLUDE 'CCMATR.INC'                                              GDW-96  
      USE CCMATR                        
C
      PARAMETER (NROW=28)
      PARAMETER (NCOL=15)
C
      LOC1(I,J)=J+(I*I-I)/2
C
      I=1
      I1=1
      I2=NROW
      NPROW=NC/NROW
      IF (NPROW*NROW.NE.NC) NPROW=NPROW+1
      NPCOL=NC/NCOL
      IF (NPCOL*NCOL.NE.NC) NPCOL=NPCOL+1
      DO 100 NR=1,NPROW
      J1=1
      J2=NCOL
      DO 90 IC=1,NPCOL
      IF (J1.GT.I2) GO TO 90
      IF (IFLAG.EQ.2) GO TO 10
      IF (IFLAG.EQ.3) GO TO 20
      IF(IFLAG.EQ.4)GO TO 20
      WRITE(6,180)TITLE
      IF(IRS.EQ.0)WRITE(6,110)I
      IF(IRS.NE.0)WRITE(6,115)I
      GO TO 30
   10 WRITE(6,180)TITLE
      IF(IRS.EQ.0)WRITE(6,120)I
      IF(IRS.NE.0)WRITE(6,125)I
      GO TO 30
   20 WRITE(6,180)TITLE
      IF(IFLAG.EQ.3)WRITE(6,130)I
      IF(IFLAG.EQ.4)WRITE(6,190)I
   30 IF (NC.LT.I2) I2=NC
      IF (NC.LT.J2) J2=NC
      DO 60 K=I1,I2
      K1=K
      IF (K.GE.J1) GO TO 40
      WRITE(6,140)
      GO TO 60
   40 IF (K.GT.J2) GO TO 50
      WRITE(6,150)LCM(K),(CORR(LOC1(K,J)),J=J1,K)
      GO TO 60
   50 WRITE(6,150)LCM(K),(CORR(LOC1(K,J)),J=J1,J2)
   60 CONTINUE
      IF (K1.LT.J2) GO TO 70
      WRITE(6,160)(LCM(II),II=J1,J2)
      WRITE(6,170)
      GO TO 80
   70 WRITE(6,160)(LCM(II),II=J1,K1)
      WRITE(6,170)
   80 CONTINUE
      J1=J1+NCOL
      J2=J2+NCOL
      I=I+1
   90 CONTINUE
      I1=I1+NROW
      I2=I2+NROW
  100 CONTINUE
      RETURN
  110 FORMAT('0','CORRELATIONS AMONG INPUT VARIABLES CREATED BY THE ',
     1       'LATIN HYPERCUBE SAMPLE FOR RAW DATA',30X,'PAGE ',I3)
  115 FORMAT('0','CORRELATIONS AMONG INPUT VARIABLES CREATED BY THE ',
     1       'RANDOM SAMPLE FOR RAW DATA',40X,'PAGE ',I3)
  120 FORMAT('0','CORRELATIONS AMONG INPUT VARIABLES CREATED BY THE ',
     1       'LATIN HYPERCUBE SAMPLE FOR RANK DATA',30X,'PAGE ',I3)
  125 FORMAT('0','CORRELATIONS AMONG INPUT VARIABLES CREATED BY THE ',
     1       'RANDOM SAMPLE FOR RANK DATA',40X,'PAGE ',I3)
  130 FORMAT('0','INPUT RANK CORRELATION MATRIX',95X,'PAGE ',I3)
  140 FORMAT('0')
  150 FORMAT('0',I5,15(F8.4))
  160 FORMAT('0',5X,15I8)
  170 FORMAT('0','VARIABLES')
  180 FORMAT('1',A)
  190 FORMAT('0','ADJUSTED RANK CORRELATION MATRIX',92X,'PAGE ',I3)
      END
