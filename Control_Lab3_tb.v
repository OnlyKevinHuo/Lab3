`timescale 1ns / 1ps

module control_tb;

    // Inputs
	reg clk;
	reg rst;
	reg [5:0] instr_op;
	reg [5:0] instr_5_0;

    // Outputs
	wire reg_dst;
	wire branch;
	wire mem_read;
	wire mem_to_reg;
	wire mem_write;
	wire alu_src;
	wire reg_write;
	reg [3:0] alu_out;
	reg [1:0] alu_op;
	
    // Instantiate Unit Under Test (uut)
    control uut(
            .clk(clk),
			.rst(rst),
			.instr_op(instr_op),
			.reg_dst(reg_dst),
			.branch(branch),
			.mem_read(mem_read),
			.mem_to_reg(mem_to_reg),
			.alu_op(alu_op),
			.mem_write(mem_write),
			.alu_src(alu_src),
			.reg_write(reg_write)
       
    );

	alu_control aluct(
			.alu_op(alu_op),
			.instr_5_0(instr_5_0),
			.alu_out(alu_out)
	
	
	);

    initial begin 
		// Initialize inputs
        clk = 0; // Clear clock
        rst = 0; // Clear reset

        // Wait 100 ns for global reset to finish
        #100;

        // Synchronous reset
        rst = 1; clk = 0; #100
        rst = 1; clk = 1; #100
        rst = 0; clk = 0; #100

        // Start the clock
        forever begin 
            #5 clk = ~clk;
        end
    end

    integer totalTests = 0;
    integer failedTests = 0;
	integer checker = 0;
    initial begin
        // Initialize inputs

        // Wait 100 ns for global reset to finish
        #100;

        // Wait for reset to finish
        #10

        // Test:
		 $write("Test case 1: Testing ADD ");
        totalTests = totalTests + 1;
         instruction_5_0 = 6'b100000;
		instr_op = 6'b000000;
		#100; 
		if (reg_dst != 1'b1) begin
			$display  ("Reg dst is wrong");
			checker = checker + 1;
		end
		if (alu_src    != 1'b0) begin
			$display   ("Alu Src is wrong");
			checker = checker + 1;
		end
		if (mem_to_reg != 1'b1) begin 
			$display("Mem to Reg is wrong");
			checker = checker + 1;
		end
		if (reg_write  != 1'b1) begin
			$display ("Reg Write is wrong");
			checker = checker + 1;
		end
		if (mem_read   != 1'b0) begin
			$display ("Mem read is wrong");
			checker = checker + 1;
		end
		if (mem_write  != 1'b0) begin
			$display ("Mem write is wrong");
			checker = checker + 1;
		end
		if (branch != 1'b0) begin
			$display ("Branch is wrong");
			checker = checker + 1;
		end
		if (alu_out != 4'b0010) begin
			$display ("Alu out is wrong");
			checker = checker + 1;
		end

        if (checker > 0) begin 
            $display("...failed");
            failedtests += 1;
        end else begin
            $display("...passed");
        end
			
		checker = 0;

		#100;

        // Wait for reset to finish
        #10

		$write("Test case 2: Testing SUB ");
        totalTests = totalTests + 1;
         instruction_5_0 = 6'b100010;
		instr_op = 6'b000000;
		#100; 
		if (reg_dst != 1'b1) begin
			$display  ("Reg dst is wrong");
			checker = checker + 1;
		end
		if (alu_src    != 1'b0) begin
			$display   ("Alu Src is wrong");
			checker = checker + 1;
		end
		if (mem_to_reg != 1'b1) begin 
			$display("Mem to Reg is wrong");
			checker = checker + 1;
		end
		if (reg_write  != 1'b1) begin
			$display ("Reg Write is wrong");
			checker = checker + 1;
		end
		if (mem_read   != 1'b0) begin
			$display ("Mem read is wrong");
			checker = checker + 1;
		end
		if (mem_write  != 1'b0) begin
			$display ("Mem write is wrong");
			checker = checker + 1;
		end
		if (branch != 1'b0) begin
			$display ("Branch is wrong");
			checker = checker + 1;
		end
		if (alu_out != 4'b0110) begin
			$display ("Alu out is wrong");
			checker = checker + 1;
		end

        if (checker > 0) begin 
            $display("...failed");
            failedtests += 1;
        end else begin
            $display("...passed");
        end
			
		checker = 0;

		#100;

        // Wait for reset to finish
        #10
		$write("Test case 3: Testing AND ");
        totalTests = totalTests + 1;
         instruction_5_0 = 6'b100100;
		instr_op = 6'b000000;
		#100; 
		if (reg_dst != 1'b1) begin
			$display  ("Reg dst is wrong");
			checker = checker + 1;
		end
		if (alu_src    != 1'b0) begin
			$display   ("Alu Src is wrong");
			checker = checker + 1;
		end
		if (mem_to_reg != 1'b0) begin 
			$display("Mem to Reg is wrong");
			checker = checker + 1;
		end
		if (reg_write  != 1'b1) begin
			$display ("Reg Write is wrong");
			checker = checker + 1;
		end
		if (mem_read   != 1'b0) begin
			$display ("Mem read is wrong");
			checker = checker + 1;
		end
		if (mem_write  != 1'b0) begin
			$display ("Mem write is wrong");
			checker = checker + 1;
		end
		if (branch != 1'b0) begin
			$display ("Branch is wrong");
			checker = checker + 1;
		end
		if (alu_out != 4'b0000) begin
			$display ("Alu out is wrong");
			checker = checker + 1;
		end

        if (checker > 0) begin 
            $display("...failed");
            failedtests += 1;
        end else begin
            $display("...passed");
        end
			
		checker = 0;

		#100;

        // Wait for reset to finish
        #10

		$write("Test case 4: Testing BEQ ");
        totalTests = totalTests + 1;
         instruction_5_0 = 6'b101010;
		instr_op = 6'b000100;
		#100; 
		if (reg_dst != 1'b0) begin
			$display  ("Reg dst is wrong");
			checker = checker + 1;
		end
		if (alu_src    != 1'b0) begin
			$display   ("Alu Src is wrong");
			checker = checker + 1;
		end
		if (mem_to_reg != 1'b1) begin 
			$display("Mem to Reg is wrong");
			checker = checker + 1;
		end
		if (reg_write  != 1'b0) begin
			$display ("Reg Write is wrong");
			checker = checker + 1;
		end
		if (mem_read   != 1'b0) begin
			$display ("Mem read is wrong");
			checker = checker + 1;
		end
		if (mem_write  != 1'b0) begin
			$display ("Mem write is wrong");
			checker = checker + 1;
		end
		if (branch != 1'b1) begin
			$display ("Branch is wrong");
			checker = checker + 1;
		end
		if (alu_out != 4'b0110) begin
			$display ("Alu out is wrong");
			checker = checker + 1;
		end

        if (checker > 0) begin 
            $display("...failed");
            failedtests += 1;
        end else begin
            $display("...passed");
        end
			
		checker = 0;

		#100;

        // Wait for reset to finish
        #10

		
        $display("\n-----------------------------------------");
        $display("\nTesting complete\nPassed %d/%d tests", totalTests-failedTests,totalTests);
        $display("\n-----------------------------------------");
    end
endmodule