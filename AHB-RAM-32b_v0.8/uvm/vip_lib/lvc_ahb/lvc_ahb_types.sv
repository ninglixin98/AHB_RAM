`ifndef LVC_AHB_TYPES_SV
`define LVC_AHB_TYPES_SV

  typedef enum bit[1:0] {
    OKAY  = 2'b00, //okay response
    ERROR = 2'b01, //error response
    RETRY = 2'b10, //retry response
    SPLIT = 2'b11 //split response
  } response_type_enum;
  
  typedef enum bit[1:0] {
    IDLE  = 2'b00, //idle transaction 
    BUSY  = 2'b01, //busy transaction
    NSEQ  = 2'b10, //nonsequential transaction
    SEQ   = 2'b11   //sequential transaction
  } trans_type_enum;

  typedef enum bit[2:0] {
    BURST_SIZE_8BIT     = 3'b000, // 8-bits transfer size
    BURST_SIZE_16BIT    = 3'b001, // 16-bits transfer size
    BURST_SIZE_32BIT    = 3'b010, // 32-bits transfer size
    BURST_SIZE_64BIT    = 3'b011, // 64-bits transfer size  
    BURST_SIZE_128BIT   = 3'b100, // 128-bits transfer size
    BURST_SIZE_256BIT   = 3'b101, // 256-bits transfer size
    BURST_SIZE_512BIT   = 3'b110, // 512-bits transfer size
    BURST_SIZE_1024BIT  = 3'b111 // 1024-bits transfer size
  } burst_size_enum;

  typedef enum bit[2:0] {
    SINGLE  = 3'b000, // SINGLE BURST type
    INCR    = 3'b001, // INCR   BURST type
    WRAP4   = 3'b010, // 4-beat WRAP  BURST type
    INCR4   = 3'b011, // 4-beat INCR  BURST type
    WRAP8   = 3'b100, // 8-beat WRAP  BURST type
    INCR8   = 3'b101, // 8-beat INCR  BURST type
    WRAP16  = 3'b110, // 16-beat WRAP BURST type
    INCR16  = 3'b111 // 16-beat INCR BURST type
  } burst_type_enum;

  typedef enum bit[1:0] {
    READ      = 2'b00, //read transaction
    WRITE     = 2'b01, //write transaction
    IDLE_XACT = 2'b10  //idle transaction
  } xact_type_enum;

  typedef enum bit[1:0] {
    INITIAL         = 2'b00,
    PARTIAL_ACCEPT  = 2'b01,
    ACCEPT          = 2'b10,
    ABORTED         = 2'b11 

  } status_enum;

`endif//LVC_AHB_TYPES_SV

