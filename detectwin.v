// DetectWinner
// Detects whether either ain or bin has three in a row 
// Inputs:
//   ain, bin - (9-bit) current positions of type a and b
// Out:
//   win_line - (8-bit) if A/B wins, one hot indicates along which row, col or diag
//   win_line(0) = 1 means a win in row 8 7 6 (i.e., either ain or bin has all ones in this row)
//   win_line(1) = 1 means a win in row 5 4 3
//   win_line(2) = 1 means a win in row 2 1 0
//   win_line(3) = 1 means a win in col 8 5 2
//   win_line(4) = 1 means a win in col 7 4 1
//   win_line(5) = 1 means a win in col 6 3 0
//   win_line(6) = 1 means a win along the downward diagonal 8 4 0
//   win_line(7) = 1 means a win along the upward diagonal 2 4 6

module DetectWinner( input [8:0] ain, bin, output [7:0] win_line);
  // CPEN 211 LAB 3, PART 1: your implementation goes here
	wire [7:0] internal_wl_a, internal_wl_b; // for setting the signal in an always block
	wire x_win, o_win;

	ain_winner A(ain, x_win, internal_wl_a);
	bin_winner B(bin, o_win, internal_wl_b);	

	assign win_line = (internal_wl_a | internal_wl_b);	
endmodule
//detects if bin won, and where
	module bin_winner (bin, o_win, internal_wl_b);
		input [8:0] bin;
		output o_win; //for bonus question
		output reg [7:0] internal_wl_b;
		
		always @(*) begin
			internal_wl_b = 8'b00000000;
			casex(bin) //setting internal_wl_b to show winning row in bin
				9'b111xxxxxx: internal_wl_b[0]=1;
				9'bxxx111xxx: internal_wl_b[1]=1;
				9'bxxxxxx111: internal_wl_b[2]=1;		
				9'b1xx1xx1xx: internal_wl_b[3]=1;	
				9'bx1xx1xx1x: internal_wl_b[4]=1;
				9'bxx1xx1xx1: internal_wl_b[5]=1;
				9'b1xxx1xxx1: internal_wl_b[6]=1;
				9'bxx1x1x1xx: internal_wl_b[7]=1;
				default: internal_wl_b=8'b00000000;
			endcase

		end
		assign o_win = (|internal_wl_b);
	endmodule

//detects if ain won, and where
	module ain_winner (ain, x_win, internal_wl_a);
		input [8:0] ain;
		output x_win; //for bonus question
		output reg [7:0] internal_wl_a;
		
		
		always @(*) begin
			internal_wl_a = 8'b00000000;
			casex(ain) //setting internal_wl_a to show winning row in ain
				9'b111xxxxxx: internal_wl_a[0]=1;
				9'bxxx111xxx: internal_wl_a[1]=1;
				9'bxxxxxx111: internal_wl_a[2]=1;		
				9'b1xx1xx1xx: internal_wl_a[3]=1;	
				9'bx1xx1xx1x: internal_wl_a[4]=1;
				9'bxx1xx1xx1: internal_wl_a[5]=1;
				9'b1xxx1xxx1: internal_wl_a[6]=1;
				9'bxx1x1x1xx: internal_wl_a[7]=1;
				default: internal_wl_a=8'b00000000;
			endcase

		end
		assign x_win = (|internal_wl_a);
	endmodule
	




