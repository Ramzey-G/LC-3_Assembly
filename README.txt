These are my programs writtenin LC-3 Assebly. The LC-3 is a computer (Little Computer 3) that is used for educational purposes to teach 
students how to program in Assembly. I was introduced to the LC-3 in an Engineering course at UC Santa Cruz.

In order to run these programs the LC-3 Stimulator must be used. this stimulator is an emulator which emulates the hardware of an LC-3.
With this stimulator, users are able to run through their program step by step, run through the program as a whole, or run through the 
program until a break point is reached.

Programming for LC-3:
Programming for the LC-3 is tedious. For me, these programs have enhaced my ability to break down real world problems in simple mathmatics.
There is a limit of 19 commands (Instructions) which can be seen in the Instruction Set Architecture (ISA) in this repository. 

LC-3 Commands:
ADD - adds 2 registers together
ADD - can be used to add one register and one value (immidiate)
TRAP - used only for I/O form the user. See more later

LC-3 Architecture:
-RISC (Reduced Instruction Set Computer) architecture (only 19 commands)
-16 Bit data and address (each command uses 16 bits of storage. See how it works in the LC3 ISA png in the repository)
-8 General Purpose Registers (GPR)
-4 special-purpose registers:
  +Program Counter (PC)- points to the address of the next line of code that is to be executed by the Assembler
  +Instructin Register (IR)
  +Condition Code Register(CC)
  +Process Status Register(PSR)
- 16 kb of memory (RAM)

LC-3 ISA
In order to understand the ISA png in the repository one must understand how the oopcode (commands) work with 16 bit data. The first
four bits contain the instruction's opcode. From here the commands vary. Here are some useful abrivations used for the LC-3 ISA:
DR- Destination Register. This is the register in which the result of this command will be stored in. (Try to think of registers like variables)
SR1 - Source Register 1. This is the register that is being used in the command.
SR2 - Source Register 2. This is the second register that is being usedinthe command. 
	EX: ADD R0, R1, R2 ;//adds contents of register 1 and register 2 and stores it into register 0
			    //R1 is SR1, R2 is SR2 and R0 is the DR
PCoffset9- This is used when telling the LC-3 to move the Program Counter (PC) to a specific line of code. This label must be no greater than 9 bits
