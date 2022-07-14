`ifndef RKV_AHBRAM_BASE_VIRTUAL_SEQUENCE_SV
`define RKV_AHBRAM_BASE_VIRTUAL_SEQUENCE_SV

class rkv_ahbram_base_virtual_sequence extends uvm_sequence;

  rkv_ahbram_config cfg;
  virtual rkv_ahbram_if vif;
  rkv_ahbram_rgm rgm;
  bit[31:0] wr_val, rd_val;
  uvm_status_e status;

  //element sequences
  rkv_ahbram_single_write_seq single_write;
  rkv_ahbram_single_read_seq single_read;

  `uvm_object_utils(rkv_ahbram_base_virtual_sequence)
  `uvm_declare_p_sequencer(rkv_ahbram_virtual_sequencer)

  function new (string name = "rkv_ahbram_base_virtual_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered...", UVM_LOW)
    //to do
    //get cfg from p_sequencer(virtual sequencer)
    cfg = p_sequencer.cfg;
    //get vif and rgm from cfg
    vif = cfg.vif;
    rgm = cfg.rgm;
    wait_ready_for_stim();
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

  //compare data
  virtual function void compare_data(logic[31:0] val1, logic[31:0] val2);
    cfg.seq_check_count++;
    if(val1 === val2)       
      `uvm_info("CMPSUC", $sformatf("val1 'h%0x === val2 'h%0x", val1, val2), UVM_LOW)
    else begin
      cfg.seq_check_error++;
      `uvm_error("CMPERR", $sformatf("val1 'h%0x !== val2 'h%0x", val1, val2))
    end
  endfunction

  task wait_reset_signal_assertted();
    @(posedge vif.rstn);
  endtask

  task wait_reset_signal_released();
    @(negedge vif.rstn);
  endtask

  task wait_cycles(int n =1);
    repeat(n) @(posedge vif.clk);
  endtask

  task wait_ready_for_stim();
    wait_reset_signal_released();
    wait_cycles(10);
  endtask
  
endclass

`endif//RKV_AHBRAM_BASE_VIRTUAL_SEQUENCE_SV

