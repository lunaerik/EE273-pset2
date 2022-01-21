* Test of Beatty Standard *

*************************************************************************
*                                                                       *
*			Parameter Definitions				*
*                                                                       *
*************************************************************************
 .PARAM refimped =	50		* Reference impedance, ohms
 .PARAM btsimped =	25		* Beatty line impedance, ohms
 .PARAM reftd =		1n		* Reference line time delay, sec
 .PARAM btstd =		1n		* Beatty line time delay, sec

*************************************************************************
*                                                                       *
*			Main Circuit					*
*                                                                       *
*************************************************************************
 Vs  1 0  AC 2				* Signal source
 Rsr 1 inr  refimped			* Reference matching resistor
 Rtr inr 0  refimped			* Reference termination

 Rsb 1    inb    refimped		* Beatty matching resistor
 Xl1 inb  outb  (stripline)		* Beatty stripline
 Rtb outb 0      refimped		* Beatty line termination

 E1  gamma1 0  (inb,inr) 1		* VCVS to compute gamma 1
 Rg  gamma1 0   1G			* Terminate VCVS
 
*************************************************************************
*                                                                       *
*			Sub-Circuit Definitions				*
*                                                                       *
*************************************************************************
 .SUBCKT (stripline) in out length=0.1
    W1 in 0 out 0 RLGCmodel=beatty_test N=1 l=length
 .ENDS (stripline)

*************************************************************************
*                                                                       *
*			Included Files					*
*                                                                       *
*************************************************************************
 .INCLUDE ./beatty_test.rlgc

*************************************************************************
*                                                                       *
*			Simulation Controls & Alters			*
*                                                                       *
*************************************************************************
*.PROBE AC gamma1=PAR('V(inb)-V(inr)')
 .OPTION POST=1 ACCURATE
 .AC DEC 1000 1meg 2g
 .END

