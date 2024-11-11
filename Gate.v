And Gate 
module andCmp(
        input x,
        input y,
        output z
        );
    assign z = x&y;
    endmodule
module andGate;
    reg x;   // Inputx
    reg y;   // Inputy
    	wire z;  // Outputz
    	andCmp uut (
    		.x(x), 
    		.y(y), 
    		.z(z)
    	);
     initial begin  // Initialize Inputs
    	x = 0;
    	y = 0;
                  #20 x = 1;
    	#20 y = 1;
    	#20 x = 0;	
    	//#20 x = 1;	  
    	//#40;
        end  
 initial begin
$display("INPUT\tOUTPUT");
$monitor("x=%d,y=%d,z=%d \n",x,y,z);
    end
     endmodule



Full Adder Verilog Code

module fulladder(a, b, c, sum, carry);
input a, b, c;
output sum, carry;
wire sum, carry;
assign sum = a^b^c; //sum bit
assign carry = ((a&b) | (b&c) | (a&c)); //carry bit
endmodule

/* Test bench for Full Adder */
module main;
reg a, b, c;
wire sum, carry;
fulladder add(a, b, c, sum, carry);
always @(sum or carry)
begin
//$dumpfile("add.vcd");
//$dumpvars(0, add);
$display("Input A= %b B= %b C= %b Sum = %b Carry = %b\n", a, b, c, sum, carry);
end
initial
begin
a= 0; b= 0; c= 0;
#5
a= 0; b= 0; c= 1;
#5
a= 0; b= 1; c= 0;
#5
a= 0; b= 1; c= 1;
#5
a= 1; b= 0; c= 0;
#5
a= 1; b= 0; c= 1;
#5
a= 1; b= 1; c= 0;
#5
a= 1; b= 1; c= 1;
end
endmodule


Excess 3

module BCD2Ex3(A, B, C, D, W, X, Y, Z);
	input A, B, C, D;
	output W, X, Y, Z;
	assign W = A | (B&C) | (B&D);                                                   
	assign X = (~B&C) | (~B & D) | (B & ~C & ~D);
	assign Y = ~( C ^ D);
	assign Z = ~D;
endmodule

module test;
wire W, X,Y,Z;
reg A,B,C,D;
BCD2Ex3  object(A,B,C,D,W,X,Y,Z);
initial begin
	$dumpfile("bcd.vcd");
	$dumpvars(0,test);
	$display (" A  B  C  D |  W  X  Y  Z");
	$monitor(" ",A, "  ",B, "  ",C, "  ",D,  " | ", W, "  ",X, "  ",Y, "  ",Z);
	A = 0;  B = 0; C = 0; D = 0;
	#5  A = 0;  B = 0;  C = 0;  D = 0;
	#5  A = 0;  B = 0;  C = 0;  D = 1;
	#5  A = 0;  B = 0;  C = 1;  D = 0;
	#5  A = 0;  B = 0;  C = 1;  D = 1;
	#5  A = 0;  B = 1;  C = 0;  D = 0;
	#5  A = 0;  B = 1;  C = 0;  D = 1;
	#5  A = 0;  B = 1;  C = 1;  D = 0;
	#5  A = 0;  B = 1;  C = 1;  D = 1;
	#5  A = 1;  B = 0;  C = 0;  D = 0;
	#5  A = 1;  B = 0;  C = 0;  D = 1;
	end
endmodule


Multiplexer

module mux(s1,s2,a,b,c,d,y);
	input s1,s2,a,b,c,d;
	output y;
	assign y = ~s1&~s2&a | ~s1&s2&b | s1&~s2&c | s1&s2&d ;
endmodule
module test;
	reg a, b, c, d, s1, s2;
	wire y;
	mux obj(s1,s2,a,b,c,d,y);
	initial begin
		//$dumpfile("mux.vcd");
		//$dumpvars( 0, test);
		$display("S1\t S2\t A \t B \t C \t D |  Y");
		$monitor("%b \t %b \t %b \t %b \t %b \t %b |  %b",s1,s2,a,b,c,d,y);
		
		a=0; b=0; c=0; d=0; s1=0; s2=0;
		#5  a=0; b=0; c=0; d=0; s1=0; s2=0;
		#5  a=0; b=0; c=0; d=1; s1=0; s2=1;
		#5  a=0; b=0; c=1; d=0; s1=1; s2=0;
		#5  a=0; b=0; c=1; d=1; s1=1; s2=1;
		#5  a=0; b=1; c=0; d=0; s1=0; s2=0;
		#5  a=0; b=1; c=0; d=1; s1=0; s2=1;
		#5  a=0; b=1; c=1; d=0; s1=1; s2=0;
		#5  a=0; b=1; c=1; d=1; s1=1; s2=0;
		#5  a=1; b=0; c=0; d=0; s1=0; s2=1;
		#5  a=1; b=0; c=0; d=1; s1=0; s2=0;
		#5 $finish;
	end
endmodule 



Demultiplexer

module demux(s1,s0,a,b,c,d,e,i);
	input s1,s0,e,i;
	output a,b,c,d;
	assign a =i&e&~s1&~s0;
	assign b =i&e&~s1&s0;
	assign c =i&e&s1&~s0;
	assign d =i&e&s1&s0;
endmodule
module test;
	reg s1, s0, e, i;
	wire a, b, c, d;
	demux obj(s1,s0,a,b,c,d,e,i);
	initial 
		begin
		//$dumpfile("demux.vcd");
		//$dumpvars(0, test);
		$display("e\ts1\ts0\td\tc\tb\ta");
		$monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b" ,e,s1,s0,d,c,b,a);
		i=1; e=0; s1=0; s0=0;
		#10  i=1; e=1; s1=0; s0=0;
		#10  i=1; e=1; s1=0; s0=1;
		#10  i=1; e=1; s1=1; s0=0;
		#10  i=1; e=1; s1=1; s0=1;
	 //$finish;
	end
endmodule



Decoder
module decoder(a,b,c,d,e,f,E);
	input a,b,E;
	output c,d,e,f;
	assign c = E&a&b;
	assign d = E&a&(~b);
	assign e = E&(~a)&b;
	assign f = E&(~a)&(~b);
endmodule 
module testbench;
	reg a, b, E;
	wire c,d,e,f;
	decoder obj(a,b,c,d,e,f,E);
	initial begin
		$display("Inputs      |  Outputs");
		$display("E  a  b  |  c  d  e  f");
		$monitor("%b  %b  %b  |  %b  %b  %b  %b",E,a,b,c,d,e,f);
		E=0 ; a=0; b=0; 
		#5 E=1; a=0; b=0; 
		#5 E=1; a=0; b=1; 
		#5 E=1; a=1; b=0;
		#5 E=1; a=1; b=1;
		#5	$finish;
	end
endmodule



Encoder

module encoder(a,b,c,d,p,q);
	input a,b,c,d;
	output p,q;
	assign p = a | b;
	assign q = a | c;
endmodule
module test;
	reg a, b, c, d;
	wire p,q;
	encoder obj(a,b,c,d,p,q);
	initial begin
		
		$display("Inputs      |  Outputs");
		$display("A  B  C  D  |  P  Q");
		$monitor("%b  %b  %b  %b  |  %b  %b",a,b,c,d,p,q);
		a=0; b=0; c=0; d=1; 
		#5 a=0; b=0; c=1; d=0; 
		#5 a=0; b=1; c=0; d=0; 
		#5 a=1; b=0; c=0; d=0;
		
	end
endmodule



