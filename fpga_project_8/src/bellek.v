module port (
  clk         , 
  addr        , 
  data        , 
  cs          , 
  we          , 
  oe            
  ); 
  
  parameter DATA_WIDTH = 16 ;
  parameter ADDR_WIDTH = 4 ;
  parameter RAM_DEPTH = 16 ;
  

  input                  clk         ;
  input [ADDR_WIDTH-1:0] addr        ;
  input                  cs          ;
  input                  we          ;
  input                  oe          ; 
  

  inout [DATA_WIDTH-1:0]  data       ;
  

  reg [DATA_WIDTH-1:0] data_out ;
  reg [DATA_WIDTH-1:0] mem ;  
  

  always @ (posedge clk)
  begin : MEM_WRITE
     if ( cs && we ) begin
         mem[addr] <= data;
     end
  end
 

  always @ (negedge clk)
  begin : MEM_READ
    if (cs &&  ! we && oe) begin
      data_out <= mem[addr];
    end
  end
    assign data = (cs && oe &&  ! we) ? data_out : 'bz; 

  endmodule