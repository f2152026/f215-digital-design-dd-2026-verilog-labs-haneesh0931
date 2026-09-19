module tb;
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  integer i,errors=0;
  lut #(.WIDTH(8),.DEPTH(8)) DUT (.sel(t_sel),.dout(t_dout));
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end
  initial begin
    for(i=0;i<8;i=i+1) begin
      t_sel=i; #5;
      if(t_dout !== i*i) begin
        $display("FAIL at %0t: sel=%0d got=%0d expected=%0d",$time,t_sel,t_dout,i*i);
        errors=errors+1;
      end
    end
    $display("ROM: %0d/8 passed",8-errors); $finish;
  end
  initial $monitor($time," sel=%0d | dout=%0d",t_sel,t_dout);
endmodule
