module tb;
reg t_i0,t_i1,t_s;
wire t_y;
DUT DUT (.I0(t_i0),.I1(t_i1),.S(t_s),.Y(t_y));
integer i,errors=0;
string vcd_file;
initial if ($value$plusargs("vcd=%s",vcd_file)) begin
  $dumpfile(vcd_file); $dumpvars(0,DUT);
end
initial begin
  for(i=0;i<8;i=i+1) begin
    {t_i0,t_i1,t_s}=i[2:0]; #5;
    if(t_y !== (t_s ? t_i1 : t_i0)) begin
      $display("FAIL at %0t: I0=%b I1=%b S=%b Y=%b",$time,t_i0,t_i1,t_s,t_y);
      errors=errors+1;
    end
  end
  $display("MUX: %0d/8 passed",8-errors); $finish;
end
initial $monitor($time," I0=%b I1=%b S=%b | Y=%b",t_i0,t_i1,t_s,t_y);
endmodule
