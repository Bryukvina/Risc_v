module instraction_decoder (
    input          [31:0]   instr,
    output         [ 6:0]   Op,
    output         [ 4:0]   rd,
    output         [ 2:0]   F3,
    output         [ 4:0]   rs1,
    output         [ 4:0]   rs2,
    output         [ 6:0]   F7,
    output logic   [31:0]   I,
    output logic   [31:0]   B,
    output logic   [31:0]   U
);

    assign Op    = instr[ 6: 0];
    assign rd    = instr[11: 7];
    assign F3    = instr[14:12];
    assign rs1   = instr[19:15];
    assign rs2   = instr[24:20];
    assign F7    = instr[31:25];
    assign I     = {{21 {instr[31]}}, instr[30:20]};                                    //I_immediate
    assign B     = {{20 {instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};       //B_immediate
    assign U     = {instr[31:12], 12'b0};                                               //U_immediate

    

endmodule
