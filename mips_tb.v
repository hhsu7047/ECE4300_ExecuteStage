`timescale 1ns / 1ps

module mips_tb();
    reg clk;
    reg rst;

    //top level file 
    mips_top uut (
        .clk(clk),
        .rst(rst)
    );

    // 100MHz Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Reset the system first then wait
        rst = 1;
        #20; 
        rst = 0; 
        
       //run for at least 100ns
        #200;

        $display("Simulation Complete.");
        $stop;
    end

    //monitor the "Writeback" loop to see if math is actually happening
    initial begin
        $monitor("Time: %0t | PC: %h | Instr: %h | ALU Result: %h | Writing to Reg: %d | Data: %h", 
                 $time, uut.IF_STAGE.pc_out, uut.if_id_instr, uut.ex_mem_alu_res, uut.wb_write_reg_addr, uut.wb_write_data);
    end
endmodule