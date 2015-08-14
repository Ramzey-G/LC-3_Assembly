;Ramzey Ghanaim
;Lab 6: Decimal Converter
;Section 5
;CMPE-12L 
;TA: Hany
;
;this program will get the user to type in an decimal number follwed by  carriage return.
;
;		
		.ORIG x3000
; Clearing all the GPR
	AND	R0, R0, 0	;Clears Register 0
	AND	R1, R0, 0	;Clears Register 1
	AND	R2, R0, 0	;Clears Register 2
	AND	R3, R0, 0	;Clears Register 3
	AND	R4, R0, 0	;Clears Register 4
	AND	R5, R0, 0	;Clears Register 5
	AND	R6, R0, 0	;Clears Register 6
	AND	R7, R0, 0	;Clears Register 7
; Printing a greeting
	LEA	R0, HELLO	;loads address from register of where the greeting is stored
	PUTS			;Prints the Greeting
;Asking for user input
START	LEA	R0,	Q	; Loads address from register of where the greeting is stored
	PUTS			;Prints the question
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
ENTER	ADD	R5, R5, #-1 ;is flag ==1?
	BRnp	MASKING     ;if not skip to masking
	NOT	R4, R4
	ADD	R4, R4, #1  ;converts to 2's comp if flag==1 (negative)

; NOW FOR THE MASKING PORTION OF THE FLOW CHART
MASKING	AND	R5, R5, #0
	AND	R3, R3, #0 ;CLEARS R3
	AND	R6, R6, #0 ;clears R6
	AND	R1, R1, #0 ;clears R1
	LD	R6, count ;r6 == count==16
	LEA	R3, MASK
	LD	R5, digit	;digit ==r4  NOT DIGIT REPLACE WITH DIFFERENT VARIABLE

CCHECK	 ;Counter Check checks to see if count is less than 1
	AND	R5,R5,#0
	LDR	R1, R3, #0
	AND	R5, R4, R1 ;digit ==int AND MASk
	NOT	R1, R1
	ADD	R1, R1, #1
	ADD	R2, R5,R1 ; CHECKS TO SEE IF diget is zero
	BRz	ONE	;if not zero,skip to zero to print 1

ZERO	AND	R0, R0, #0
	ADD	R0, R0, #15
	ADD	R0, R0, #15
	ADD	R0, R0, #15
	ADD	R0, R0, #3   ;the adding converts to ASCII (add 48) before printing 0
	PUTC    	;put c
	BRnzp	NEXT
ONE	AND	R0, R0, #0
	ADD	R0, R0, #1
	ADD	R0, R0, #15
	ADD	R0, R0, #15
	ADD	R0, R0, #15
	ADD	R0, R0, #3
	PUTC		;PUT C 
NEXT	ADD	R3, R3, #1
	ADD	R6, R6, #-1
	BRn	START
	BRnzp	CCHECK
DUNN	AND	R0, R0, #0
	LEA	R0, GOODBYE	;loads address from register of where the greeting is stored
	PUTS
	HALT

		
		;Variable declarations
HELLO		.STRINGZ	"Hello and welcome to the decimal to binary converter!\n"
GOODBYE		.STRINGZ	"\n Good bye! Please come again!"
A		.FILL		#0
Q		.STRINGZ	"\n Please enter any number\n"
int		.FILL		#0
flag		.FILL		#0
digit		.FILL		#0
count		.FILL		#15
POINTER		.FILL		#0
M1		.FILL		#9
SHIFTX		.FILL		#-88
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

	.END