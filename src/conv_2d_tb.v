module conv_2d_tb();
	reg CLK;
	reg RSTn;
	reg read;
	
	wire [7:0] CONV_OUT;
	
	
initial 
begin
	CLK = 0;
	forever #100 CLK = ~CLK;
end

initial 
begin
	RSTn = 0;
	#50 RSTn = 1;
	read = 1;
end

conv_2d CONV(.CLK(CLK),
			 .RSTn(RSTn),
			 .read(read),
			 .CONV_OUT(CONV_OUT));
			 
endmodule