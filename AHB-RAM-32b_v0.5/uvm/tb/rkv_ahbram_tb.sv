
module rkv_ahbram_tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_ahbram_pkg::*;

  logic clk;
  logic rstn;

  initial begin : clk_gen
    clk = 0;
    forever #2ns clk = !clk;
  end

  ahb_blockram_32 #(.ADDRESSWIDTH(16)) dut(
    .HCLK(ahb_if.hclk)
    ,.HRESETn(ahb_if.hresetn)
    ,.HSELBRAM(1'b1)
    ,.HREADY(ahb_if.hready)
    ,.HTRANS(ahb_if.htrans)
    ,.HSIZE(ahb_if.hsize)
    ,.HWRITE(ahb_if.hwrite)
    ,.HADDR(ahb_if.haddr)
    ,.HWDATA(ahb_if.hwdata)
    ,.HREADYOUT(ahb_if.hready)
    ,.HRESP(ahb_if.hresp)
    ,.HRDATA(ahb_if.hrdata)

  );

  lvc_ahb_if ahb_if();
  assign ahb_if.hclk    = clk;
  assign ahb_if.hresetn = rstn;
  assign ahb_if.hgrant  = 1'b1;

  rkv_ahbram_if ahbram_if();
  assign ahbram_if.clk = clk;
  assign rstn          = ahbram_if.rstn;

  initial begin
    uvm_config_db#(virtual lvc_ahb_if)::set(uvm_root::get(), "uvm_test_top.env.ahb_mst", "vif", ahb_if);
    uvm_config_db#(virtual rkv_ahbram_if)::set(uvm_root::get(), "uvm_test_top", "vif", ahbram_if);
    uvm_config_db#(virtual rkv_ahbram_if)::set(uvm_root::get(), "uvm_test_top.env", "vif", ahbram_if);
    uvm_config_db#(virtual rkv_ahbram_if)::set(uvm_root::get(), "uvm_test_top.env.virt_sqr", "vif", ahbram_if);
    run_test();
  end


endmodule


