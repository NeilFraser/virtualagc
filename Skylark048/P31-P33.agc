### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	P31-P33.agc
## Purpose:	A section of Skylark revision 048.
##		It is part of the source code for the Apollo Guidance Computer (AGC)
##		for Skylab-2, Skylab-3, Skylab-4, and ASTP. No original listings of
##		this software are available; instead, this file was created via
##		disassembly of dumps of the core rope modules actually flown on
##		Skylab-2. Access to these modules was provided by the New Mexico
##		Museum of Space History.
## Assembler:	yaYUL
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo/index.html
## Mod history:	2024-02-25 MAS  Created.


## This log section is entirely new in Skylark. Names have been taken from
## the Programmed Guidance Equations for Skylark wherever possible.

		SETLOC	NCPROGS
		BANK
		EBANK=	TCS
		COUNT*	$$/P3133

P31		TC	P20FLGON
		TC	DOWNFLAG
		ADRES	NC12FLG

		CAF	V06N95
		TC	VNFLASH

		CAF	V06N57
		TC	VNFLASH

		TC	GETTPI

V06N95		VN	0695
V06N28		VN	0628
V06N57		VN	0657

P32		TC	P20FLGON
		TC	UPFLAG
		ADRES	NC12FLG

		CAF	V06N28
		TC	VNFLASH

		CAF	V06N57
		TC	VNFLASHR

		TC	GETTPI

		CAF	BIT1
		TC	BLANKET
		TC	ENDOFJOB

GETTPI		CAF	V06N37
		TC	VNFLASH

		TC	INTPRET
		DLOAD	BOFF
			NC1TIG
			NC12FLG
			+3
		DLOAD
			NC2TIG
		CLEAR
			FINALFLG
		STORE	TIMEC
		STORE	TIG

		SLOAD	SL
			HALFREVS
			8D
		STCALL	NC
			VN1645

NC12ST		SLOAD	SETPD
			25F/S
			0
		STODL	PH1
			HI6ZEROS
		STORE	CF
		STODL	PH2
			165F/S
		STORE	DVH1

		BOFF	PUSH
			NC12FLG
			+6

		SLOAD
			NH1
		STODL	NC
		GOTO
			+3

		DLOAD
			225F/S

		STODL	DVC
			25F/S
		STODL	DVH2
			DPHALF
		STODL	PI
			TIMEC
		STORE	TN
		STCALL	TDEC1
			CSMPREC

		CLEAR	VLOAD
			ITERFLG
			RATT
		STORE	RTIG
		STOVL	RAC
			VATT
		STORE	VTIG
		STODL	VAC
			TIMEC
		STCALL	TDEC1
			LEMCONIC

		VLOAD
			VATT
		STOVL	VPC
			RATT
		STORE	RPC

PHSMCH		VXV	UNIT
			VPC
		PUSH
		STOVL	AM1
			RAC
		PUSH	VXV
			VAC
		UNIT	VXV
		VXV	UNIT
		PUSH
		STOVL	URPD
			RPC
		UNIT	DOT
		SL1	ACOS
		BDSU	PDVL
			PI
			URPD
		VXV	DOT
			RPC
			AM1
		PDDL	SIGN
		BDSU	SETPD
			PI
			2
		STODL	TH2

		BMN	DLOAD
			NC12B
			NC
		DSU	BMN
			18B5
			NC12B
		DLOAD	BZE
			PI
			NC12B
		VLOAD	PDVL
			RPC
			VPC
		PDDL	PDDL
			TIMEC
			1B5
		PUSH	CALL
			REVUP
		DLOAD	DSU
			RATEMP
			TIMEC
		BDSU
			TN
		STODL	TN
			TH2
		ABS	PUSH
		GOTO
			NC12J

NC12B		DLOAD	ABS
			TH2
		PUSH	PUSH
		DSU	BMN
			EPS1
			NC12F
		DLOAD	BZE
			PH1
			PSMALRM
		DSU
			DPB-14
		STODL	PH1

NC12J		COS	SET
			RVSW
		STODL	CSTH
		SIN
		STOVL	SNTH
			RPC
		STOVL	RVEC
			VPC
		SIGN
			TH2
		STCALL	VVEC
			TIMETHET

		DLOAD	BZE
			PI
			NC12C

		DLOAD
			HI6ZEROS
		STOVL	PI
			R-OTHER
		STOVL	RPC
			V-OTHER
		STODL	VPC
			T-OTHER
		STORE	TPC

NC12C		CLEAR	SETPD
			NCINTFLG
			0

		VLOAD	PDVL
			RPC
			VPC
		PDDL	PDDL
			TPC
			30D
		SIGN	BDSU
			TH2
			TN
		STORE	TN
		STORE	TPC
		STCALL	TDEC1
			NCINT

		VLOAD	STADR
		STOVL	VPC
		STADR
		STCALL	RPC
			PHSMCH

NC12F		DLOAD	SETPD
			HI6ZEROS
			0
		STOVL	PH1
			RAC
		CALL
			VECPROJ
		STOVL	RAC
			VAC
		CALL
			VECPROJ
		STOVL	VAC
			RPC
		PDVL	PDDL
			VPC
			TPC
		PDDL	SET
			TTPI
			NCINTFLG
		STCALL	TDEC1
			NCINT

		SET	VLOAD
			NCINTFLG

		STADR
		STOVL	VPTPI
		STADR
		STODL	RPTPI
			DELH1
		STCALL	DELH
			QRDTPI
		VLOAD
		VLOAD	UNIT
			0
		VXSC	VSL1
			DELH1
		BVSU	STADR
		STORE	RAFD

NC1LOOP		VLOAD	PUSH
			RAC
		PDVL	VXV
			AM1
		UNIT	VXSC
			DVC
		VSL1	VAD
			VAC
		PDDL	PDDL
			TIMEC
			NC
		PUSH	CALL
			REVUP

		VLOAD	BON
			RATT
			NC12FLG
			NC2A
		STOVL	RAH1
			VATT
		STODL	VAH1
			RATEMP
		STODL	TH1
			CF
		BZE	DLOAD
			+2
			0.5B5
		STORE	CI

NC2LOOP		VLOAD	PUSH
			RAH1
		PDVL	VXV
			AM1
		UNIT	VXSC
			DVH1
		VSL1	VAD
			VAH1
		PDDL	PUSH
			TH1
		SLOAD	PUSH
			NH1
		CALL
			REVUP

		VLOAD
			VATT
		STODL	VAH2
			RATEMP
		STOVL	TH2
			RATT
		PUSH	CLEAR
			NCLPFLG
		STODL	RAH2
			DHNCC
		STCALL	DELHTMP
			EHCOMP

NC2A		STOVL	RAH2
			VATT
		STODL	VAH2
			RATEMP
		STORE	TH2

NC12D		DLOAD	BZE
			CF
			+3
		DLOAD
			0.5B5
		STORE	CI

NCCLOOP		VLOAD	PUSH
			RAH2
		PDVL	VXV
			AM1
		UNIT	VXSC
			DVH2
		VSL1	VAD
			VAH2
		PDDL	PUSH
			TH2
		DAD	SET
			TCS
			NCINTFLG
		STORE	TAS
		STCALL	TDEC1
			NCINT

		VLOAD	STADR
		STOVL	VAS
			RATT
		STCALL	RAS
			RADUP

		PUSH	ABS
		PDVL	ABS
			RAS
		BDSU	STADR
		STOVL	DELH
		CALL
			COE

		VLOAD	SET
			RAS
			NCINTFLG
		PDVL	STADR
		STORE	VASF
		PDDL	PDDL
			TAS
			TTPI
		STCALL	TDEC1
			NCINT

		VLOAD	SETPD
			RATT
			0
		STORE	RAF

		PDDL	SET
			DELH1
			NCLPFLG
		STCALL	DELHTMP
			EHCOMP

NC12G		VLOAD	UNIT
			RAFD
		PDVL	UNIT
			RAF
		DOT	SL1
		ACOS	PDVL
			RAF
		VXV	DOT
			RAFD
			AM1
		PDDL	SIGN
		STADR
		STORE	2

		ABS	PDDL
			EPS1
		SL2	BDSU
		BMN	SETPD
			NC12OUT
			4

		DLOAD	PDDL
			DVC
		PDDL	PUSH
			CF
		DLOAD
			EOP
		STODL	EO
			DVOC
		STCALL	DVO
			ITER

		BON
			ITERFLG
			OLPALRM

		DLOAD	STADR
		STODL	CF
		STADR
		STODL	DVC
		DLOAD
			DVO
		STODL	DVOC
			EO
		STCALL	EOP
			NC1LOOP

EHCOMP		VLOAD	ABS
			0
		STCALL	RATEMP
			RADUP
		ABS	DSU
			RATEMP
		DSU	PUSH
			DELHTMP
		STODL	2
			PH1
		BOFF	DLOAD
			NCLPFLG
			+2
			PH2
		STORE	0

		BZE	DLOAD
			ITERUP
		ABS	DSU
			EPS2
		BMN
			LOOPX

ITERUP		SETPD	DLOAD
			4
			DVH1
		BOFF	DLOAD
			NCLPFLG
			+2
			DVH2
		PDDL
		PDDL	PUSH
			CI
		LXA,1	BOFF
			PSHFT1
			NCLPFLG
			+3
		LXA,1
			PSHFT2
		CALL
			ITER

		BON
			ITERFLG
			ILPALRM

		DLOAD	STADR
		STORE	CI

		BOFF	DLOAD
			NCLPFLG
			NC2ITR
		SXA,1
			PSHFT2
		STODL	DVH2
		STADR
		STCALL	PH2
			NCCLOOP

NC2ITR		DLOAD	STADR
		STODL	DVH1
		SXA,1
			PSHFT1
		STCALL	PH1
			NC2LOOP

LOOPX		SETPD	BOFF
			0
			NCLPFLG
			NC12D
		GOTO
			NC12G

NC12OUT		VLOAD	PDDL
			ZEROVECS
			DVC
		VDEF
		STOVL	DELVLVC
			AM1
		VCOMP	SETPD
			6
		PDVL	UNIT
			RAS
		VCOMP	PUSH
		VXV	VSL1
			AM1
		STOVL	0
			VASF
		VSU	MXV
			VAS
			0
		VSL1
		STODL	VGNSR
			TAS
		STODL	TNSR
			TH2
		STODL	TNCC
			DVH2
		BON	SETPD
			NC12FLG
			NC2N80
			0
		STODL	DVDSP2
			DVH1
		STODL	DVDSP1
			TH1
		STOVL	NC2TIG
			RAH1
		PUSH	CALL
			RADUP

		ABS	PDVL
			RAH1
		ABS	BDSU
		GOTO
			NC12DH

NC2N80		STOVL	DVDSP1
			VGNSR
		ABS
		STODL	DVDSP2
			DHNCC

NC12DH		STORE	DHDSP

		BON	SET
			FINALFLG
			+2
			UPDATFLG
		EXIT

		CAF	V06N84
		TC	BANKCALL
		CADR	GOFLASH
		TC	GOTOPOOH
		TCF	+2
		TCF	-5

		TC	INTPRET
		BOFF	DLOAD
			NC12FLG
			NC12H -1
			DHDSP
		STORE	DHNCC
		EXIT

NC12H		CAF	V06N81
		TC	VNFLASH

		TC	INTPRET
		CALL
			S32/33.X
		VLOAD	VXM
			DELVLVC
			0
		SET	VSL1
			XDELVFLG
		STCALL	DELVSIN
			VN1645
		GOTO
			NC12ST

V06N84		VN	0684

PSMALRM		VLOAD	CALL
			RAC
			VECPROJ
		STORE	RAC

		SLOAD
			ALARM/TB

DISPALM		BON	SET
			FINALFLG
			+2
			UPDATFLG
		CALL
			NCALARM

		VLOAD
			ZEROVECS
		STORE	DELVLVC
		EXIT

		TC	CHECKMM
		MM	33
		TCF	NC12H

		TC	DOWNFLAG
		ADRES	XDELVFLG

		TCF	N81DISP

ILPALRM		SLOAD	GOTO
			ALARM/TB +1
			DISPALM

QRDALRM		SLOAD	GOTO
			ALARM/TB +3
			DISPALM

OLPALRM		SLOAD	CALL
			ALARM/TB +2
			NCALARM
		GOTO
			NC12OUT

NCINT		STQ	CALL
			NCINTOUT
			INTSTALL

		CLEAR	BOFF
			INTYPFLG
			NCINTFLG
			+3
		SET
			INTYPFLG
		DLOAD	STADR
		STOVL	TET
		STADR
		STOVL	VCV
		STADR
		STCALL	RCV
			INTEGRVS
		SETPD	GOTO
			12D
			NCINTOUT

REVUP		STQ	VLOAD
			QSAVER
			6
		DOT	DMP
			6
			1/MUE
		PDVL	ABS
			0
		NORM	BDDV
			X1
			2B3
		SL*	DSU
			0 -6,1
		BDDV	PUSH
			1B4
		SQRT	DMP
			1/SQMU
		DMP	SR1
		DMP	DMP
			2PIB3
		DAD	SET
			12D
			NCINTFLG
		STORE	RATEMP
		STCALL	TDEC1
			NCINT

		SETPD	GOTO
			0
			QSAVER

RADUP		STQ	VLOAD
			QSAVER
			VPC
		STOVL	VVEC
			RPC
		STORE	RVEC
		PUSH	VXV
			VVEC
		PDVL
		VXV	DOT
			0
		PDVL	UNIT
		PDVL	UNIT
			RVEC
		DOT	SL1
		ACOS	SIGN
		PUSH	COS
		STODL	CSTH
		SIN	CLEAR
			RVSW
		STCALL	SNTH
			TIMETHET
		PDVL
		GOTO
			QSAVER

## The name of the following function is a guess.
VECPROJ		PUSH	PUSH
		DOT	VXSC
			AM1
			AM1
		SL1	BVSU
		UNIT	PDVL
		ABS	VXSC
		VSL1	RVQ

ITER		DLOAD
		BZE	DSU
			ITER0
			0.5B5
		BZE	DLOAD
			ITER2
		DSU	BZE
			EO
			ITER1
		NORM	SR1
			X1
		STODL	8D
		DSU	NORM
			DVO
			X2
		BDDV	XSU,1
			8D
			X2
		NORM	XAD,1
			X2
			X2
		PDDL
		DLOAD	DSU
			6D
			14B5
		BMN	SET
			ITER2
			ITERFLG
		RVQ

## The names of the following 3 labels are guesses.
ITER0		DLOAD	GOTO
			1F/S
			ITER3

ITER1		DLOAD	GOTO
			0.3F/S
			ITER3

ITER2		DLOAD	NORM
			4D
			X2
		SR1	DDV
			0
		XSU,2	SR*
			X1
			0,2

ITER3		SETPD
			4
		STODL	8D
			4
		STODL	EO
		STADR
		STORE	DVO
		DSU	PDDL
			8D
			6D
		DAD	PUSH
			1B5
		RVQ

## The name of the following function is a guess.
NCALARM		STQ	EXIT
			QSAVER

		CA	MPAC
		TC	VARALARM

		CAF	V05N09
		TC	BANKCALL
		CADR	GOFLASH
		TC	GOTOPOOH
		TC	NCALMOUT

		TC	CHECKMM
		MM	33
		TCF	+2
		TCF	P33

		TC	CHECKMM
		MM	32
		TCF	P31
		
		TCF	P32

## The name of the following label is a guess.
NCALMOUT	TC	INTPRET
		GOTO
			QSAVER

1/MUE		2DEC*	.25087606 E-10 B+34*
1B4		2DEC	1 B-4
1/SQMU		2DEC*	.50087529 E-5 B+17*
0.5B5		2DEC	.5 B-5
1B5		2DEC	1 B-5
2B3		=	DP1/4TH
2PIB3		2DEC	6.2831853 B-3
14B5		2DEC	14 B-5
0.3F/S		2DEC	0.009144 B-7
1F/S		2DEC	0.003048 B-7
165F/S		2DEC	0.50292 B-7
225F/S		2DEC	0.68580 B-7
25F/S		2DEC	0.07620 B-7

## The following name was copied from P32-P33, P72-P73 in Artemis 72.
ALARM/TB	OCT	00600		# NO 1
		OCT	00601		#    2
		OCT	00602		#    3
		OCT	00603		#    4

18B5		2DEC	18 B-5

P33		TC	P20FLGON

		CAF	V06N11
		TC	VNFLASH

		TC	INTPRET
		DLOAD	DAD
			TNCC
			TCS
		STORE	TNSR
		EXIT

		CAF	V06N13
		TC	VNFLASH

		CAF	V06N37
		TC	VNFLASH

		TC	INTPRET
		DLOAD	CLEAR
			TNCC
			FINALFLG
		STORE	TIG

DISP45A		CALL
			VN1645
		DLOAD
			TNCC
		STORE	TDEC1
		STCALL	INTIME
			CSMPREC

		VLOAD
			RATT
		STORE	RINIT
		STOVL	RPASS3
			VATT
		STORE	VINIT
		STODL	VACT3
			TNSR
		STCALL	TDEC1
			LEMPREC

		VLOAD	CLEAR
			VATT
			ITERFLG
		STOVL	VCV
			RATT
		STORE	RCV

		VXV	UNIT
			VCV
		STODL	UP1
			TTPI

NCCDMP4		STCALL	TDEC1
			LEMPREC

		VLOAD	CLEAR
			RATT
			NCINTFLG
		STOVL	RPTPI
			VATT
		STODL	VPTPI
			DELH1
		STCALL	DELH
			QRDTPI

		VLOAD
		PDVL
		CALL
			COE
		CALL
			INTSTALL

		STOVL	RCV
		STADR
		STODL	VCV
			TTPI
		STORE	TET
		CLEAR	DLOAD
			INTYPFLG
			TNSR
		STCALL	TDEC1
			INTEGRVS

		VLOAD
			RATT
		STORE	RNSR
		STOVL	RTARG
			VATT
		STODL	VNSRP
			TNSR
		DSU
			TNCC
		STODL	DELLT4
			HIGH2
		PDDL	PUSH
			15DEG
		CALL
			INITVEL

NCCDMP7		VLOAD	VSU
			VNSRP
			VTPRIME
		PDVL
			VTPRIME
		STOVL	VINIT
			RNSR
		STCALL	RINIT
			GET.LVC

		VLOAD	DOT
			VTPRIME
			UP1
		SL1	SETPD
			0
		STOVL	DELVLVC +2
			DELVLVC
		STORE	VGNSR
		
		BON	SET
			FINALFLG
			+2
			UPDATFLG
		EXIT

		CAF	V06N82
		TC	VNFLASH

		TC	INTPRET
		VLOAD	PDVL
			DELVEET3
			VACT3
		STOVL	VINIT
			RPASS3
		STCALL	RINIT
			GET.LVC
		EXIT

N81DISP		CAF	V06N81
		TC	VNFLASH

		TC	INTPRET
		SET	CALL
			REVFLAG
			GET.LVC

		VLOAD	VXM
			DELVLVC
			6
		VSL1
		STORE	DELVSIN

		VAD	CALL
			VINIT
			INTSTALL
		STOVL	VCV
			RINIT
		STODL	RCV
			TNCC
		STODL	TET
			TNSR
		SET
			INTYPFLG
		STORE	TPASS4
		STCALL	TDEC1
			INTEGRVS

		VLOAD
			RATT
		STCALL	RTARG
			DISP45A

15DEG		2DEC	0.04166667

V06N82		VN	0682

QRDTPI		STQ	DLOAD
			QRDOUT
			HI6ZEROS
		STORE	DTQRD
		STODL	ITERCNT
			ELEV
		DSU	BPL
			DPHALF
			+3
		DLOAD
			ELEV
		STORE	ELEV

		COS
		STORE	COSE

GETRJ		CALL
			INTSTALL
		VLOAD	CLEAR
			RPTPI
			INTYPFLG
		STOVL	RCV
			VPTPI
		STODL	VCV
			TTPI
		STORE	TET

		DAD
			DTQRD
		STORE	TDEC1

		BOFF	SET
			NCINTFLG
			GOPREC
			INTYPFLG

GOPREC		CALL
			INTEGRVS

		VLOAD	UNIT
			RATT
		SETPD
			12D
		STODL	URJ
			36D
		STOVL	RJMAG
			RPTPI
		UNIT	PUSH
		VXV	PDVL
			URJ
			VPTPI
		VXV	DOT
			RPTPI
		BZE	PDVL
			+4
		DOT	SL1
			URJ
		ACOS	SIGN
		PDDL	DSU
			RJMAG
			DELH
		DMP	DDV
			COSE
			36D
		ASIN	DAD
			ELEV
		BDSU	DSU
			DP1/4TH
		SETPD
			12D
		STORE	12D

		ABS	DSU
			EPS1
		BMN	SETPD
			QRDOUT
			2
		DLOAD	PDDL
			DTQRD
			12D
		PDDL	PUSH
			ITERCNT
		CALL
			ITER

		DLOAD	BON
			4
			ITERFLG
			QRDALRM
		STODL	ITERCNT
			2
		STCALL	DTQRD
			GETRJ


		SETLOC	NCPROGS2
		BANK
		COUNT*	$$/P3133

COE		UNIT	PDDL
			36D
		DSU	PUSH
			DELH
		VXSC	VSL1
			6
		PDVL	DOT
			6
			0
		STORE	26D

		SL1	DSQ
		PDVL	VSQ
			0
		PDDL	DDV
			MU(-42)
			36D
		DSU
		BDDV	SR1
			MU(-42)
		PUSH	DSU
			DELH
		SL1
		STORE	32D

		BDDV	PUSH
		DSQ	DMP
		DMP	SL3
		PUSH	SQRT
		SIGN
			26D
		STODL	30D
			32D
		DSU	SR1
			12D
		DDV	DMP
			12D
			MU(-42)
		SL1	DDV
			32D
		DSU	SQRT
		PDVL	VXV
			6
			0
		VXV	UNIT
			6
		VXSC
		PDVL	VXSC
			6
			30D
		VAD	VSL1
		SETPD	PDVL
			0
			14D
		RVQ

MU(-42)		2DEC	3.986032 E10 B-42
