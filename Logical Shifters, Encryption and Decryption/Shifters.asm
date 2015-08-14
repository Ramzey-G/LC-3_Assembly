;Ramzey Ghanaim
;Lab 7 Part A: Shifter
;Section 5
;CMPE-12L 
;TA: Hany
;
;this program will get the user to type in an decimal number. This
; number will be converted into Binary and shifted by a user
;specified ammount. Both Left and Right shifts are preformed
;
;		
		.ORIG x3000
BRnzp skip
HELLO		.STRINGZ	"Hello and welcome to the decimal to binary converter!\n"
Q		.STRINGZ	"\n Please enter any number\n"
SSTRING		.STRINGZ	"\n Enter a number you would like to shift these bits by (0-15) \n"

; Printing a greeting
skip	LEA	R0, HELLO	;loads address from register of where the greeting is stored
	PUTS			;Prints the Greeting
; Clearing all the registers we will use
SKIP2	AND	R0, R0, 0	;Clears Register 0
	AND	R1, R0, 0	;Clears Register 1
	AND	R2, R0, 0	;Clears Register 2
	AND	R3, R0, 0	;Clears Register 3
	AND	R4, R0, 0	;Clears Register 4
	AND	R5, R0, 0	;Clears Register 5
	AND	R6, R0, 0	;Clears Register 6
	AND	R7, R0, 0	;Clears Register 7
	ST	R1, digit
	ST	R1, int
	ST	R1, flag
	ST	R1, SHIFT
;Asking for user input
START	LEA	R0,	Q	; Loads address from register of where the greeting is stored
	PUTS			;Prints the question
;GET INPUT
	;Getting Input
	LD	R3, digit ;digit=r3
	LD	R4, int	 ;int =r4
	LD	R5, flag ;flag =r5
LOOP	GETC		;gets input
	PUTC		;prints input
;CHECKS TO SEE IF SHIFT X to exit program
	AND	R6, R6, #0
	LD	R6, SHIFTX
	ADD	R6, R0, R6  
	BRz	DUNN	   ;DUNN
	AND	R6, R6, #0

;Storing value entered
ECHECK	ADD	R1, R0, #-10   ;checks to see if enter key was hit
	BRz	ENTER
;check for negative sign
	ADD	R2, R0, #-15
	ADD	R2 R2, #-15
	ADD	R2, R2, #-15 ;these subtractions subtrat a total of 45 and store value in r3. r3==0 if negitive sign is hit
	BRnp	POS
FLG	ADD	R5, R5, #1	;if negative, flg ==1
	ST	R5, flag
	BRnzp	LOOP
;IF POSITIVE
POS	
	ADD	R3, R0,#-15
	ADD	R3, R3, #-15
	ADD	R3, R3, #-15
	ADD	R3, R3, #-3   ;POS subtracts 48 to get out of ASCII
	ST	R3, digit
	ST	R4, int
;multipying check
	LD	R6, M1
	AND	R2, R2, #0
	ADD	R2, R2, R4
MULT	BRz DIG
	ADD R4, R4, R2
	ADD R6, R6, -1
	BR MULT
DIG	ADD	R4, R4, R3   ;int = (intx10)+diget
	BRnzp	LOOP
ENTER	ST	R4, int
	ADD	R5, R5, #-1 ;is flag ==1?
	BRnp	MASKING     ;if not skip to masking
	NOT	R4, R4
	ADD	R4, R4, #1  ;converts to 2's comp if flag==1 (negative)
; NOW FOR THE MASKING PORTION OF THE FLOW CHART
MASKING	AND	R5, R5, #0
	AND	R3, R3, #0 ;CLEARS R3
	AND	R6, R6, #0 ;clears R6
	AND	R1, R1, #0 ;clears R1
	JSR	SHIF

;NOW WE WILL SHIFT RIGHT by SHIFT bits
SHIFTING
	AND	R0, R0, 0	;Clears Register 0
	AND	R1, R0, 0	;Clears Register 1
	AND	R2, R0, 0	;Clears Register 2
	AND	R3, R0, 0	;Clears Register 3
	AND	R4, R4, 0
	AND	R5, R0, 0	;Clears Register 5
	AND	R6, R0, 0	;Clears Register 6
	
;shift queston
	LEA	R0, SSTRING
	PUTS
GETIN	GETC
	PUTC
	ADD	R6, R0, #-10 ;CHECKS FOR ENTER
	BRz	n
	LD	R6, ASCIIOUT
	ADD	R0, R0, R6
	ADD	R1, R0, R1
	ADD	R2, R2, #1 ;COUNT
	BR	GETIN
n	ADD	R2, R2, #-2
	BRn	n2
	ADD	R1, R1, #9
n2	ST	R1, SHIFT	;STORES shift count
	AND	R0, R0, 0	;Clears Register 0
	AND	R1, R0, 0	;Clears Register 1
	AND	R2, R0, 0	;Clears Register 2
	AND	R3, R0, 0	;Clears Register 3
	AND	R5, R0, 0	;Clears Register 5
	AND	R6, R0, 0	;Clears Register 6
	LD	R4, int
	LD	R1, SHIFT ;puts shifting bits into r1==shift
	LD	R2, flag	;R2 ==flag
	ADD	R2, R2, #-1
	BRn	RIGHT
	LD	R5, EADD
	ADD	R4, R5, R4
	NOT	R4, R4
	ADD	R4, R4, #1
	
;PRINT SHIFT number of zeros
RIGHT	LEA	R0,RSHIFT ;TEXT: "RIGHT SHIFT IS: "
	PUTS
	JSR	SUBT


;GOES HERE



LEFT	LEA	R0, LSHIFT ;Displays text: "Left shift is: "
	PUTS
	JSR	LSHIFT2
	BR	SKIP2


		;PRINTING METHOD
SHIF	LD	R6, count ;r6 == count==15
SHIFN	ST	R7, REG7
	AND	R3, R3, #0
	AND	R5, R5, #0
	LEA	R3, MASK
	LD	R5, digit	;digit ==r4  NOT DIGIT REPLACE WITH DIFFERENT VARIABLE

CCHECK	 ;Counter Check checks to see if count is less than 1
	AND	R1, R1, #0
	AND	R5,R5,#0
	LDR	R1, R3, #0
	AND	R5, R4, R1 ;digit ==int AND MASk
	NOT	R1, R1
	ADD	R1, R1, #1
	ADD	R2, R5,R1 ; CHECKS TO SEE IF diget is zero
	BRz	ONE	;if not zero,skip to zero to print 1

ZERO	LD	R0, ZER  ;the adding converts to ASCII (add 48) before printing 0
	PUTC    	;put c
	BRnzp	NEXT
ONE	
	LD	R0, ASCII1
	PUTC		;PUT C 

	
NEXT	ADD	R3, R3, #1
	ADD	R6, R6, #-1
	BRzp	CCHECK
	LD	R7, REG7
	RET

;RIGHT SHIFT METHOD
SUBT	ST	R7, SHIFST
	ADD	R1, R1, #-1 ;subtracts 1 from number of shifts
	BRn	D2
BACK	ADD	R3, R3, #1 ;add 1 to the counter
	ADD	R4, R4, #-2
	BRp	BACK
	BRz	SUBT1
	BRn	SUBT2
SUBT1	AND	R4, R4, #0
	ADD	R4, R3, #0
	AND	R3, R3, #0 ;count ==0
	BR	SUBT
SUBT2	ADD	R3, R3, #-1
	AND	R4, R4, #0
	ADD	R4, R3, #0
	AND	R3, R3, #0 ;count ==0
	BR	SUBT
D2	LD	R2, flag	;R2 ==flag
	BRz	J


;ADDING BACK IN MISSING 1 FROM NEGAGIVE NUMBER SHIFTING
	LD	R1, flag
	BRz	J
	LD	R1, SHIFT
	LD	R6, NUM
	AND	R3, R3, #0
SU	ADD	R0, R1, #-1 ;subtracts 1 from number of shifts
	BRnp	J1
	LD	R0, NUM
	ADD	R4, R4, R0
	BR	J
J1	ADD	R0, R1, #-2 ;subtracts 1 from number of shifts
	BRnp	J2
	LD	R0, NUM2
	ADD	R4, R4, R0
	BR	J
J2	ADD	R0, R1, #-3 ;subtracts 1 from number of shifts
	BRnp	J3
	LD	R0, NUM3
	ADD	R4, R4, R0
	BR	J
J3	ADD	R0, R1, #-4 ;subtracts 1 from number of shifts
	BRnp	J4
	LD	R0, NUM4
	ADD	R4, R4, R0
	BR	J
J4	ADD	R0, R1, #-5 ;subtracts 1 from number of shifts
	BRnp	J5
	LD	R0, NUM5
	ADD	R4, R4, R0
	BR	J
J5	ADD	R0, R1, #-6 ;subtracts 1 from number of shifts
	BRnp	J6
	LD	R0, NUM6
	ADD	R4, R4, R0
	BR	J
J6	ADD	R0, R1, #-7 ;subtracts 1 from number of shifts
	BRnp	J7
	LD	R0, NUM7
	ADD	R4, R4, R0
	BR	J
J7	ADD	R0, R1, #-8 ;subtracts 1 from number of shifts
	BRnp	J8
	LD	R0, NUM8
	ADD	R4, R4, R0
	BR	J
J8	ADD	R0, R1, #-9 ;subtracts 1 from number of shifts
	BRnp	J9
	LD	R0, NUM9
	ADD	R4, R4, R0
	BR	J
J9	ADD	R0, R1, #-10 ;subtracts 1 from number of shifts
	BRnp	J10
	LD	R0, NUM10
	ADD	R4, R4, R0
	BR	J
J10	ADD	R0, R1, #-11 ;subtracts 1 from number of shifts
	BRnp	J11
	LD	R0, NUM11
	ADD	R4, R4, R0
	BR	J
J11	ADD	R0, R1, #-12 ;subtracts 1 from number of shifts
	BRnp	J12
	LD	R0, NUM12
	ADD	R4, R4, R0
	BR	J
J12	ADD	R0, R1, #-13 ;subtracts 1 from number of shifts
	BRnp	J13
	LD	R0, NUM13
	ADD	R4, R4, R0
	BR	J
J13	ADD	R0, R1, #-14 ;subtracts 1 from number of shifts
	BRnp	J14
	LD	R0, NUM14
	ADD	R4, R4, R0
	BR	J
J14	ADD	R0, R1, #-15 ;subtracts 1 from number of shifts
	BRnp	J 		;should say invalid input message
	LD	R0, NUM15
	ADD	R4, R4, R0
J	JSR	SHIF
	LD	R7, SHIFST
	RET
;LEFT SHIFTING METHOD
LSHIFT2	ST	R7, SHIFST
	LD	R1, SHIFT
	LD	R4, int
BACK2	ADD	R4, R4, R4
	ADD	R1, R1, #-1
	BRp	BACK2
	LD	R5, flag
	BRz	pr
	NOT	R4, R4
	ADD	R4, R4, #1
pr	JSR	SHIF
	LD	R7, SHIFST
	RET

;exits program
DUNN	AND	R0, R0, #0
	LEA	R0, GOODBYE	;loads address from register of where the greeting is stored
	PUTS
	HALT

		
		;Variable declarations
SHIFST		.FILL		#0
A		.FILL		#0
SHIFCHECK	.FILL		#-1
origint		.FILL		#0
int		.FILL		#0
int2		.FILL		#0
flag		.FILL		#0
digit		.FILL		#0
digit2		.FILL		#0
count		.FILL		#15
ncount		.FILL		#14
POINTER		.FILL		#0
M1		.FILL		#9
SHIFTX		.FILL		#-88
ASCIIOUT	.FILL		#-48
SHIFT		.FILL		#0
Z		.FILL		#0
ZER		.FILL		#48
ASCII1		.FILL		#49
ITTER		.FILL		#0
EADD		.FILL		#32768
NUM		.FILL		x4000
NUM2		.FILL		x2000
NUM3		.FILL		x1000
NUM4		.FILL		x0800
NUM5		.FILL		x0400
NUM6		.FILL		x0200
NUM7		.FILL		x0100
NUM8		.FILL		x0080
NUM9		.FILL		x0040
NUM10		.FILL		x0020
NUM11		.FILL		x0010
NUM12		.FILL		x0008		
NUM13		.FILL		x0004
NUM14		.FILL		x0002
NUM15		.FILL		x0001
MASK		.FILL		x8000
		.FILL		x4000
		.FILL		x2000
		.FILL		x1000
		.FILL		x0800
		.FILL		x0400
		.FILL		x0200
		.FILL		x0100
		.FILL		x0080
		.FILL		x0040
		.FILL		x0020
		.FILL		x0010
		.FILL		x0008
		.FILL		x0004
		.FILL		x0002
		.FILL		x0001
REG7		.FILL		#0
RSHIFT		.STRINGZ	"\n Right shift is: \n"
LSHIFT		.STRINGZ	"\n Left shift is: \n"
GOODBYE		.STRINGZ	"\n Good bye! Please come again!"

	.END