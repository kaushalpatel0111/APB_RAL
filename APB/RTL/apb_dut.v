//---------------------------------------------------------------------------
// RTL Module: apb_dut
//---------------------------------------------------------------------------
`ifndef APB_DUT
`define APB_DUT

`include "../TOP/apb_define.sv"

`timescale 1ns/1ns
/*
module APB(
    input PCLK,
    input PRESETn,
    input PSEL,
    input PENABLE,
    input PWRITE,
    input [`ADDRWIDTH-1:0] PADDR,
    input [`DATAWIDTH-1:0] PWDATA,
    output reg [`DATAWIDTH-1:0] PRDATA,
    output reg PREADY,
    output PSLVERR
);

    // Memory
    reg [`DATAWIDTH-1:0] mem [0:`ADDRWIDTH-1];

    // FSM states
    reg [1:0] sstate;
    parameter [1:0] idle = 2'b00, setup = 2'b01, access = 2'b10;

    // Error signals
    reg error_addr, error_read, error_write;

    integer i;

    // ---------------------
    // Sequential FSM logic
    // ---------------------
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            sstate       <= idle;   // Initialize FSM State
            PREADY       <= 1'b0;
            PRDATA       <= `DATAWIDTH'b0;

            // Initialize memory
            for (i = 0; i < `ADDRWIDTH; i = i + 1) begin
                mem[i] <= `DATAWIDTH'b0;
            end

            // Initialize DUT Registers
            addr_reg <= 'b0;
            wdata_reg <= 'b0;
            rdata_reg <= 'b0;
        end
        else begin
            case (sstate)
                idle: begin
                    PREADY <= 1'b0;
                    if (PSEL)
                        sstate <= setup;
                end

                setup: begin
                    PREADY <= 1'b0;
                    if (PENABLE)
                        sstate <= access;
                end

                access: begin
                    if (PWRITE) begin
                        mem[PADDR] <= PWDATA;
                        PREADY <= 1'b1;
                    end 
                    else begin
                        PRDATA <= mem[PADDR];
                        PREADY <= 1'b1;
                    end

                    // Next state decision
                    if (!PSEL && !PENABLE && PREADY)
                        sstate <= idle;
                    else if (PSEL && !PENABLE && PREADY)
                        sstate <= setup;
                    else if (PSEL && PENABLE && !PREADY)
                        sstate <= access;
                end
            endcase
        end
    end

    // ---------------------
    // Error Detection Logic
    // ---------------------
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            error_addr  <= 1'b0;
            error_read  <= 1'b0;
            error_write <= 1'b0;
        end else begin
            error_addr  <= (PADDR === `ADDRWIDTH'bx) && PSEL;
            error_read  <= (!PWRITE && (PRDATA === `DATAWIDTH'bx)) && PSEL;
            error_write <= (PWRITE && (PWDATA === `DATAWIDTH'bx)) && PSEL;
        end
    end

    assign PSLVERR = error_addr || error_read || error_write;

endmodule
*/
module APB 
(  
    input PCLK,
    input PRESETn,
    input PSEL,
    input PENABLE,
    input PWRITE,
    input [`ADDRWIDTH-1:0] PADDR,
    input [`DATAWIDTH-1:0] PWDATA,
    output [`DATAWIDTH-1:0] PRDATA
);
// "RW" Registers 
  reg [3:0]  cntrl = 0;           // cntrl :  [reg4 reg3 reg2 reg1]
  reg [`DATAWIDTH-1:0] reg1  = 0; // datainput 1
  reg [`DATAWIDTH-1:0] reg2  = 0; // datainput 2
  reg [`DATAWIDTH-1:0] reg3  = 0; // datainput 3
  reg [`DATAWIDTH-1:0] reg4  = 0; // datainput 4
// "WO" Registers
  reg [`DATAWIDTH-1:0] reg5  = 0; // tmp_wdata
// "RO" Registers
  reg [`DATAWIDTH-1 : 0] rdata_tmp = 0;
   
    // Set all registers to default values
    always @ (posedge PCLK) 
      begin
        if(!PRESETn) 
        begin
           cntrl    <= 4'b0000;
           reg1     <= 32'h00000000;
           reg2     <= 32'h00000000;
           reg3     <= 32'h00000000;
           reg4     <= 32'h00000000;
          rdata_tmp <= 32'h00000000;
        end
    // Update values of register
    else if(PSEL && PENABLE && PWRITE)
      begin
        case(PADDR)
                'h0     : cntrl <= PWDATA;
                'h4     : reg1  <= PWDATA;
                'h8     : reg2  <= PWDATA;
                'hc     : reg3  <= PWDATA;
                'h10    : reg4  <= PWDATA;
        endcase
      end
      else if (PSEL && PENABLE && !PWRITE)
        begin
           case(PADDR)
                'h0     : rdata_tmp <= {28'h0000000,cntrl};
                'h4     : rdata_tmp <= reg1;
                'h8     : rdata_tmp <= reg2;
                'hc     : rdata_tmp <= reg3;
                'h10    : rdata_tmp <= reg4;
                default : rdata_tmp <= 32'h00000000;
           endcase
        end  
    end
  
    assign PRDATA =  rdata_tmp;
  
    always @(posedge PCLK) begin
        $display("-------------------------------------------[DUT]-------------------------------------------");
        $display("At %0t(ns): cntrl = %h, reg1 = %h, reg2 = %h, reg3 = %h, reg4 = %h", $time, cntrl, reg1, reg2, reg3, reg4);
        $display("-------------------------------------------------------------------------------------------");
    end
endmodule

`endif
