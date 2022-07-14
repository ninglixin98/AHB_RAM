`ifndef RKV_AHBRAM_IF_SV
`define RKV_AHBRAM_IF_SV

interface rkv_ahbram_if;
  logic clk;
  logic rstn;


  initial begin: rstn_gen
    assert_reset(10);
  end

  task automatic assert_reset(int nclks = 1, int delay = 0);
    #(delay * 1ns);
    repeat(nclks) @(posedge clk);
    rstn <= 0;
    repeat(nclks) @(posedge clk);
    rstn <= 1;
  endtask

endinterface

`endif//RKV_AHBRAM_IF_SV

