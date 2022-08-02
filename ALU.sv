module alu
(
    input  [31:0]   A,
    input  [31:0]   B,
    input  [ 2:0]   prog,
    output          is_zero,
    output reg [31:0] result
);
    always @ (*) begin
        case (prog)
            default   : result = srcA + srcB;
            `ADD  : result = srcA + srcB;
            `OR   : result = srcA | srcB;
            `SRL  : result = srcA >> srcB [4:0];
            `SLTU : result = (srcA < srcB) ? 1 : 0;
            `SUB : result = srcA - srcB;
        endcase
    end

    assign is_zero  = (result == 0);
endmodule
