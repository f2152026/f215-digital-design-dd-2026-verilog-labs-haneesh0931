module tb;
reg [1:0] t_a,t_b;
wire t_gt,t_lt,t_eq;
reg exp_gt,exp_lt,exp_eq;
integer i,j,errors=0;
comp2 DUT (.A(t_a),.B(t_b),.GT(t_gt),.LT(t_lt),.EQ(t_eq));
string vcd_file;
initial if ($value$plusargs("vcd=%s",vcd_file)) begin
  $dumpfile(vcd_file); $dumpvars(0,tb);
end
initial begin
  for(i=0;i<4;i=i+1) begin
    for(j=0;j<4;j=j+1) begin
      t_a=i; t_b=j;
      exp_gt=(i>j); exp_lt=(i<j); exp_eq=(i==j); #5;
      if({t_gt,t_lt,t_eq} !== {exp_gt,exp_lt,exp_eq}) begin
        $display("FAIL at %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b",$time,t_a,t_b,t_gt,t_lt,t_eq,exp_gt,exp_lt,exp_eq);
        errors=errors+1;
      end
    end
  end
  $write("Comparator: "); $display("%0d/16 passed",16-errors); $finish;
end
endmodule
