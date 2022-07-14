`ifndef RKV_AHBRAM_HADDR_WORD_UNALIGNED_VIRT_SEQ_SV
`define RKV_AHBRAM_HADDR_WORD_UNALIGNED_VIRT_SEQ_SV

class rkv_ahbram_haddr_word_unaligned_virt_seq extends rkv_ahbram_base_virtual_sequence;
  `uvm_object_utils(rkv_ahbram_haddr_word_unaligned_virt_seq)

  function new (string name = "rkv_ahbram_haddr_word_unaligned_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    burst_size_enum bsize;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i<100; i++) begin
      std::randomize(bsize) with {bsize inside {BURST_SIZE_8BIT, BURST_SIZE_16BIT, BURST_SIZE_32BIT};};
      std::randomize(addr) with { addr inside {['h1000:'h1FFF]};
                                  bsize == BURST_SIZE_16BIT -> addr[0] == 0;
                                  bsize == BURST_SIZE_32BIT -> addr[1:0] == 0;
                                };
      std::randomize(wr_val) with {wr_val == (i << 24) + (i << 16) + (i << 8) + i;}; 
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data; bsize == local::bsize;})
      `uvm_do_with(single_read, {addr == local::addr; bsize == local::bsize;})
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//RKV_AHBRAM_HADDR_WORD_UNALIGNED_VIRT_SEQ_SV
