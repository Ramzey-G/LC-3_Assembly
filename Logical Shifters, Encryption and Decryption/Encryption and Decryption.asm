;Ramzey Ghanaim
;Lab 7 Part B
;Section 5
;CMPE-12L 
;TA: Hany
;
;this program will get the user to type in an decimal number follwed by  carriage return.
;
;		
		.ORIG x3000
BRnzp skip
HELLO		.STRINGZ	"Hello and welcome to my Ceaser Cipher program\n"
Q		.STRINGZ	"\nDo you want to (E)ncrypt or (D)ecrypt or e(X)it? \n"
SSTRING		.STRINGZ	"\nEnter a number you would like to shift these bits by (0-15) \n"
INVALID		.STRINGZ	"INVALID INPUT! please try again"
Q2		.STRINGZ	"\nEnter a Cipher (1-25): "
Q3		.STRINGZ	"\nEnter a string:  "
DECRYPT		.FILL		#0
ASCIID		.FILL		#-68
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
	ST	R0, ENCRYPT
;Asking for user input
START	LEA	R0,	Q	; Loads address from register of where the greeting is stored
	PUTS
	GETC
	PUTC			
	LD	R1, ASCIID	
	ADD	R1, R1, R0
	BRnp	encheck
	ADD	R1, R1, #1
	STI	R1, DECRYPT
	BR	QUES2
encheck	LD	R1, ASCIIE
	ADD	R1, R1, R0
	BRnp	exit
	ADD	R1, R1, #1
	ST	R1, ENCRYPT
	BR	QUES2
;CHECKS TO SEE IF SHIFT X to exit program
exit	AND	R6, R6, #0
	LD	R6, SHIFTX
	ADD	R6, R0, R6  
	BRz	DUNN	   ;DUNN
	AND	R6, R6, #0
	LEA	R0, INVALID
	PUTS
	BR	START
QUES2	LEA	R0, Q2
	PUTS
	JSR	GETIN
	LD	R6, ENCRYPT
	BRp	next
next	ST	R4, cipher
	JSR	LOAD
	LD	R2, TWOHD
QUES3	LEA	R0, Q3
	PUTS	
GETSTR	GETC
	PUTC
;ENTER CHECK
	ADD	R4, R0, #-10
	BRz	DWS
	STR	R0, R3, #0
	ADD	R3, R3, #1
	ADD	R2, R2, #-1
	ADD	R1, R1, #1
	BRp	GETSTR
	LEA	R0, INVALID2
	PUTS
	BR	QUES3
       
DWS	ST	R1, COUNT
	
		
;check to see which method to do (encrypt or decrypt)


 	LD	R6, COUNT
	LD	R3, cipher
	JSR	LOAD2
	LD	R0, ENCRYPT
	BRp	SALGOR; 
;this is for encrypting
	LEA	R0, EOUT ;puts "your array is: " on the screen
	PUTS
	JSR	LOAD3
	PUTs
	LEA	R0, YOURA; displays: "encrypted array is"
	PUTS
	
LOOP1	LDR	R1, R4, #0  ;loads conetns of array to r1
	JSR	Dec
	ADD	R6, R6, #-1
	ST	R6, COUNT
	BRp	LOOP1 
	LD	R3,TWOHD
	JSR	LOAD3
	ADD	R0, R0, R3
	PUTs
	BR	SKIP2
SALGOR	LEA	R0, YOURA ;puts "your array is: " on the screen
	PUTS
	JSR	LOAD3
	PUTs
	LEA	R0, EOUT; displays: "encrypted array is"
	PUTS
	
LOOP2	LDR	R1, R4, #0
	JSR	EALGOR
	ADD	R6, R6, #-1
	ST	R6, COUNT
	BRp	LOOP2
	LD	R3,TWOHD
	JSR	LOAD3
	ADD	R0, R0, R3
	PUTs 
	BR	SKIP2



  ;VARIABLS
ENCRYPT		.FILL		#0
EOUT		.STRINGZ	"\nEncrypted word: "
YOURA		.STRINGZ	"\nDecrypted word: "
INVALID2	.STRINGZ	"\nToo many characters"
GOODBYE		.STRINGZ	"\n Good bye!"
ASCIIE		.FILL		#-69
cipher		.FILL		#0
M1		.FILL		#9
SHIFTX		.FILL		#-88
digit		.FILL		#0
COUNT		.FILL		#0
int		.FILL		#0
TWOHD		.FILL		#200
;exits program
DUNN	AND	R0, R0, #0
	LEA	R0, GOODBYE	;loads address from register of where the greeting is stored
	PUTS
	HALT


   ;METHODS START HERE    
;GET INPUT METHOD
	;Getting Input
GETIN	ST	R7, REG7
	LD	R3, digit ;digit=r3
	AND	R3, R3, #0
	LD	R4, int ;int =r4
	AND	R4, R4, #0
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
	LD	R3, ASCIIOUT  ;POS subtracts 48 to get out of ASCII
	ADD	R3, R0, R3
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
	LD	R7, REG7
	RET
LOAD	LEA	R3, ARRAY
	RET
LOAD2	LEA	R4, ARRAY
	RET
LOAD3	LEA	R0, ARRAY
	RET

;ENCRYPTING LOOP	
EALGOR	ST	R7, REG7
	LD	R5, CAPA
	ADD	R0, R1,R5
	BRn	leave  ;leaves character alone, char is not a letter
	NOT	R0, R3
	ADD	R0, R0, #1; neg chipher
	LD	R5, TWSIX
	ADD	R0, R5, R0; 26-CHIPHER
	LD	R5, CAPA
	NOT	R5, R5
	ADD	R5, R5, #1; pos CAPA
	ADD	R0, R5, R0; R0= A+(26-CIPHER)
	NOT	R0, R0
	ADD	R0, R0, #1; GETS NEGATIVE A+(26-CIPHER)
	ADD	R0, R1, R0; IF CHAR<= A+(26-CIPHER)
	BRzp	else22
	ADD	R0, R1, R3; newChar== char+cipher
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
else22	LD	R5, CAPZ
	ADD	R5, R1, R5; char-capz
	BRp	LC2 ; LC2= Low Case2
	NOT	R0, R3
	ADD	R0, R0, #1; NEG CIPHER
	
	LD	R5, TWSIX
	ADD	R5, R5, R0; 26-CIPHER= R5
	LD	R0, CAPZ
	NOT	R0, R0
	ADD	R0, R0, #1
	ADD	R0, R5, R0; Z-(26-CHIPHER)
	ADD	R0, R1, R0; if char>=Z-(26-cipher)
	BRn	LC2
	NOT	R5, R5
	ADD	R5, R5, #1; neg (26-cipher)
	ADD	R0, R1, R5; newchar= char -(26-cipher)
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
LC2	LD	R5, LOWA
	ADD	R0, R1,R5
	BRn	leave  ;leaves character alone, char is not a letter
	NOT	R0, R3
	ADD	R0, R0, #1; neg chipher
	LD	R5, TWSIX
	ADD	R0, R5, R0; 26-CHIPHER
	LD	R5, LOWA
	NOT	R5, R5
	ADD	R5, R5, #1; pos LOWA
	ADD	R0, R5, R0; R0= A+(26-CIPHER)
	NOT	R0, R0
	ADD	R0, R0, #1
	ADD	R0, R1, R0; IF CHAR<= A+(26-CIPHER)
	BRzp	else32
	ADD	R0, R1, R3; newChar== char+cipher
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
else32	LD	R5, LOWZ
	ADD	R5, R1, R5; char-capz
	BRp	leave ; LC2= Low Case2
	NOT	R0, R3
	ADD	R0, R0, #1; NEG CIPHER
	
	LD	R5, TWSIX
	ADD	R5, R5, R0; 26-CIPHER= R5
	LD	R0, LOWZ
	NOT	R0, R0
	ADD	R0, R0, #1
	ADD	R0, R5, R0; Z-(26-CHIPHER)
	ADD	R0, R1, R0; if char>=Z-(26-cipher)
	BRn	leave
	NOT	R5, R5
	ADD	R5, R5, #1; neg (26-cipher)
	ADD	R0, R1, R5; newchar= char -(26-cipher)
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET

leave	LD	R2, TWOHD
	ADD	R2, R2, R4 ; NEW INDEX
	AND	R0, R0, #0
	ADD	R0, R1, #0
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
;DECYRPING ALOGRITHM
Dec	ST	R7, REG7
	LD	R5, CAPA
	ADD	R0, R1,R5
	BRn	leave2  ;leaves character alone, char is not a letter
	NOT	R5, R5
	ADD	R5, R5, #1
	ADD	R5, R5, R3
	NOT	R5, R5
	ADD	R5, R5, #1
	ADD	R5, R5, R1 ;if char<=A+chipher
	BRzp	else
	LD	R5, TWSIX
	NOT	R0, R3
	ADD	R0, R0, #1; gets negative chipher
	ADD	R5, R5, R0; 26-chipher
	ADD	R0, R1, R5; new char== char +(26-chipher)
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
else	LD	R5, CAPZ; 
	NOT	R5, R5
	ADD	R5, R5, #1
	NOT	R0, R3; 
	ADD	R0, R0, #1; gets negative chipher
	ADD	R5, R5, R0; z-chipher
	NOT	R5, R5
	ADD	R5, R5, #1; gets negative (z-chipher)
	ADD	R0, R5, R1; if char>=z-chipher
	BRn	lowcase
	LD	R5, CAPZ
	ADD	R5, R5, R1; if char <=Z (char-Z)
	BRp	lowcase
	NOT	R0, R3
	ADD	R0, R0, #1; GETS NEGATIVE CHIPHER
	ADD	R0, R1, R0; newchar= char-chipher
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1
	LD	R7, REG7
	RET
lowcase	LD	R5, LOWA
	ADD	R0, R1,R5
	BRn	leave2  ;leaves character alone, char is not a letter
	NOT	R5, R5
	ADD	R5, R5, #1
	ADD	R5, R5, R3
	NOT	R5, R5
	ADD	R5, R5, #1
	ADD	R5, R5, R1 ;if char<=A+chipher
	BRzp	else2
	LD	R5, TWSIX
	NOT	R0, R3
	ADD	R0, R0, #1; gets negative chipher
	ADD	R5, R5, R0; 26-chipher
	ADD	R0, R1, R5; new char== char +(26-chipher)
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET
else2	LD	R5, LOWZ; 
	NOT	R5, R5
	ADD	R5, R5, #1
	NOT	R0, R3; 
	ADD	R0, R0, #1; gets negative chipher
	ADD	R5, R5, R0; z-chipher
	NOT	R5, R5
	ADD	R5, R5, #1; gets negative (z-chipher)
	ADD	R0, R5, R1; if char>=z-chipher
	BRn	leave2
	LD	R5, LOWZ
	ADD	R5, R5, R1; if char <=Z (char-Z)
	BRp	lowcase
	NOT	R0, R3
	ADD	R0, R0, #1; GETS NEGATIVE CHIPHER
	ADD	R0, R1, R0; newchar= char-chipher
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1
	LD	R7, REG7
	RET
	
leave2	LD	R2, TWOHD
	ADD	R2, R2, R4 ; NEW INDEX
	AND	R0, R0, #0
	ADD	R0, R1, #0
	PUTC
	STR	R0, R2, #0
	ADD	R4, R4, #1 ;increents ADDRESS
	LD	R7, REG7
	RET


ARR	LEA	R0, ARRAY
	RET		
		;Variable declarations

ASCIIOUT	.FILL		#-48
REG7		.FILL		#0
TWSIX		.FILL		#26
CAPA		.FILL		#-65
CAPM		.FILL		#-77
CAPN		.FILL		#78
CAPZ		.FILL		#-90
aBEF		.FILL		#64
aBEF2		.FILL		#96
ZAFT		.FILL		#91
LOWA		.FILL		#-97
LOWM		.FILL		#-109
LOWZ		.FILL		#-122
zAFT		.FILL		#123
EXPLINATION	.FILL		#-33
ARRAY		.BLKW		#400
	.END