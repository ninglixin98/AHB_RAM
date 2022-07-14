`ifndef RKV_AHBRAM_SMOKE_VIRT_SEQ_SV
`define RKV_AHBRAM_SMOKE_VIRT_SEQ_SV

class rkv_ahbram_smoke_virt_seq extends rkv_ahbram_base_virtual_sequence;
  `uvm_object_utils(rkv_ahbram_smoke_virt_seq)

  function new (string name = "rkv_ahbram_smoke_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass



`endif//RKV_AHBRAM_SMOKE_VIRT_SEQ_SV
