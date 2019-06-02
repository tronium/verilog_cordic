module CORDIC_LUT(N, value);
	input [15:0] N;
	output signed [31:0] value;

	wire signed [31:0] atan_LUT [0:30];

	assign atan_LUT[00] = 32'b00100000000000000000000000000000; // atan(2^0)
	assign atan_LUT[01] = 32'b00010010111001000000010100011101; // atan(2^-1)
	assign atan_LUT[02] = 32'b00001001111110110011100001011011; // atan(2^-2)
	assign atan_LUT[03] = 32'b00000101000100010001000111010100; // ...
	assign atan_LUT[04] = 32'b00000010100010110000110101000011;
	assign atan_LUT[05] = 32'b00000001010001011101011111100001;
	assign atan_LUT[06] = 32'b00000000101000101111011000011110;
	assign atan_LUT[07] = 32'b00000000010100010111110001010101;
	assign atan_LUT[08] = 32'b00000000001010001011111001010011;
	assign atan_LUT[09] = 32'b00000000000101000101111100101110;
	assign atan_LUT[10] = 32'b00000000000010100010111110011000;
	assign atan_LUT[11] = 32'b00000000000001010001011111001100;
	assign atan_LUT[12] = 32'b00000000000000101000101111100110;
	assign atan_LUT[13] = 32'b00000000000000010100010111110011;
	assign atan_LUT[14] = 32'b00000000000000001010001011111001;
	assign atan_LUT[15] = 32'b00000000000000000101000101111101;
	assign atan_LUT[16] = 32'b00000000000000000010100010111110;
	assign atan_LUT[17] = 32'b00000000000000000001010001011111;
	assign atan_LUT[18] = 32'b00000000000000000000101000101111;
	assign atan_LUT[19] = 32'b00000000000000000000010100011000;
	assign atan_LUT[20] = 32'b00000000000000000000001010001100;
	assign atan_LUT[21] = 32'b00000000000000000000000101000110;
	assign atan_LUT[22] = 32'b00000000000000000000000010100011;
	assign atan_LUT[23] = 32'b00000000000000000000000001010001;
	assign atan_LUT[24] = 32'b00000000000000000000000000101000;
	assign atan_LUT[25] = 32'b00000000000000000000000000010100;
	assign atan_LUT[26] = 32'b00000000000000000000000000001010;
	assign atan_LUT[27] = 32'b00000000000000000000000000000101;
	assign atan_LUT[28] = 32'b00000000000000000000000000000010;
	assign atan_LUT[29] = 32'b00000000000000000000000000000001;
	assign atan_LUT[30] = 32'b00000000000000000000000000000000;

	assign value = atan_LUT[N];
endmodule
