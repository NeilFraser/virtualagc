### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	MYSUBS.agc
## Purpose:	A section of Manche72 revision 3.
##		It is part of the reconstructed source code for the final, flown
##		release of the software for the Command Module's (CM) Apollo
##		Guidance Computer (AGC) for Apollo 13. No original listings
##		of this program are available; instead, this file was recreated
##		from a reconstructed copy of Comanche 072. It has been adapted
##		such that the resulting bugger words exactly match those
##		specified for Manche72 revision 3 in NASA drawing 2021153G,
##		which gives relatively high confidence that the reconstruction
##		is correct.
## Assembler:	yaYUL
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo/index.html
## Mod history:	2024-05-19 MAS	Created from Comanche 072.

		BANK	20
		SETLOC	MYSUBS
		BANK
		
		EBANK=	KMPAC
SPCOS1		EQUALS	SPCOS
SPSIN1		EQUALS	SPSIN
SPCOS2		EQUALS	SPCOS
SPSIN2		EQUALS	SPSIN

		COUNT	21/DAPMS
		
# ONE AND ONE HALF PRECISION MULTIPLICATION ROUTINE

SMALLMP		TS	KMPTEMP		# A(X+Y)
		EXTEND
		MP	KMPAC 	+1
		TS	KMPAC 	+1	# AY
		CAF	ZERO
		XCH	KMPAC
		EXTEND
		MP	KMPTEMP		# AX
		DAS	KMPAC		# AX+AY
		TC	Q
		
# SUBROUTINE FOR DOUBLE PRECISION ADDITIONS OF ANGLES
# A AND L CONTAIN A DP(1S) ANGLE SCALED BY 180 DEGS TO BE ADDED TO KMPAC.
# RESULT IS PLACED IN KMPAC.  TIMING = 6 MCT (22 MCT ON OVERFLOW)

DPADD		DAS	KMPAC
		EXTEND
		BZF	TSK 	+1	# NO OVERFLOW
		CCS	KMPAC
		TCF	DPADD+		# + OVERFLOW
		TCF	+2
		TCF	DPADD-		# - OVERFLOW
		CCS	KMPAC 	+1
		TCF	DPADD2+		# UPPER = 0, LOWER +
		TCF	+2
		COM			# UPPER = 0, LOWER -
		AD	POSMAX		# LOWER = 0, A = 0
		TS	KMPAC 	+1	# CAN NOT OVERFLOW
		CA	POSMAX		# UPPER WAS = 0
TSK		TS	KMPAC
		TC	Q
		
DPADD+		AD	NEGMAX		# KMPAC GREATER THAN 0
		TCF	TSK

DPADD-		COM
		AD	POSMAX		# KMPAC LESS THAN 0
		TCF	TSK
		
DPADD2+		AD	NEGMAX		# CAN NOT OVERFLOW
		TS	KMPAC 	+1
		CA	NEGMAX		# UPPER WAS = 0
		TCF	TSK
