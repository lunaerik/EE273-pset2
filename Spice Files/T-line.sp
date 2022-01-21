* Test of Resonant T Standard *

*************************************************************************
*                                                                       *
*			Parameter Definitions				*
*                                                                       *
*************************************************************************
 .PARAM refimped =	50		* Reference impedance, ohms
 .PARAM stub_len =	0.05		* Stub line length, meters

*************************************************************************
*                                                                       *
*			Main Circuit					*
*                                                                       *
*************************************************************************
 Vs  1 0  AC 2				* Signal source
 Rsr 1 inr  refimped			* Reference matching resistor
 Rtr inr 0  refimped			* Reference termination

 Rsb 1    outb   refimped		* T stub matching resistor
 Xl1 outb open  (stripline)		* T stub stripline
 Rop open 0      2G			* Quasi-open
 Rtb outb 0      refimped		* T stub line termination

 E1  gamma1 0  (outb,inr) 1		* VCVS to compute gamma 1
 Rg  gamma1 0   1G			* Terminate VCVS
 
*************************************************************************
*                                                                       *
*			Sub-Circuit Definitions				*
*                                                                       *
*************************************************************************
 .SUBCKT (stripline) in out length=stub_len
    W1 in 0 out 0 RLGCmodel=t-stub_test N=1 l=length
 .ENDS (stripline)

*************************************************************************
*                                                                       *
*			Included Files					*
*                                                                       *
*************************************************************************
 .INCLUDE ./t-stub_test.rlgc

*************************************************************************
*                                                                       *
*			Simulation Controls & Alters			*
*                                                                       *
*************************************************************************
*.PROBE AC gamma1=PAR('V(inb)-V(inr)')
 .OPTION POST=1 ACCURATE
 .AC DEC 10000 1meg 2g
 .END

