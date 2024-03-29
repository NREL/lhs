C     Last change:  S    17 Feb 98    1:26 pm
C****************************************************************
C SUBROUTINE CHKDIM CHECKS TO SEE IF PROGRAM DIMENSIONS HAVE BEEN
C EXCEEDED
C
      SUBROUTINE CHKDIM(IOPT,NREQ,NMX,PCHR,LCHR)
C     INCLUDE 'KILLFILE.INC'                                            GDW-96  
      USE KILLFILE                      
C
C     INCLUDE 'PARMS.INC'                                               GDW-96  
      USE PARMS                         
C     INCLUDE 'CPARAM.INC'                                              GDW-96  
      USE CPARAM                        
C
C     These statements removed to make modules work - GDW-96
C     CHARACTER*(LENC) CRDSTR(NVAR)
C     COMMON/CHRCRD/CRDSTR
      USE CHRCRD
C     COMMON/OBSTR/NSTR,NOBSTR(NVAR)
      USE OBSTR
C
      CHARACTER*(*) PCHR,LCHR
C
      IF (IOPT .EQ. 1) THEN
         IF(NREQ.GT.NMX)THEN
            WRITE(6,9001)PCHR,NREQ,LCHR,NMX,LCHR,LCHR
            WRITE(99,9001)PCHR,NREQ,LCHR,NMX,LCHR,LCHR
            KLLERR = .TRUE.
            RETURN
         ENDIF
         RETURN
      END IF
C
      IF (NREQ .GT. NMX) THEN
         WRITE(6,9002)NREQ,NMX
         WRITE(99,9002)NREQ,NMX
         KLLERR = .TRUE.
         RETURN
      ENDIF
C
      IF (N*NV .GT. MAXNNV) THEN
         NNV=N*NV
         WRITE (6,9005) MAXNNV, NNV, NV, N
         WRITE (99,9005) MAXNNV, NNV, NV, N
         KLLERR = .TRUE.
         RETURN
      END IF
C
      IERR=0
      DO 200 I=1,NSTR
         IF(NOBSTR(I).NE.N)THEN
            WRITE(6,9003)NOBSTR(I),N,CRDSTR(I)
            IERR=1
         ENDIF
  200 CONTINUE
C
      IF (IERR .EQ. 1) THEN
         KLLERR = .TRUE.
         RETURN
      ENDIF
C
      RETURN
C
 9001 FORMAT('1',5X,'THE PARAMETER CARD ',A,'REQUESTED ',I4,1X,A,/,
     1       6X,'ONLY ',I4,1X,A,' ARE CURRENTLY PERMITTED',/,6X,
     2       'PLEASE CONSULT THE USER MANUAL FOR INSTRUCTIONS ON ',
     3       'HOW TO ALLOW MORE ',A)
 9002 FORMAT('1',5X,'THE NUMBER OF VARIABLES REQUESTED ',I3,/,6X,
     1       ' EXCEEDS THE MAXIMUM NUMBER OF VARIABLES CURRENTLY ',
     2       'PERMITTED ',I3,/,6X,'PLEASE CONSULT THE USER MANUAL FOR',
     3       'INSTRUCTIONS ON HOW TO ALLOW MORE VARIABLES')
 9003 FORMAT('1',5X,'THE FOLLOWING DISTRIBUTION CARD REQUESTED ',I4,
     1       ' OBSERVATIONS',/,6X,'HOWEVER THE NOBS PARAMETER CARD ',
     2       'REQUESTED ',I4,' OBSERVATIONS',/,6X,'THIS DISCREPANCY ',
     3       'MUST BE RESOLVED BEFORE PROCESSING CAN CONTINUE',//,3X,
     4       '***',A,'***')
 9005 FORMAT('1',5X,'THE MAXIMUM SAMPLE ARRAY SIZE WILL BE EXCEEDED.',
     1      //,5X,'THIS PARAMETER IS CURRENTLY SET TO ',I5,//,5X,
     2      'THIS INPUT DATA SET REQUIRES A MAXIMUM ',
     3      'SAMPLE ARRAY SIZE OF AT LEAST ',I5,
     4      /,5X,'THIS IS CALCULATED AS THE PRODUCT OF THE NUMBER OF ',
     5      'VARIABLES (',I5,')',/,5X,'AND THE NUMBER OF ',
     6      'OBSERVATIONS (',I5,') REQUESTED IN THIS INPUT SET.',//,5X,
     7      'PLEASE CONSULT THE USER MANUAL FOR INSTRUCTIONS ON HOW ',
     8      'TO ALLOCATE MORE SAMPLE ARRAY SPACE.')
C
      END
