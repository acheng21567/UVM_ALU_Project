module ALU_tb_top();

    ALU_BFM     bfm();
    tester      iTester(bfm);
    coverage    iCoverage(bfm);
    scoreboard  iScoreboard(bfm);

    // Instantiate the ALU
    ALU iDUT (.clk(bfm.clk), .rst_n(bfm.rst_n), .A(bfm.A), .B(bfm.B), .start(bfm.start), .opcode(bfm.op),
              .result(bfm.result), .done(bfm.done));

endmodule: ALU_tb_top