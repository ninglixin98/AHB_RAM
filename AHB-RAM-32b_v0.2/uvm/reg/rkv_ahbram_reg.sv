`ifndef RKV_AHBRAM_REG_SV
`define RKV_AHBRAM_REG_SV

class rkv_ahbram_rgm extends uvm_reg_block;
  
  `uvm_object_utils(rkv_ahbram_rgm)

  uvm_reg_map map;
  function new(string name = "rkv_ahbram_rgm");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function build();
    map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN);
  endfunction


endclass

`endif//RKV_AHBRAM_REG_SV

