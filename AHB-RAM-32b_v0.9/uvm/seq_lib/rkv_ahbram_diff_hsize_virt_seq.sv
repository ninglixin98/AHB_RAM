`ifndef RKV_AHBRAM_DIFF_HSIZE_VIRT_SEQ_SV
`define RKV_AHBRAM_DIFF_HSIZE_VIRT_SEQ_SV

class rkv_ahbram_diff_hsize_virt_seq extends rkv_ahbram_base_virtual_sequence;
  `uvm_object_utils(rkv_ahbram_diff_hsize_virt_seq)

  function new (string name = "rkv_ahbram_diff_hsize_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    burst_size_enum bsize;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i<100; i++) begin
      std::randomize(addr) with {addr[1:0] == 0; addr inside {['h1000:'h1FFF]};};
      std::randomize(wr_val) with {wr_val == (i << 8) + i;};
      std::randomize(bsize) with {bsize inside {BURST_SIZE_8BIT, BURST_SIZE_16BIT, BURST_SIZE_32BIT};};
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data; bsize == local::bsize;})
      `uvm_do_with(single_read, {addr == local::addr; bsize == local::bsize;})
      rd_val = single_read.data;
      case(bsize)
        BURST_SIZE_8BIT  : compare_data(wr_val & 32'hFF, rd_val & 32'hFF);
        BURST_SIZE_16BIT : compare_data(wr_val & 32'hFFFF, rd_val & 32'hFFFF);
        BURST_SIZE_32BIT : compare_data(wr_val, rd_val);
        default          : `uvm_error("TYPEERR", "burst size not recognized")
      endcase
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//RKV_AHBRAM_DIFF_HSIZE_VIRT_SEQ_SV
