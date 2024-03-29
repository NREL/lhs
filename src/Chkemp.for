C     Last change:  S    17 Feb 98    1:22 pm
C****************************************************************
C SUBROUTINE CHKEMP CHECKS THE INPUT DATA FROM THE EMPIRICAL
C DISTRIBUTION FUNCTIONS AND WRITES IT TO UNIT 8
C
      SUBROUTINE CHKEMP ( PARM, PRBZ, XVLZ, NP, MSIZE)
C     INCLUDE 'KILLFILE.INC'                                            GDW-96  
      USE KILLFILE                      
C
      CHARACTER PARM*(*),PCUM*10,PLIN*6,PLOG*11,PCONT*11
      DIMENSION PRBZ(MSIZE), XVLZ(MSIZE)
      PARAMETER (PCUM='CUMULATIVE',PLIN='LINEAR',PLOG='LOGARITHMIC',
     1           PCONT='CONTINUOUS')
C
C     --- FIRST CONSIDER CUMULATIVE DISTRIBUTION FUNCTIONS, THEN
C     --- FREQUENCY, HISTOGRAM, OR DENSITY FUNCTIONS.
C
      IF (INDEX(PARM,PCUM) .NE. 0  .OR.  INDEX(PARM,PLIN) .NE. 0  .OR.
     1    INDEX(PARM,PLOG) .NE. 0 ) THEN
C
C        ***** FOR CUMULATIVE DISTRIBUTIONS: *****
C
C        --- FOR CONTINUOUS DISTRIBUTIONS, THE FIRST AND LAST PROBABILITIES
C        --- MUST BE 0 AND 1, RESPECTIVELY.  FOR DISCRETE DISTRIBUTIONS,
C        --- THE FIRST PROBABILITY MUST BE POSITIVE AND THE LAST 1.
C
         IF (INDEX(PARM,PCONT) .NE. 0) THEN
            IF (ABS(PRBZ(1)) .GT. 0.00001) THEN
               WRITE (6,9000) PARM,PRBZ(1)
               WRITE (99,9000) PARM,PRBZ(1)
               KLLERR = .TRUE.
               RETURN
            ELSE
               PRBZ(1)=0.0
            END IF
C
         ELSE
            IF (PRBZ(1) .LE. 0.0) THEN
               WRITE (6,9007) PARM,PRBZ(1)
               WRITE (99,9007) PARM,PRBZ(1)
               KLLERR = .TRUE.
               RETURN
            END IF
         END IF
C
         IF (ABS(PRBZ(NP)-1.0) .GT. 0.00001) THEN
            WRITE (6,9001) PARM,PRBZ(NP)
            WRITE (99,9001) PARM,PRBZ(NP)
            KLLERR = .TRUE.
            RETURN
         ELSE
            PRBZ(NP)=1.0
         END IF
C
C        --- IF THIS USES LOGARITHMIC INTERPOLATION, THE FIRST XVLZ
C        --- (AND, HENCE, ALL XVLZ) MUST BE GREATER THAN ZERO
C
         IF (INDEX(PARM,PLOG) .GT. 0) THEN
            IF (XVLZ(1) .LE. 0) THEN
               WRITE (6,9005) PARM,XVLZ(1)
               WRITE (99,9005) PARM,XVLZ(1)
               KLLERR = .TRUE.
               RETURN
            END IF
         END IF
C
C        --- THE PRBZ AND XVLZ VALUES MUST INCREASE MONOTONICALLY
C        --- AND THE VALUES OF PRBZ MUST BE BETWEEN ZERO AND ONE
C
         DO 100 I=2, NP
C
            I1=I-1
            IF (PRBZ(I) .LE. PRBZ(I1)) THEN
               WRITE (6,9002) PARM,PRBZ(I1),PRBZ(I)
               WRITE (99,9002) PARM,PRBZ(I1),PRBZ(I)
               KLLERR = .TRUE.
               RETURN
C
            ELSE IF (XVLZ(I) .LE. XVLZ(I1)) THEN
               WRITE (6,9003) PARM,XVLZ(I1),XVLZ(I)
               WRITE (99,9003) PARM,XVLZ(I1),XVLZ(I)
               KLLERR = .TRUE.
               RETURN
C
            ELSE IF (PRBZ(I) .LT. 0.0  .OR.  PRBZ(I) .GT. 1.0) THEN
               WRITE (6,9004) PARM,PRBZ(I)
               WRITE (99,9004) PARM,PRBZ(I)
               KLLERR = .TRUE.
               RETURN
C
            END IF
C
  100    CONTINUE
C
C
      ELSE
C
C        ***** FOR FREQUENCY, DENSITY, AND HISTOGRAM DISTRIBUTIONS: *****
C
C        --- CHECK THAT ALL FREQUENCIES (PRBZ) ARE GREATER THAN ZERO
C        --- AND THAT THE VALUES (XVLZ) INCREASE MONOTONICALLY
C
         IF (PRBZ(1) .LE. 0.0) THEN
            WRITE (6,9006) PARM,PRBZ(1)
            WRITE (99,9006) PARM,PRBZ(1)
            KLLERR = .TRUE.
            RETURN
         END IF
C
         DO 200 I=2, NP
C
            I1=I-1
            IF (XVLZ(I) .LE. XVLZ(I1)) THEN
               WRITE (6,9003) PARM,XVLZ(I1),XVLZ(I)
               WRITE (99,9003) PARM,XVLZ(I1),XVLZ(I)
               KLLERR = .TRUE.
               RETURN
C
            ELSE IF (PRBZ(I) .LE. 0.0) THEN
               WRITE (6,9006) PARM,PRBZ(I)
               WRITE (99,9006) PARM,PRBZ(I)
               KLLERR = .TRUE.
               RETURN
C
            END IF
C
  200    CONTINUE
C
C        --- CONVERT THE FREQUENCIES TO A CUMULATIVE DISTRIBUTION.
C        --- FOR THE PATHOLOGICAL CASE WHERE NP=2 IN A CONTINUOUS
C        --- FREQUENCY DISTRIBUTION, ADD A THIRD POINT WITH ZERO
C        --- FREQUENCY HALF WAY BETWEEN THE OTHER TWO AND CONSIDER
C        --- IT LIKE A THREE POINT DISTRIBUTION.
C
         IF(INDEX(PARM,PCONT) .NE. 0) THEN
            IF (NP .EQ. 2) THEN
               XVLZ(3)=XVLZ(2)
               XVLZ(2)=(XVLZ(1)+XVLZ(3))/2.0
               PRBZ(3)=PRBZ(2)
               PRBZ(2)=0.0
               NP=3
            END IF
C
C           --- TAKE CARE OF THE END POINTS FOR THE CONTINUOUS CASE
C           --- TO MAKE THE FUNCTION BEHAVE MORE LIKE A DENSITY FUNCTION
            PRBZ(1)=PRBZ(1)/2.0
            PRBZ(NP)=PRBZ(NP)/2.0
         END IF
C
C        --- NORMALIZE THE FREQUENCY (PRBZ) ARRAY
C
         TOTAL=0.0
         DO 210 I=1, NP
            TOTAL=TOTAL+PRBZ(I)
  210    CONTINUE
C
         DO 220 I=1, NP
            PRBZ(I)=PRBZ(I)/TOTAL
  220    CONTINUE
C
C        --- INTEGRATE THE FREQUENCIES IN THE PRBZ ARRAY AND PLACE
C        --- THE RESULTING CUMULATIVE PROBABILITY BACK INTO PRBZ
C
         IF (INDEX(PARM,PCONT) .NE. 0) THEN
C
C           -- CONTINUOUS DISTRIBUTION
            TOTAL=PRBZ(1)
            PRBZ(1)=0.0
            DO 230 I=2, NP-1
               FSAVE=PRBZ(I)/2.0
               TOTAL=TOTAL+FSAVE
               PRBZ(I)=TOTAL
               TOTAL=TOTAL+FSAVE
  230       CONTINUE
            PRBZ(NP)=1.0
C
         ELSE
C
C           -- DISCRETE DISTRIBUTION
            TOTAL=PRBZ(1)
            DO 240 I=2, NP-1
               TOTAL=TOTAL+PRBZ(I)
               PRBZ(I)=TOTAL
  240       CONTINUE
            PRBZ(NP)=1.0
C
         END IF
C
      END IF
C
C     --- WRITE THE CHECKED DISTRIBUTION INFORMATION TO UNIT 8 AND RETURN
C
      WRITE (8) NP
      WRITE (8) (XVLZ(I),PRBZ(I),I=1,NP)
C
      RETURN
C
 9000 FORMAT('1',5X,'THE FIRST PROBABILITY INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST BE ZERO.',/,5X,'HOWEVER, A ',
     2       'PROBABILITY OF ',G20.10,' WAS FOUND.')
 9001 FORMAT('1',5X,'THE LAST PROBABILITY INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST BE 1.0',/,5X,'HOWEVER, A ',
     2       'PROBABILITY OF ',G20.10,' WAS FOUND.')
 9002 FORMAT('1',5X,'THE PROBABILITIES INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST INCREASE MONOTONICALLY.',/,5X,
     2       'THE FOLLOWING NON-INCREASING PROBABILITY VALUES WERE ',
     3       'FOUND: ',/,20X,G20.10,' AND ',G20.10)
 9003 FORMAT('1',5X,'THE VALUES INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST INCREASE MONOTONICALLY.',/,5X,
     2       'THE FOLLOWING NON-INCREASING DISTRIBUTION VALUES WERE ',
     3       'FOUND: ',/,20X,G20.10,' AND ',G20.10)
 9004 FORMAT('1',5X,'ALL PROBABILITIES INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST BE BETWEEN ZERO AND ONE.',/,5X,
     2       'THE FOLLOWING PROBABILITY WAS FOUND TO BE OUTSIDE ',
     3       'OF THAT RANGE: ',G20.10)
 9005 FORMAT('1',5X,'THE VALUES INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST ALL BE POSITIVE.',/,5X,
     2       'THE FOLLOWING NON-POSITIVE VALUE WAS FOUND: ',G20.10)
 9006 FORMAT('1',5X,'ALL FREQUENCIES INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST BE GREATER THAN ZERO.',/,5X,
     2       'THE FOLLOWING FREQUENCY WAS FOUND TO BE OUTSIDE ',
     3       'OF THAT RANGE: ',G20.10)
 9007 FORMAT('1',5X,'THE FIRST PROBABILITY INPUT FOR A ',A,
     1       ' DISTRIBUTION MUST BE GREATER THAN ZERO.',/,5X,
     2       'THE FOLLOWING FREQUENCY WAS FOUND TO BE OUTSIDE ',
     3       'OF THAT RANGE: ',G20.10)
C
      END
