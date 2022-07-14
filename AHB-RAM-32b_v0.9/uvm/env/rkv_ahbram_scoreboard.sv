`ifndef RKV_AHBRAM_SCOREBOARD
`define RKV_AHBRAM_SCOREBOARD

class rkv_ahbram_scoreboard extends rkv_ahbram_subscriber;

  bit [31:0] mem [int unsigned];

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

  virtual function void write(lvc_ahb_transaction tr);
    if(is_addr_valid(tr.addr)) begin
      case(tr.xact_type)
        WRITE : store_data_with_hburst(tr);
        READ  : check_data_with_hburst(tr);
      endcase
    end
  endfunction

  //control check enable and disable
  task do_listen_events();
  endtask

  //do check
  virtual task do_data_check();
  endtask

  function bit is_addr_valid(bit [31:0] addr);
    if(addr >= cfg.addr_start && addr <= cfg.addr_end)
      return 1;
  endfunction

  function void store_data_with_hburst(lvc_ahb_transaction tr);
    case(tr.burst_type)
      SINGLE :begin
                store_data_with_hsize(tr, 0);
              end
      INCR   :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP4  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR4  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP8  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR8  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP16 :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR16 :begin `uvm_error("TYPEERR","burst type not supported yet") end
      default:begin `uvm_error("TYPEERR","burst type not defined") end 
    endcase
  endfunction

  function bit check_data_with_hburst(lvc_ahb_transaction tr);
    case(tr.burst_type)
      SINGLE :begin
                check_data_with_hburst = (check_data_with_hsize(tr, 0));
              end
      INCR   :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP4  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR4  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP8  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR8  :begin `uvm_error("TYPEERR","burst type not supported yet") end
      WRAP16 :begin `uvm_error("TYPEERR","burst type not supported yet") end
      INCR16 :begin `uvm_error("TYPEERR","burst type not supported yet") end
      default:begin `uvm_error("TYPEERR","burst type not defined") end 
    endcase
    if(check_data_with_hburst)
      `uvm_info("DATACHECK", $sformatf("ahbram[%0x] hburst[%s] is as expected", tr.addr, tr.burst_type), UVM_HIGH)
    else
      `uvm_error("DATACHECK", $sformatf("ahbram[%0x] hburst[%s] is NOT as expected", tr.addr, tr.burst_type))
  endfunction

  function void store_data_with_hsize(lvc_ahb_transaction tr, int beat);
    case(tr.burst_size)
      BURST_SIZE_8BIT  : mem[{tr.addr[31:2],2'b00}] = extract_current_beat_mem_data(tr, beat);
      BURST_SIZE_16BIT : mem[{tr.addr[31:2],2'b00}] = extract_current_beat_mem_data(tr, beat);
      BURST_SIZE_32BIT : mem[{tr.addr[31:2],2'b00}] = extract_current_beat_mem_data(tr, beat);
      BURST_SIZE_64BIT :begin `uvm_error("TYPEERR","burst size not supportde") end
      default:begin `uvm_error("TYPEERR","burst size not supportde") end
    endcase
  endfunction

  function bit check_data_with_hsize(lvc_ahb_transaction tr, int beat);
    bit[31:0] tdata = extract_valid_data(tr.data[beat], tr.addr, tr.burst_size);
    bit[31:0] mdata = extract_valid_data(mem[{tr.addr[31:2],2'b00}], tr.addr, tr.burst_size);

    check_data_with_hsize = tdata == mdata ? 1 : 0;
  /* case(tr.burst_size)
      BURST_SIZE_8BIT  : begin data = tr.data[beat]; if(mem[tr.addr] == data) check_data_with_hsize = 1; end
      BURST_SIZE_16BIT : begin data = tr.data[beat]; if(mem[tr.addr] == data) check_data_with_hsize = 1; end
      BURST_SIZE_32BIT : begin data = tr.data[beat]; if(mem[tr.addr] == data) check_data_with_hsize = 1; end
      BURST_SIZE_64BIT : begin `uvm_error("TYPEERR","burst size not supportde") end
      default:begin `uvm_error("TYPEERR","burst size not supportde") end
    endcase
    */
    cfg.scb_check_count++;
    if(check_data_with_hsize)
      `uvm_info("DATACHECK", $sformatf("ahbram[%0x] data expected 'h%0x = actual 'h%0x", tr.addr, mdata, tdata), UVM_HIGH)
    else begin
      cfg.scb_check_error++;
      `uvm_error("DATACHECK", $sformatf("ahbram[%0x] data expected 'h%0x != actual 'h%0x", tr.addr, mdata, tdata))
    end
  endfunction

  function bit[31:0] extract_current_beat_mem_data(lvc_ahb_transaction tr, int beat);
    bit [31:0] mdata = mem[{tr.addr[31:2],2'b00}];
    bit [31:0] tdata = tr.data[beat];
    case(tr.burst_size)
      BURST_SIZE_8BIT  : mdata[(tr.addr[1:0]*8 + 7) -: 8] = tdata >> (8*tr.addr[1:0]);
      BURST_SIZE_16BIT : mdata[(tr.addr[1]*16 + 15) -: 16] = tdata >> (16*tr.addr[1]);
      BURST_SIZE_32BIT : mdata = tdata;
      BURST_SIZE_64BIT :begin `uvm_error("TYPEERR","burst size not supportde") end
      default:begin `uvm_error("TYPEERR","burst size not supportde") end
    endcase
    return mdata;
  endfunction

endclass

`endif//RKV_AHBRAM_SCOREBOARD
