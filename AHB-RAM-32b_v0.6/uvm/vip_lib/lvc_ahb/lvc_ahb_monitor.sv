`ifndef LVC_AHB_MONITOR_SV
`define LVC_AHB_MONITOR_SV

class lvc_ahb_monitor extends uvm_monitor;
  virtual lvc_ahb_if vif;
  lvc_ahb_agent_configuration cfg;
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
    fork
      monitor_transaction();
    join_none
  endtask

  task monitor_transactions();
    lvc_ahb_transaction t;
    forever begin
      collect_transfer(t);
      item_observed_port.write(t);
    end
  endtask


  task collect_transfer(output lvc_ahb_transaction t);
    // collect transfer from interface
    t = lvc_ahb_transfer::type_id::create("t");
    @(vif.cb_mon iff vif.cb_mon.htrans == NSEQ);
    t.trans_type = trans_type_enum'(vif.cb_mon.htrans);
    t.xact_type = xact_type_enum'(vif.cb_mon.hwrite);
    forever begin
      monitor_valid_data(t);
      if(t.trans_type == IDLE)
        break;
    end
  endtask

 /* task monitor_trans_start(lvc_ahb_transaction t);
    @(vif.cb_mon iff vif.cb_mon.htrans == NSEQ);
    t.trans_type = trans_type_enum'(vif.cb_mon.htrans);
    t.xact_type = xact_type_enum'(vif.cb_mon.hwrite);
    fork
      begin
        monitor_valid_data(t);
      end
    join_none
  endtask */

  task monitor_valid_data(lvc_ahb_transaction t);
    @(vif.cb_mon iff vif.cb_mon.hready);
    //t.data = new[t.data.size() + 1]t.data;
    //t.data = new[1];
    t.increase_data();
    t.data[0] = t.xact_type == WRITE ? vif.cb_mon.hwdata : vif.cb_mon.hrdata;
    //t.all_beat_response = new[1];
    t.current_data_beat_num = t.data.size() - 1;
    t.all_beat_response[t.current_data_beat_num] = response_type_enum'(vif.cb_mon.hresp);
    t.trans_type = trans_type_enum'(vif.cb_mon.htrans);
  endtask

  task monitor_trans_proc(lvc_ahb_transaction t);
  endtask

endclass


`endif//LVC_AHB_MONITOR_SV
