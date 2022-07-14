`ifndef RKV_AHBRAM_COV_SV
`define RKV_AHBRAM_COV_SV

class rkv_ahbram_cov extends rkv_ahbram_subscriber;

  `uvm_component_utils(rkv_ahbram_cov)

  function new (string name = "rkv_ahbram_cov", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task do_listen_events();
  endtask
  
endclass



`endif//RKV_AHBRAM_COV_SV
