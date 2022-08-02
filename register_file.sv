module (
    input   clk,
    input   a1,
    input   a2,
    input   a3,
    input   wd3,
    input   we3,

    output  rd1,
    output  rd2
);

    reg [31:0] rf [31:0];

    assign rd0 = (a1 != 0) ? rf [a1] : 32'b0;
    assign rd1 = (a2 != 0) ? rf [a2] : 32'b0;
    assign rd2 = (a3 != 0) ? rf [a3] : 32'b0;

    always @ (posedge clk) begin
        if(we3) rf [a3] <= wd3;
    end
    
endmodule



