.data
far:	.asciz	"Please Enter Fahrenheit: "
cel:	.asciz	"\nIn Celsius: "
kel:	.asciz	"In Kelvin: "	
v1:	.float	32.00
v2:	.float	5.0
v3:	.float	9.0
v4: 	.float 	273.15
f: 		.float	

.text
main:
li	a7, 4			
la	a0, far 		
ecall
li	a7, 6			
fadd.s	fa0, f, f0		
ecall
jal	funct
fadd.s	f0, f8, fa0
fadd.s	f1, f8, fa1
li	a7, 4
la	a0, kel
ecall
li	a7, 2
fadd.s	fa1, f0, f8
ecall
li	a7, 4
la	a0, cel
ecall
li	a7, 2
fadd.s	fa0, f1, f8
ecall
li	a7,10
ecall
funct:		
flw	f0, v1, t0  	
flw	f1, v2, t0	
flw	f2, v3, t0	
flw	f3, v4, t0	
fsub.s	f4,  fa0, f0	
fmul.s	f5, f4, f1	
fdiv.s	f6, f5, f2	
fadd.s	fa1, f8, f6	
fadd.s	f7, f6, f3	
fadd.s	fa0, f8, f7	
jr	ra, 0 		