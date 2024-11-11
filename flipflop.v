D Flip Flop
module d_Flipflop(D,Clk,Q);
input D, Clk;
output reg Q;
always @(posedge Clk)
begin
    Q<=D;
end
endmodule

module dflipflop_tb;
reg D, Clk;
wire Q;
d_Flipflop fp(D,Clk,Q);
initial begin 
Clk =0;
forever #10 Clk = ~Clk;
end 
initial begin
$display("T\tClk\tD\t|Q");
$monitor("%0t\t %d\t%d\t|%d",$time,Clk,D,Q);
end
initial begin
D=0;
#20 D=1;
#20 D=0;
#20 D=1;
$finish;
end
endmodule




Async D flipflop
module Adff(d,rstn,clk,q);
input d,rstn,clk;
output reg q;
always@(posedge clk or negedge rstn)
	if (!rstn )
		q<=0;
	else
		q<=d;
endmodule

module tv_dff;
 reg d, rstn, clk;
 Adff obj(d, rstn, clk, q);

always #10 clk = ~clk;

initial begin
 $display(" T\treset  clk  D | q");
$monitor(" %0t\t %d\t %d\t %d\t| %d",$time,rstn,clk,d,q);
 end

	integer i;
	initial begin	
		clk =0; d =0; rstn  =0;
		
		#5 rstn =1;
		
		repeat(6) begin
		      d =$urandom_range(0,1);
		     #5;
		end
		rstn = 0; 
		//#5 rstn = 1;
		repeat(6) begin
		      d =$urandom_range(0,1);
		     #5;
		end
		$finish;
	end		
endmodule  



JK Flip Flop

module jkff(input [1:0] jk,input clk,output reg q,output reg qb);
	always@(posedge clk)
	begin
		case(jk)
		        2'b00:    q=q;
		        2'b01:     q=0;
		        2'b10:     q=1;
		         2'b11:     q=~q;
		endcase
		qb=~q;
	end
endmodule
//testbench for JK FF
module test;
	reg [1:0] jk;
	reg clk,i;
	wire q,qb;
	jkff ob(jk,clk,q,qb);
	
	initial begin
		$dumpfile("first.vcd");
		$dumpvars(1,test);
		$display("time\tclk\tjk1\tjk0\tq\t~q");
		$monitor("%0t\t%b\t%b\t%b\t%b\t%b",$time,clk,jk[1],jk[0],q,qb);
		jk=2'b00;   #10
		jk=2'b01;    #10
		jk=2'b10;    #10
		jk=2'b11;     #10
		$finish;
	end
	initial begin
		clk=0;
		for(i=0;i<=20;i++)
		#5 clk=~clk;
	end
endmodule



Counter

module counter(clk,rst,en,c);
input clk, rst,en; 
output [1:0] c; 
reg [1:0] c;
always @ (posedge (clk))
begin 
if(rst == 1)
c = 2'b00; 
else if(en == 1) 
c = c+1; 
end
endmodule

module simulate;
reg clk, rst, en; 
wire [1:0] c; 
integer a;
counter obj (clk, rst,en,c); 
initial begin
$display ("CLK RST EN| count") ;
$monitor("%b %b %b | %b", clk, rst, en,c) ;

rst=1; #2

en=1;rst=0; #16 
en=0;rst=0; #2 
en=1;rst=0; #10 
en=1;rst=1; #2 
$finish;
end
initial
begin
clk=0; 
for(a=0;a<32;a++) 
#1 clk = ~clk; // duration of each pulse is 1 time unit
end
endmodule
