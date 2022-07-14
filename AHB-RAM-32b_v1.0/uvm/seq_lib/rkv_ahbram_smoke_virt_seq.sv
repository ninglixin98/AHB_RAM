`ifndef RKV_AHBRAM_SMOKE_VIRT_SEQ_SV
`define RKV_AHBRAM_SMOKE_VIRT_SEQ_SV

class rkv_ahbram_smoke_virt_seq extends rkv_ahbram_base_virtual_sequence;
  `uvm_object_utils(rkv_ahbram_smoke_virt_seq)

  function new (string name = "rkv_ahbram_smoke_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i<10; i++) begin
      std::randomize(addr) with {addr[1:0] == 0; addr inside {['h1000:'h1FFF]};};
      std::randomize(wr_val) with {wr_val == (i << 4) + i;};
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data;})
      //`uvm_do_with(single_write, {addr == local::addr; data == 'hff;})
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      compare_data(wr_val, rd_val);
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//RKV_AHBRAM_SMOKE_VIRT_SEQ_SV
