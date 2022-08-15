`include "programm_list.vh"

module top_file
(
    input           clk,        // clock
    input           rst_n,      // reset
);
    //control wires
    wire        aluZero;
    wire        pcSrc;
    wire        regWrite;
    wire        aluSrc;
    wire        wdSrc;
    wire  [2:0] aluControl;

    control_unit control (
        .cmdOp      (cmdOp     ),
        .cmdF3      (cmdF3     ),
        .cmdF7      (cmdF7     ),
        .aluZero    (aluZero   ),
        .pcSrc      (pcSrc     ),
        .regWrite   (regWrite  ),
        .aluSrc     (aluSrc    ),
        .wdSrc      (wdSrc     ),
        .aluControl (aluControl) 
    );
    
    //program counter
    wire [31:0] pc;
    wire [31:0] pcBranch = pc + immB;
    wire [31:0] pcPlus4  = pc + 4;
    wire [31:0] pcNext   = pcSrc ? pcBranch : pcPlus4;
    always @(posedge clk, negedge rst_n) begin
        if ~(rst_n) pc <= 31'b0;
        else pc <= pcNext;
    end


    //program memory access
    wire [31:0] instAdd = pc >> 2;
    wire [31:0] instr;

    instraction_memory im (
        .i      (instAdd),
        .rd     (instr)
    );

    //instruction decoder
    wire [ 6:0] cmdOp;
    wire [ 2:0] cmdF3;
    wire [ 6:0] cmdF7;    
    wire [ 4:0] rs1;
    wire [ 4:0] rs2;
    wire [ 4:0] rd;
    wire [31:0] immI;
    wire [31:0] immB;
    wire [31:0] immU;

    instraction_decoder id (
        .instr      (instr ),
        .cmdOp      (cmdOp ),
        .rd         (rd    ),
        .cmdF3      (cmdF3 ),
        .rs1        (rs1   ),
        .rs2        (rs2   ),
        .cmdF7      (cmdF7 ),
        .immI       (immI  ),
        .immB       (immB  ),
        .immU       (immU  ) 
    );

    //register file
    wire [31:0] rd1;
    wire [31:0] rd2;
    wire [31:0] wd3;

    assign wd3 = wdSrc ? immU : aluResult;

    register_file rf (
        .clk        (clk     ),
        .a1         (rs1     ),
        .a2         (rs2     ),
        .a3         (rd      ),
        .rd1        (rd1     ),
        .rd2        (rd2     ),
        .wd3        (wd3     ),
        .we3        (regWrite)
    );


    //alu
    wire [31:0] srcB = aluSrc ? immI : rd2;
    wire [31:0] aluResult;

    alu alu (
        .srcA       (rd1       ),
        .srcB       (srcB      ),
        .prog       (aluControl),
        .branch_zero(aluZero   ),
        .result     (aluResult ) 
    );


endmodule
