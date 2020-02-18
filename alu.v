// Name: alu.v
// Module: simp_alu_comb
// Input: op1[32] - operand 1
//        op2[32] - operand 2
//        oprn[6] - operation code
// Output: result[32] - output result for the operation
//
// Notes: 32 bit combinatorial ALU
// 
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_rigth (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Sep 06, 2014	Kaushik Patra	kpatra@sjsu.edu		Fixed encoding for not and slt
//  1.2     Sep 08, 2014	Kaushik Patra	kpatra@sjsu.edu		Changed logical operation to bitwise operation for and, or, nor.
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module alu(result, op1, op2, oprn);
// input list
input [`DATA_INDEX_LIMIT:0] op1; // operand 1
input [`DATA_INDEX_LIMIT:0] op2; // operand 2
input [`ALU_OPRN_INDEX_LIMIT:0] oprn; // operation code

// output list
output [`DATA_INDEX_LIMIT:0] result; // result of the operation.

// simulator internal storage - this is not h/w register
reg [`DATA_INDEX_LIMIT:0] result;

// Whenever op1, op2 or oprn changes do something
always @ (op1 or op2 or oprn)
begin
    case (oprn)
        `ALU_OPRN_WIDTH'h01 : result = op1 + op2; // addition
	`ALU_OPRN_WIDTH'h02 : result = op1 - op2; // subtraction
	`ALU_OPRN_WIDTH'h03 : result = op1 * op2; // multiplication
	`ALU_OPRN_WIDTH'h04 : result = op1 >> op2; // shift right
	`ALU_OPRN_WIDTH'h05 : result = op1 << op2; // shift left
	`ALU_OPRN_WIDTH'h06 : result = op1 & op2; // bitwise AND
	`ALU_OPRN_WIDTH'h07 : result = op1 | op2; // bitwise OR
	`ALU_OPRN_WIDTH'h08 : result = ~(op1 | op2); // NOR
	`ALU_OPRN_WIDTH'h09 : result = op1 < op2; // less than 
	//
        // TBD: fill up rest of the operations from here
        // 
        default: result = `DATA_WIDTH'hxxxxxxxx;
                 
    endcase
end

endmodule
