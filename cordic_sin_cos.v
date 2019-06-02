/*

	Verilog COordinate Rotation DIgital Computer (CORDIC) implementation for calculating sine/cosine values

	Author:
	Ori Novanda (cargmax-at-gmail.com), 2019

	The code is highly inspired by:
	1. "A survey of CORDIC algorithms for FPGA based computers", http://www.andraka.com/files/crdcsrvy.pdf
	2. "Using a CORDIC to calculate sines and cosines in an FPGA", https://zipcpu.com/dsp/2017/08/30/cordic.html
	3. Kirk Weedman's implementaion of CORDIC, http://www.hdlexpress.com/Verilog/VT.html

*/

module CORDIC_sin_cos (clock, strobe_in, angle, strobe_out, cos, sin);
   
	parameter XY_SZ = 16;
	localparam STG = XY_SZ;

	parameter signed [XY_SZ-1:0] Xin = 32000/1.647;
	parameter signed [XY_SZ-1:0] Yin = 0;
   
	input clock;
	input strobe_in;
	input signed [31:0] angle;
	output strobe_out;
	output signed [XY_SZ:0] cos;
	output signed [XY_SZ:0] sin;

	reg signed [XY_SZ:0] X;
	reg signed [XY_SZ:0] Y;
	reg signed [31:0] Z;
	wire signed [XY_SZ:0] X_;
	wire signed [XY_SZ:0] Y_;
	wire signed [31:0] Z_;

	reg [15:0] N;
	reg state = 0, prev_state = 0;
	reg prev_strobe_in = 0;

	wire signed [31:0] cordic_atan_value;
	CORDIC_LUT CORDIC_atan_LUT(N, cordic_atan_value);

	always @(posedge clock) begin
		prev_strobe_in <= strobe_in;
		prev_state <= state;

		if(!prev_strobe_in & strobe_in) begin
			N<=0;
			state <=1;			
		end
		else if(state) begin
			if(N < STG-1)
				N<=N+1;
			else
				state <= 0;
		end
	end

	wire [1:0] quadrant = angle[31:30];
	assign X_ = (N!=0)? X : ((quadrant == 2'b01)? -Yin : ((quadrant == 2'b10)? -Yin: Xin));
	assign Y_ = (N!=0)? Y : ((quadrant == 2'b01)? Xin : ((quadrant == 2'b10)? -Xin: Yin));
	assign Z_ = (N!=0)? Z : ((quadrant == 2'b01)? {2'b00,angle[29:0]} : ((quadrant == 2'b10)? {2'b11,angle[29:0]}: angle));

	always @(posedge clock) begin
		if(!prev_strobe_in & strobe_in) begin
			X <= 0;
			Y <= 0;
			Z <= 0;
		end
		else if(state) begin
			if (Z_[31]) begin
				X <= X_ + (Y_ >>> N);
				Y <= Y_ - (X_ >>> N);
				Z <= Z_ + cordic_atan_value;
			end
			else begin
				X <= X_ - (Y_ >>> N);
				Y <= Y_ + (X_ >>> N);
				Z <= Z_ - cordic_atan_value;
			end
		end
	end
  
	assign cos = X;
	assign sin = Y;
	assign strobe_out = prev_state & !state;

endmodule

