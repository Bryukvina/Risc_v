module (#parameter pr_lengh = 64) (
    input   [31:0]      i,          //index of current program
    output  [31:0]      rd          //current program
);

    reg     [31:0]      prog_mem [pr_lengh - 1:0];
    assign   rd = prog_mem[i];


    initial begin
        $readmemh("program.txt", prog_mem);
    end