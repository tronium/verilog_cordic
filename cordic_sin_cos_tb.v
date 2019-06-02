module cordic_test;

	localparam  SZ = 16;

	reg clk;
	reg strobe_in;
	reg [31:0] angle;

	wire strobe_out;
	wire signed [SZ:0] CosOut, SinOut;

	reg [15:0] i;

	CORDIC_sin_cos sin_cos_uut (clk, strobe_in, angle, strobe_out, CosOut, SinOut);

	initial begin
		//$dumpfile("dump.vcd");
		//$dumpvars(1);
	end

	initial begin
		strobe_in = 0;
		clk = 0;
		forever begin
			#5 clk = 1;
			#5 clk = 0;
		end
	end


	initial begin
		$display("Generating CSV data for making a spreadsheet chart");
		$write("Angle, Cos, Sine\n");

		for (i = 0; i < 360; i = i + 1) begin
			@(posedge clk);
			angle = ((1 << 32)*i)/360;
			strobe_in = 1;
			@(posedge clk);
			strobe_in = 0;
			@(posedge strobe_out);
			$display("%d, %d, %d", i, CosOut, SinOut);
	   end

	   $display("Simulation end");
	   $finish;
	end

endmodule
