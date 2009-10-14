C     Last change:  S    17 Feb 98    1:18 pm
C****************************************************************
C SUBROUTINE ERRCHK IS AN ERROR CHECKING ROUTINE USED IN
C GENERATING A BETA DISTRIBUTION
C
      SUBROUTINE ERRCHK(NCHARS,NARRAY)
C     INCLUDE 'KILLFILE.INC'                                            GDW-96  
      USE KILLFILE                      
C
C     SANDIA MATHEMATICAL PROGRAM LIBRARY
C     APPLIED MATHEMATICS DIVISION 2642
C     SANDIA LABORATORIES
C     ALBUQUERQUE, NEW MEXICO 87115
C
C     SIMPLIFIED VERSION FOR STAND-ALONE USE.     APRIL 1977
C     UPDATED - GDW - 11/20/91
C
C     ABSTRACT
C         THE ROUTINES ERRCHK, ERXSET, AND ERRGET TOGETHER PROVIDE
C         A UNIFORM METHOD WITH SEVERAL OPTIONS FOR THE PROCESSING
C         OF DIAGNOSTICS AND WARNING MESSAGES WHICH ORIGINATE
C         IN THE MATHEMATICAL PROGRAM LIBRARY ROUTINES.
C         ERRCHK IS THE CENTRAL ROUTINE, WHICH ACTUALLY PROCESSES
C         MESSAGES.
C
C     DESCRIPTION OF ARGUMENTS
C         NCHARS - NUMBER OF CHARACTERS IN HOLLERITH MESSAGE.
C                  IF NCHARS IS NEGATED, ERRCHK WILL UNCONDITIONALLY
C                  PRINT THE MESSAGE AND STOP EXECUTION.  OTHERWISE,
C                  THE BEHAVIOR OF ERRCHK MAY BE CONTROLLED BY
C                  AN APPROPRIATE CALL TO ERXSET.
C         NARRAY - NAME OF CHARACTER VARIABLE CONTAINING THE MESSAGE,
C                  OR ELSE A LITERAL CHARACTER CONSTANT CONTAINING
C                  THE MESSAGE.  BY CONVENTION, ALL MESSAGES SHOULD
C                  BEGIN WITH *IN SUBNAM, ...*, WHERE SUBNAM IS THE
C                  NAME OF THE ROUTINE CALLING ERRCHK.
C
C     EXAMPLES
C         1. TO ALLOW CONTROL BY CALLING ERXSET, USE
C            CALL ERRCHK(30,'IN QUAD, INVALID VALUE OF ERR.')
C         2. TO UNCONDITIONALLY PRINT A MESSAGE AND STOP EXECUTION, USE
C            CALL ERRCHK(-30,'IN QUAD, INVALID VALUE OF ERR')
C
C
C
C     ERRCHK USES SUBROUTINES ERRGET, ERRPRT, ERXSET, ERSTGT
C
      CHARACTER*160 NARRAY
C
      CALL ERRGET(NF,NT)
      If(KLLERR) Return
C
C     -- IF ERRCHK WAS CALLED WITH NEGATIVE CHARACTER COUNT, SET FATAL FLAG
      IF (NCHARS.LT.0) THEN
         NF = -1
         NCHTMP = -NCHARS
      END IF
C
C     -- IF MESSAGES ARE TO BE SUPPRESSED, RETURN
      IF (NF.EQ.0) RETURN
C
C     -- IF CHARACTER COUNT IS INVALID, STOP
      IF (NCHARS.EQ.0) THEN
         WRITE(6,5)
         WRITE(99,5)
    5    FORMAT(/,' ERRCHK WAS CALLED INCORRECTLY.')
         KLLERR = .TRUE.
         RETURN
      END IF
C
C     -- PRINT MESSAGE
      WRITE(6,8) NARRAY(1:NCHTMP)
    8 FORMAT (1X,A)
C
C     -- IF LAST MESSAGE, SAY SO
      IF (NF.EQ.1) WRITE(6,10)
   10 FORMAT (' ERRCHK MESSAGE LIMIT REACHED.')
C
C     -- DECREMENT MESSAGE COUNT
C     -- THEN, IF ALL IS WELL, RETURN
      IF (NF.GT.0) THEN
         NF = NF-1
         CALL ERXSET(NF,NT)
         If(KLLERR) Return
         RETURN
      END IF
C
C     -- IF THIS MESSAGE IS SUPPRESSABLE BY AN ERXSET CALL,
C     -- THEN EXPLAIN ERXSET USAGE.
      IF (NCHARS.GT.0) WRITE(6,15)
      WRITE(6,20)
      WRITE(99,20)
      KLLERR = .TRUE.
      RETURN
C
   15 FORMAT (/' *** NOTE ***',
     1/' TO MAKE THE ERROR MESSAGE PRINTED ABOVE BE NONFATAL,',
     2/' OR TO SUPPRESS THE MESSAGE COMPLETELY,',
     3/' INSERT AN APPROPRIATE CALL TO ERXSET',
     4 ' AT THE START OF YOUR PROGRAM.',
     5/' FOR EXAMPLE, TO PRINT UP TO 10 NONFATAL WARNING MESSAGES, USE',
     6/'          CALL ERXSET(10,0)'    )
C
   20 FORMAT (/' PROGRAM ABORT DUE TO ERROR.')
C
      END
