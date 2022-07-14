`ifndef LVC_AHB_IF_SV
`define LVC_AHB_IF_SV

interface lvc_ahb_if;
  `include "lvc_ahb_defines.svh"
  
  logic                                   hclk;
  logic                                   hresetn;
  
  logic                                   hgrant;
  logic [(`LVC_AHB_MAX_DATA_WIDTH - 1):0] hrdata;
  logic                                   hready;
  logic [1:0]                             hresp;
  logic [(`LVC_AHB_MAX_ADDR_WIDTH - 1):0] haddr;
  logic [2:0]                             hburst;
  logic                                   hbusreq;
  logic                                   hlock;
  logic [3:0]                             hprot;
  logic [2:0]                             hsize;
  logic [1:0]                             htrans;
  logic [(`LVC_AHB_MAX_DATA_WIDTH - 1):0] hwdata;
  logic                                   hwrite;

endinterface

`endif//LVC_AHB_IF_SV
