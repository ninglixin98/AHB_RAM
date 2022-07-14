`ifndef RKV_AHBRAM_SCOREBOARD
`define RKV_AHBRAM_SCOREBOARD

class rkv_ahbram_scoreboard extends rkv_ahbram_subscriber;

  //typedef enum {CHECK_LOADCOUNTER} check_type_e;
  
  `uvm_component_utils(rkv_ahbram_scoreboard)

  function new (string name = "rkv_ahbram_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    do_data_check();
  endtask

  //control check enable and disable
  task do_listen_events();
    
  endtask

  //do check
  virtual task do_data_check();
    
  endtask

endclass

`endif//RKV_AHBRAM_SCOREBOARD
