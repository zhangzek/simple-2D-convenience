`timescale 1 ns/ 1 ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ZHANG ZEKUN
// 
// Create Date: 2019/08/22 15:01:16
// Design Name: 
// Module Name: Synchronize FIFO
// Project Name:  
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module conv_2d#(
	parameter CORE3X3_0 = 2'b01,
	parameter CORE3X3_1 = 2'b10,
	parameter CORE3X3_2 = 2'b11,
	parameter CORE3X3_3 = 2'b01,
	parameter CORE3X3_4 = 2'b10,
	parameter CORE3X3_5 = 2'b11,
	parameter CORE3X3_6 = 2'b01,
	parameter CORE3X3_7 = 2'b10,
	parameter CORE3X3_8 = 2'b11
)
(	
	input CLK,
	input RSTn,
	input read,
	
	output [7:0] CONV_OUT
);

reg [3:0] ROM [35:0];
reg [5:0] rd;
reg [7:0] CONV_OUT_REG;
reg [3:0] WIN0;
reg [3:0] WIN1;
reg [3:0] WIN2;
reg [3:0] WIN3;
reg [3:0] WIN4;
reg [3:0] WIN5;
reg [3:0] WIN6;
reg [3:0] WIN7;
reg [3:0] WIN8;


initial
begin
	ROM[ 0] = 4'b0001;
	ROM[ 1] = 4'b0010;
	ROM[ 2] = 4'b0011;
	ROM[ 3] = 4'b0100;
	ROM[ 4] = 4'b0101;
	ROM[ 5] = 4'b0110;
	ROM[ 6] = 4'b0111;
	ROM[ 7] = 4'b1000;
	ROM[ 8] = 4'b1001;
	ROM[ 9] = 4'b1010;
	ROM[10] = 4'b1011;
	ROM[11] = 4'b1100;
	ROM[12] = 4'b1101;
	ROM[13] = 4'b1110;
	ROM[14] = 4'b1111;
	ROM[15] = 4'b0000;
	ROM[16] = 4'b0001;
	ROM[17] = 4'b0010;
	ROM[18] = 4'b0011;
	ROM[19] = 4'b0100;
	ROM[20] = 4'b0101;
	ROM[21] = 4'b0110;
	ROM[22] = 4'b0111;
	ROM[23] = 4'b1000;
	ROM[24] = 4'b1001;
	ROM[25] = 4'b1010;
	ROM[26] = 4'b1011;
	ROM[27] = 4'b1100;
	ROM[28] = 4'b1101;
	ROM[29] = 4'b1110;
	ROM[30] = 4'b1111;
	ROM[31] = 4'b0000;
	ROM[32] = 4'b0001;
	ROM[33] = 4'b0010;
	ROM[34] = 4'b0011;
	ROM[35] = 4'b0100;
end


always @ (posedge CLK or negedge RSTn)
begin
	if (!RSTn)
		begin
		WIN0 <= 2'bx;
		WIN1 <= 2'bx;
		WIN2 <= 2'bx;
		WIN3 <= 2'bx;
		WIN4 <= 2'bx;
		WIN5 <= 2'bx;
		WIN6 <= 2'bx;
		WIN7 <= 2'bx;
		WIN8 <= 2'bx;
		rd <= 0;
		end
	else if (read)
	
		begin
			WIN0 = ROM[rd];
			WIN1 = ROM[rd + 4'b0001];
			WIN2 = ROM[rd + 4'b0010];
			WIN3 = ROM[rd + 4'b0110];
			WIN4 = ROM[rd + 4'b0111];
			WIN5 = ROM[rd + 4'b1000];
			WIN6 = ROM[rd + 4'b1100];
			WIN7 = ROM[rd + 4'b1101];
			WIN8 = ROM[rd + 4'b1110];
			rd <= rd + 1'b1;
		end
end

always @ ( posedge CLK or negedge RSTn )
begin
	case (rd)
	6'd3:rd <= rd + 2'b11;
	6'd9:rd <= rd + 2'b11;
	6'd15:rd <= rd + 2'b11;
	
	endcase
end	

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
		CONV_OUT_REG <= 0;
	else 
		CONV_OUT_REG <= WIN0 * CORE3X3_8 + WIN1 * CORE3X3_7 + WIN2 * CORE3X3_6 + WIN3 * CORE3X3_5 + WIN4 * CORE3X3_4 + WIN5 * CORE3X3_3 + WIN6 * CORE3X3_2 + WIN7 * CORE3X3_1 + WIN8 * CORE3X3_0;
end


assign CONV_OUT = CONV_OUT_REG;


endmodule