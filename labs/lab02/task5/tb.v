module tb;
reg [3:0] a,b;
reg op;
wire [3:0] result;
reg [3:0] expected;
integer i,j,k,errors=0,total=0;
alu DUT (.a(a),.b(b),.op(op),.result(result));
string vcd_file;
initial if ($value$plusargs("vcd=%s",vcd_file)) begin
  $dumpfile(vcd_file); $dumpvars(0,tb);
end
task check;
  begin
    #5; expected=op ? a-b : a+b; total=total+1;
    if(result !== expected) begin
      $display("FAIL at %0t: a=%0d b=%0d op=%b got=%0d expected=%0d",$time,a,b,op,result,expected);
      errors=errors+1;
    end
  end
endtask
initial begin
  a=5; b=3; op=0; check;
  op=1; check;
  a=8; b=2; check;
  a=3; b=7; check;
  for(i=0;i<16;i=i+1)
    for(j=0;j<16;j=j+1)
      for(k=0;k<2;k=k+1) begin
        a=i; b=j; op=k; check;
      end
  $display("ALU: %0d/%0d passed",total-errors,total); $finish;
end
endmodule
