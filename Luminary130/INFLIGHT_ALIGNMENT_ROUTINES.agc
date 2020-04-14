### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	INFLIGHT_ALIGNMENT_ROUTINES.agc
## Purpose:	A section of the reconstructed source code for Luminary 130.
##		This was the original program released for the Apollo 13 LM,
##		although several more revisions would follow. It has been
##		reconstructed from a listing of Luminary 131, from which it
##		differs on only two lines in P70-P71. The difference is
##		described in detail in Luminary memo #129, which was used
##		to perform the reconstruction. This file is intended to be a
##		faithful reconstruction, except that the code format has been
##		changed to conform to the requirements of the yaYUL assembler
##		rather than the original YUL assembler.
## Reference:	pp. 1241-1250
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo/index.html
## Mod history:	06/03/03 RSB.	Began transcribing.
##		05/14/05 RSB.	Corrected website reference above.
##		2017-01-06 RSB	Page numbers now agree with those on the
##				original hardcopy, as opposed to the PDF page
##				numbers in 1701.pdf.
##		2017-02-27 RSB	Proofed comment text using octopus/ProoferComments.
##		2017-03-17 RSB	Comment-text fixes identified in diff'ing
##				Luminary 99 vs Comanche 55.
##		2018-09-04 MAS	Copied from Luminary 131 for Luminary 130.

## Page 1241
		BANK	22
		SETLOC	INFLIGHT
		BANK

		EBANK=	XSM

# CALCGTA COMPUTES THE GYRO TORQUE ANGLES REQUIRED TO BRING THE STABLE MEMBER INTO THE DESIRED ORIENTATION.
#
# THE INPUT IS THE DESIRED STABLE MEMBER COORDINATES REFERRED TO PRESENT STABLE MEMBER COORDINATES.  THE THREE
# HALF-UNIT VECTORS ARE STORED AT XDC, YDC, AND ZDC.
#
# THE OUTPUTS ARE THE THREE GYRO TORQUING ANGLES TO BE APPLIED TO THE Y, Z, AND X GYROS AND ARE STORED DP AT IGC,
# MGC, AND OGC RESPECTIVELY.

		COUNT*	$$/INFLT
CALCGTA		ITA	DLOAD		# PUSHDOWN 00-03, 16D-27D, 34D-37D
			S2		# XDC = (XD1 XD2 XD3)
			XDC		# YDC = (YD1 YD2 YD3)
		PDDL	PDDL		# ZDC = (ZD1 ZD2 ZD3)
			HI6ZEROS
			XDC +4
		DCOMP	VDEF
		UNIT
		STODL	ZPRIME		# ZP = UNIT(-XD3 0 XD1) = (ZP1 ZP2 ZP3)
			ZPRIME

		SR1
		STODL	SINTH		# SIN(IGC) = ZP1
			ZPRIME +4
		SR1
		STCALL	COSTH		# COS(IGC) = ZP3
			ARCTRIG

		STODL	IGC		# Y GYRO TORQUING ANGLE   FRACTION OF REV.
			XDC +2
		SR1
		STODL	SINTH		# SIN(MGC) = XD2
			ZPRIME

		DMP	PDDL
			XDC +4		# PD00 = (ZP1)(XD3)
			ZPRIME +4

		DMP	DSU
			XDC		# MPAC = (ZP3)(XD1)
		STADR
		STCALL	COSTH		# COS(MGC) = MPAC - PD00
			ARCTRIG
## Page 1242
		STOVL	MGC		# Z GYRO TORQUING ANGLE   FRACTION OF REV.
			ZPRIME
		DOT
			ZDC
		STOVL	COSTH		# COS(OGC) = ZP . ZDC
			ZPRIME
		DOT
			YDC
		STCALL	SINTH		# SIN(OGC) = ZP . YDC
			ARCTRIG

		STCALL	OGC		# X GYRO TORQUING ANGLE   FRACTION OF REV.
			S2

## Page 1243
# ARCTRIG COMPUTES AN ANGLE GIVEN THE SINE AND COSINE OF THIS ANGLE.
#
# THE INPUTS ARE SIN/4 AND COS/4 STORED DP AT SINTH AND COSTH.
#
# THE OUTPUT IS THE CALCULATED ANGLE BETWEEN +.5 AND -.5 REVOLUTIONS AND STORED AT THETA.  THE OUTPUT IS ALSO
# AVAILABLE AT MPAC.

ARCTRIG		DLOAD	ABS		# PUSHDOWN  16D-21D
			SINTH
		DSU	BMN
			QTSN45		# ABS(SIN/4) - SIN(45)/4
			TRIG1		# IF (-45,45) OR (135,-135)

		DLOAD	SL1		# (45,135) OR (-135,-45)
			COSTH
		ACOS	SIGN
			SINTH
		STORE	THETA		# X = ARCCOS(COS) WITH SIGN(SIN)
		RVQ

TRIG1		DLOAD	SL1		# (-45,45) OR (135,-135)
			SINTH
		ASIN
		STODL	THETA		# X = ARCSIN(SIN) WITH SIGN(SIN)
			COSTH
		BMN
			TRIG2		# IF (135,-135)

		DLOAD	RVQ
			THETA		# X = ARCSIN(SIN)   (-45,45)

TRIG2		DLOAD	SIGN		# (135,-135)
			HIDPHALF
			SINTH
		DSU
			THETA
		STORE	THETA		# X = .5 WITH SIGN(SIN) - ARCSIN(SIN)
		RVQ			#	(+) - (+) OR (-) - (-)

## Page 1244
# SMNB, NBSM, AND AXISROT, WHICH USED TO APPEAR HERE, HAVE BEEN
# COMBINED IN A ROUTINE CALLED AX*SR*T, WHICH APPEARS AMONG THE POWERED
# FLIGHT SUBROUTINES.

## Page 1245
# CALCGA COMPUTES THE CDU DRIVING ANGLES REQUIRED TO BRING THE STABLE MEMBER INTO THE DESIRED ORIENTATION.
#
# THE INPUTS ARE  1) THE NAVIGATION BASE COORDINATES REFERRED TO ANY COORDINATE SYSTEM.  THE THREE HALF-UNIT
# VECTORS ARE STORED AT XNB, YNB, AND ZNB.  2) THE DESIRED STABLE MEMBER COORDINATES REFERRED TO THE SAME
# COORDINATE SYSTEM ARE STORED AT XSM, YSM, AND ZSM.
#
# THE OUTPUTS ARE THE THREE CDU DRIVING ANGLES AND ARE STORED SP AT THETAD, THETAD +1, AND THETAD +2.

CALCGA		SETPD			# PUSHDOWN 00-05, 16D-21D, 34D-37D
			0
		VLOAD	VXV
			XNB		# XNB = OGA (OUTER GIMBAL AXIS)
			YSM		# YSM = IGA (INNER GIMBAL AXIS)
		UNIT	PUSH		# PD0 = UNIT(OGA X IGA) = MGA

		DOT	ITA
			ZNB
			S2
		STOVL	COSTH		# COS(OG) = MGA . ZNB
			0
		DOT
			YNB
		STCALL	SINTH		# SIN(OG) = MGA . YNB
			ARCTRIG
		STOVL	OGC
			0

		VXV	DOT		# PROVISION FOR MG ANGLE OF 90 DEGREES
			XNB
			YSM
		SL1
		STOVL	COSTH		# COS(MG) = IGA . (MGA X OGA)
			YSM
		DOT
			XNB
		STCALL	SINTH		# SIN(MG) = IGA . OGA
			ARCTRIG
		STORE	MGC

		ABS	DSU
			.166...
		BPL
			GIMLOCK1	# IF ANGLE GREATER THAN 60 DEGREES

CALCGA1		VLOAD	DOT
			ZSM
			0
		STOVL	COSTH		# COS(IG) = ZSM . MGA
			XSM
## Page 1246
		DOT	STADR
		STCALL	SINTH		# SIN(IG) = XSM . MGA
			ARCTRIG

		STOVL	IGC
			OGC
		RTB
			V1STO2S
		STCALL	THETAD
			S2

GIMLOCK1	EXIT
		TC	ALARM
		OCT	00401
		TC	UPFLAG		# GIMBAL LOCK HAS OCCURED
		ADRES	GLOKFAIL

		TC	INTPRET
		GOTO
			CALCGA1

## Page 1247
# AXISGEN COMPUTES THE COORDINATES OF ONE COORDINATE SYSTEM REFERRED TO ANOTHER COORDINATE SYSTEM.
#
# THE INPUTS ARE  1) THE STAR1 VECTOR REFERRED TO COORDINATE SYSTEM A STORED AT STARAD.  2) THE STAR2 VECTOR
# REFERRED TO COORDINATE SYSTEM A STORED AT STARAD +6.  3) THE STAR1 VECTOR REFERRED TO COORDINATE SYSTEM B STORED
# AT LOCATION 6 OF THE VAC AREA.  4) THE STAR2 VECTOR REFERRED TO COORDINATE SYSTEM B STORED AT LOCATION 12D OF
# THE VAC AREA.
#
# THE OUTPUT DEFINES COORDINATE SYSTEM A REFERRED TO COORDINATE SYSTEM B.  THE THREE HALF-UNIT VECTORS ARE STORED
# AT LOCATIONS XDC, XDC +6, XDC +12D, AND STARAD, STARAD +6, STARAD +12D.

AXISGEN		AXT,1	SSP		# PUSHDOWN 00-30D, 34D-37D
			STARAD +6
			S1
			STARAD -6

		SETPD
			0
AXISGEN1	VLOAD*	VXV*		# 06D	UA = S1
			STARAD +12D,1	#	STARAD +00D	UB = S1
			STARAD +18D,1
		UNIT			# 12D	VA = UNIT(S1 X S2)
		STORE	STARAD +18D,1	#	STARAD +06D	VB = UNIT(S1 X S2)
		VLOAD*
			STARAD +12D,1

		VXV*	VSL1
			STARAD +18D,1	# 18D	WA = UA X VA
		STORE	STARAD +24D,1	#	STARAD +12D	WB = UB X VB

		TIX,1
			AXISGEN1

		AXC,1	SXA,1
			6
			30D

		AXT,1	SSP
			18D
			S1
			6

		AXT,2	SSP
			6
			S2
			2

AXISGEN2	XCHX,1	VLOAD*
			30D		# X1=-6 X2=+6	X1=-6 X2=+4	X1=-6 X2=+2
			0,1

## Page 1248
		VXSC*	PDVL*		# J=(UA)(UB1)	J=(UA)(UB2)	J=(UA)(UB3)
			STARAD +6,2
			6,1
		VXSC*
			STARAD +12D,2
		STOVL*	24D		# K=(VA)(VB1)	J=(VA)(VB2)	J=(VA)(VB3)
			12D,1

		VXSC*	VAD
			STARAD +18D,2	# L=(WA)(WB1)	J=(WA)(WB2)	J=(WA)(WB3)
		VAD	VSL1
			24D
		XCHX,1	UNIT
			30D
		STORE	XDC +18D,1	# XDC = L+J+K	YDC = L+J+K	ZDC = L+J+K

		TIX,1
			AXISGEN3

AXISGEN3	TIX,2
			AXISGEN2

		VLOAD
			XDC
		STOVL	STARAD
			YDC
		STOVL	STARAD +6
			ZDC
		STORE	STARAD +12D

		RVQ

## Page 1249
QTSN45		2DEC	.1768
.166...		2DEC	.1666666667

## Page 1250
## There is no source code on this page of the original assembly listing.