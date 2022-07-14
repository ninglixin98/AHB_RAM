`ifndef LVC_AHB_MONITOR_SV
`define LVC_AHB_MONITOR_SV

class lvc_ahb_monitor extends uvm_monitor;
  
  uvm_analysis_port #(lvc_ahb_transaction) item_observed_port;
  `uvm_component_utils(lvc_ahb_monitor)

  function new(string name = "lvc_ahb_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_observed_port = new("item_observed_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass


`endif//LVC_AHB_MONITOR_SV
