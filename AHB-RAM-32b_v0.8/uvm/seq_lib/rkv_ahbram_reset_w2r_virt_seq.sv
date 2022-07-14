`ifndef RKV_AHBRAM_RESET_W2R_VIRT_SEQ_SV
`define RKV_AHBRAM_RESET_W2R_VIRT_SEQ_SV

class rkv_ahbram_reset_w2r_virt_seq extends rkv_ahbram_base_virtual_sequence;
  `uvm_object_utils(rkv_ahbram_reset_w2r_virt_seq)

  function new (string name = "rkv_ahbram_reset_w2r_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    bit [31:0] addr_q[$];
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    //normal write to read check
    for(int i = 0; i<10; i++) begin
      std::randomize(addr) with {addr[1:0] == 0; addr inside {['h1000:'h1FFF]};};
      std::randomize(wr_val) with {wr_val == (i << 4) + i;};
      addr_q.push_back(addr);
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data;})
      //`uvm_do_with(single_write, {addr == local::addr; data == 'hff;})
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      compare_data(wr_val, rd_val);
    end

    //trigger reset
    vif.assert_reset(10);

    //read check after reset
    do begin
      addr = addr_q.pop_front();
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      if(cfg.init_logic === 1'b0)
        compare_data(32'h0, rd_val);
      else if(cfg.init_logic === 1'bx)
        compare_data(32'hx, rd_val);
      else
        `uvm_error("TYPEERR", "type is not recognized")
    end while(addr_q.size() > 0);

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//RKV_AHBRAM_RESET_W2R_VIRT_SEQ_SV
