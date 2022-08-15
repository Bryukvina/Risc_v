`include "programm_list.v"

module alu
(
    input  [31:0]     srcA,
    input  [31:0]     srcB,
    input  [ 2:0]     prog,
    output            branch_zero,
    output reg [31:0] result
);
    always @ (*) begin
        case (prog)
            default   : result = srcA + srcB;
            `ALU_ADD  : result = srcA + srcB;
            `ALU_OR   : result = srcA | srcB;
            `ALU_SRL  : result = srcA >> srcB [4:0];
            `ALU_SLTU : result = (srcA < srcB) ? 1 : 0;
            `ALU_SUB  : result = srcA - srcB;
        endcase
    end

    assign branch_zero   = (result == 0);
endmodule
